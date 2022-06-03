begin
  avatars = 0
  Coin.all.each do |coin|
    relative_filename = "#{coin.code.downcase}.png"
    # Get sources from iCloud
    if coin.crypto?
      source_dir = "/Users/zhenya/Library/Mobile Documents/com~apple~CloudDocs/Development/Projects/Tra/Logos/Coins/Crypto"
    else
      source_dir = "/Users/zhenya/Library/Mobile Documents/com~apple~CloudDocs/Development/Projects/Tra/Logos/Coins/Fiat"
    end
    source_file = "#{source_dir}/#{relative_filename}"

    if File.exist? source_file and not coin.avatar.present?
      coin.avatar.attach io: File.open(source_file), filename: relative_filename
      avatars += 1
    end
  end
  puts "===== #{avatars} Coin avatars uploaded"
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end