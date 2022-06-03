begin
  avatars = 0
  Dotcom.all.each do |dotcom|
    relative_filename = "#{dotcom.name.downcase}.png"
    # Get sources from iCloud
    source_dir = "/Users/zhenya/Library/Mobile Documents/com~apple~CloudDocs/Development/Projects/Tra/Logos/Dotcoms"
    source_file = "#{source_dir}/#{relative_filename}"

    if File.exist? source_file and not dotcom.avatar.present?
      dotcom.avatar.attach io: File.open(source_file), filename: relative_filename
      avatars += 1
    end
  end
  puts "===== #{avatars} Dotcom avatars uploaded"
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end