class MiqUserScope
  FEATURE_TYPES = [:view, :control, :admin]
  attr_accessor *FEATURE_TYPES
  attr_accessor :scope

  FILTER_TYPES = [:managed, :belongsto, :expression]

  def initialize(scope)
    @scope = scope
    FEATURE_TYPES.each {|f| instance_variable_set("@#{f}", scope[f])}
  end

  def get_filters(options={})
    # Options:
    # => :feature_type => view | admin | control
    # => :class        => Vm, Host, etc.
    feature_type = options[:feature_type]
    raise "No value provided for option :feature_type" if feature_type.nil?

    klass = options[:class]
    raise "No value provided for option :class" if klass.nil?

    result = {}
    FILTER_TYPES.each {|filter_type| result[filter_type] = self.filters_by_class_feature_filter(klass, feature_type, filter_type)}

    return result
  end

  def filters_by_class_feature_filter(klass, feature_type, filter_type)
    raise "Filter type must be one of #{FILTER_TYPES.inspect}" unless FILTER_TYPES.include?(filter_type.to_sym)

    filter = self.scope.fetch_path(feature_type.to_sym, filter_type.to_sym)
    return if filter.nil?

    all       = filter[:_all_]
    for_class = filter[klass.to_s.downcase.to_sym]
    result    = self.send("merge_#{filter_type}", all, for_class)

    return result.blank? ? nil : result
  end

  def merge_managed(*args)
    grouped = args.flatten.compact.group_by {|v| v.split("/")[0..2]}
    grouped.values.collect {|inner| inner.uniq}
  end

  def merge_belongsto(*args)
    # TODO: Optimize to remove items that are descendants of others in the list.
    args.flatten.compact.uniq
  end

  def merge_expression(*args)
    args = args.compact
    return args.first if args.length == 1

    exps = args.inject([]) do |a, exp|
      a << exp.exp
    end
    return exps.empty? ? nil : MiqExpression.new("or" => exps)
  end

  def self.hash_to_scope(hash)
    # Convert original hash style filters to MiqUserScope instance
    managed = hash["managed"]   if hash.has_key?("managed")
    belongs = hash["belongsto"] if hash.has_key?("belongsto")
    return if managed.blank? && belongs.blank?

    newh = {:view => {}}
    newh[:view][:managed]   = {:_all_ => managed} unless managed.blank?
    newh[:view][:belongsto] = {:_all_ => belongs} unless belongs.blank?

    self.new(newh)
  end
end
