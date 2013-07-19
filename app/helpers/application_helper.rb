require 'MyString'

module ApplicationHelper
  def editor_rel
    return '' if @browser.android? || @browser.ios?
    return 'wysihtml5'
  end

  def format_autocomplete(items)
    sane_items = items.map { |i| i.format_autocomplete() }
    return "[\"#{items.join('", "')}\"]"
  end

  def error_class(object, field)
    begin
      if object.errors.invalid?(field)
        return 'error'
      end
    rescue
    end
    return ''
  end

  def error_help(object, field)
    begin
      if object.errors.invalid?(field)
        msg = ""
        object.errors[field].each do |err_msg|
          msg = "#{msg} <span class=\"help-inline\">#{err_msg}</span>"
        end
        return msg
      end
    rescue
    end
    return ''
  end

  ## Helper method for deciding if an error class should be emitted
  ## for a particular field of an active record.
  def error_class_for(object, field)
    return '' if object.nil?
    return '' if object.errors.nil? rescue return ''
    # has an errors field
    return 'error' unless object.errors[field].nil? rescue ''
    ''
  end

  def tab_active(tabObj, tabName)
    return false if tabObj.nil?
    return tabName.eql?(tabObj)
  end
end
