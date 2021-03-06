require "spec_helper"

describe JsHelper do
  context '#set_spinner_off' do
    it 'returns js to turn spinner off' do
      set_spinner_off.should eq('miqSparkleOff();')
    end
  end

  context '#set_element_visible' do
    it 'returns js to hide element' do
      set_element_visible('foo', false).should eq("if ($j('\#foo').length) $j('\#foo').hide();")
    end

    it 'returns js to show element' do
      set_element_visible('foo', true).should eq("if ($j('\#foo').length) $j('\#foo').show();")
    end
  end

  context '#tree_lock' do
    it 'returns js to lock tree' do
      tree_lock('bar',true).should eq(
    "
      $j('#barbox').dynatree('disable');
      miqDimDiv('\#bar_div', true);
    ")
    end

    it 'returns js to unlock tree' do
      tree_lock('bar',false).should eq(
    "
      $j('#barbox').dynatree('enable');
      miqDimDiv('\#bar_div', false);
    ")
    end
  end

  context '#update_element' do
  end

  context '#javascript_focus' do
    it 'returns js to focus on an element' do
      javascript_focus('foo').should eq("$j('#foo').focus();")
    end
  end

  context '#javascript_focus_if_exists' do
    it 'returns js to check for the existence of an element and focus on the element if it exists' do
      javascript_focus_if_exists('foo').should eq("if ($j('#foo').length) $j('#foo').focus();")
    end
  end

  context '#javascript_highlight' do
    it 'returns js to to add or remove the active class on the element' do
      javascript_highlight('foo', true).should eq("miqHighlight('\#foo', true);")
      javascript_highlight('foo', false).should eq("miqHighlight('\#foo', false);")
    end
  end

  context '#javascript_dim' do
    it 'returns js to to add or remove the dimmed class on the element' do
      javascript_dim('foo', true).should eq("miqDimDiv('\#foo', true);")
      javascript_dim('foo', false).should eq("miqDimDiv('\#foo', false);")
    end
  end

  context '#javascript_add_class' do
    it 'returns js to add a class on the element' do
      javascript_add_class('foo', 'bar').should eq("$j('\#foo').addClass('bar');")
    end
  end

  context '#javascript_del_class' do
    it 'returns js to remove a class on the element' do
      javascript_del_class('foo', 'bar').should eq("$j('\#foo').removeClass('bar');")
    end
  end

  context '#javascript_show' do
    it 'returns js to show an element' do
      javascript_show('foo').should eq("$j('#foo').show();")
    end
  end

  context '#javascript_hide' do
    it 'returns js to hide an element' do
      javascript_hide('foo').should eq("$j('#foo').hide();")
    end
  end

  context '#javascript_show_if_exists' do
    it 'returns js to check for the existence of an element and show the element if it exists' do
      javascript_show_if_exists('foo').should eq("if ($j('#foo').length) $j('#foo').show();")
    end
  end

  context '#javascript_hide_if_exists' do
    it 'returns js to check for the existence of an element and hide the element if it exists' do
      javascript_hide_if_exists('foo').should eq("if ($j('#foo').length) $j('#foo').hide();")
    end
  end
end
