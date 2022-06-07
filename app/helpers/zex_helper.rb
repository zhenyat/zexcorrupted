module ZexHelper
  ##############################################################################
  #   Classical Table tag: for ActiveRecord Object
  #   e.g.
  #     <%= display_standard_table(
  #       [
  #         { :name => 'last_name', :display_name => 'Last name' },
  #         { :name => 'first_name', :display_name => 'First name' },
  #         { :name => 'email',     :display_name => 'email' },
  #         { :name => 'role',      :display_name => 'role' }
  #       ], @users) %>
  #
  #   http://www.javawenti.com/?post=426796
  ##############################################################################
  def display_standard_table(columns, collection = {})
    thead = content_tag :thead do
      content_tag :tr do
        columns.collect {|column|  
          concat content_tag(:th,column[:display_name])
        }.join().html_safe 
      end
    end 
    tbody = content_tag :tbody do
      collection.collect { |elem|
        content_tag :tr do
          columns.collect { |column|
            concat content_tag(:td, elem.attributes[column[:name]])
          }.to_s.html_safe
        end  
      }.join().html_safe
    end
    content_tag :table, thead.concat(tbody), class: "table table-hover"
  end

  ##############################################################################
  #   Merges images
  ##############################################################################
  def images_tag(array_of_images, options={})
    images = []
    if array_of_images.is_a? Array and array_of_images.length >= 2
      array_of_images.each do |image|
        images << image_tag(image, size: options[:size], class: options[:class])
      end
    end
    content_tag :span, images.join("\n").html_safe, class: "img-circle"
    # content_tag :div, images.join("\n").html_safe, class: "img-circle"
  end

  ##############################################################################
  #   Hides secret values 
  ##############################################################################
  def key_tail value
    "#{'*'*10} #{value.last(4)}"
  end

  def show_time timestamp
    Time.at(timestamp/1000).strftime('%Y-%m-%d %H:%M:%S')
  end

  ##############################################################################
  #   Generates a table body with hash data
  ##############################################################################
  def table_body collection = {}
    tbody = content_tag :tbody do
      collection.collect { |key, value|
        content_tag :tr do
      # content_tag(:tr, class: "table-warning") do   #colorizing
          concat content_tag(:td, key)
          concat content_tag(:td, value)
        end
      }.join().html_safe
    end 
    content_tag :table, tbody, class: "table table-hover"
  end

end