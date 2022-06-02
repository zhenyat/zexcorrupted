module ZexHelper
  ##############################################################################
  #   Hides secret values 
  ##############################################################################
  def key_tail value
    "#{'*'*10} #{value.last(4)}"
  end

  ##############################################################################
  #   Generate a table body with hash data
  ##############################################################################
  def table_body collection = {}
    tbody = content_tag :tbody do
      collection.collect { |key, value|
       content_tag :tr do
          concat content_tag(:td, key)
          concat content_tag(:td, value)
        end
      }.join().html_safe
    end 
    content_tag :table, tbody, class: ["table", "table-striped"]
  end

  # Probe
  def mytable
    tag.table(class: ['table', 'table-striped']) do
      concat(tag.tr)
        concat(tag.td 'key1')
        concat(tag.td 'value1')
        concat(tag.tr)
        concat(tag.td 'key2')
        concat(tag.td 'value2')
    end
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
end
