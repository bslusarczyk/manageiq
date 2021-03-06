require "spec_helper"

describe MiqRegion do
  REGION_FILE = File.join(Rails.root, "REGION")
  def read_region
    (File.open(REGION_FILE, 'r') {|f| f.read }).chomp if File.exist?(REGION_FILE)
  end

  def write_region(number)
    File.open(REGION_FILE, 'w') {|f| f.write(number) } if File.exist?(REGION_FILE)
  end

  before(:each) do
    MiqRegion.delete_all
  end

  it "should have 0 records in the miq_regions table" do
    MiqRegion.count.should == 0
  end

  context "after seeding" do
    before(:each) do
      MiqRegion.seed
    end

    it "should have 1 record in the miq_regions table" do
      MiqRegion.count.should == 1
    end

    context "with cloud and infra EMSes" do

      before :each do
        guid, server, zone = EvmSpecHelper.create_guid_miq_server_zone
        ems_vmware = FactoryGirl.create(:ems_vmware, :zone => zone)
        ems_openstack = FactoryGirl.create(:ems_openstack, :zone => zone)
        ems_redhat = FactoryGirl.create(:ems_redhat, :zone => zone)

        @ems_clouds = [ems_openstack]
        @ems_infras = [ems_redhat, ems_vmware]

        @region = MiqRegion.my_region
      end

      it "should be able to return the list of ems_clouds" do
        @region.ems_clouds.should include(*@ems_clouds)
        @region.ems_clouds.should_not include(*@ems_infras)
      end

      it "should be able to return the list of ems_infras" do
        @region.ems_infras.should include(*@ems_infras)
        @region.ems_infras.should_not include(*@ems_clouds)
      end
    end
  end

  context "with two regions" do
    before(:each) do
      @orig_region = self.read_region if File.exist?(REGION_FILE)
      @orig_region ||= 0
      @region = FactoryGirl.create(:miq_region, :region => @orig_region)
      @other_region = FactoryGirl.create(:miq_region)
    end

    it "finds record with original region number" do
      MiqRegion.exists?(:region => @orig_region).should be_true
    end

    it "should have different region values" do
      @region.region.should_not == @other_region.region
    end

    it "should have 2 records in the miq_regions table" do
      MiqRegion.count.should == 2
    end

    context "after seeding" do
      before(:each) do
        MiqRegion.seed
      end

      it "should find region" do
        MiqRegion.exists?(:region => @orig_region).should be_true
      end
    end

    context "then original destroyed" do
      before(:each) do
        @region.destroy
      end

      it "should not find region" do
        MiqRegion.exists?(:region => @orig_region).should_not be_true
      end

      context "after seeding" do
        before(:each) do
          MiqRegion.seed
        end

        it "should find region" do
          MiqRegion.exists?(:region => @orig_region).should be_true
        end
      end
    end

    context "with MiqDatabase" do
      before(:each) do
        @db = FactoryGirl.create(:miq_database)
      end

      it "will raise Exception if my_region_number is not the db region" do
        MiqRegion.stub(:my_region_number).and_return(@other_region.region)
        MiqRegion.my_region_number.should_not == @db.region_id
        lambda { MiqRegion.seed }.should raise_error(Exception)
      end
    end
  end
end
