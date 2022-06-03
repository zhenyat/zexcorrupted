begin
  if (Api.present? and not Api.exists?)
    Dotcom.active.each do |dotcom|
      Api.modes.each do |mode|
        Api.create(
          dotcom:   dotcom, mode: mode.second,
          user:     Rails.application.credentials.config[dotcom.name.to_sym][mode.first.to_sym][:user],
          base_url: Rails.application.credentials.config[dotcom.name.to_sym][mode.first.to_sym][:base_url],
          path:     Rails.application.credentials.config[dotcom.name.to_sym][mode.first.to_sym][:path],
          key:      Rails.application.credentials.config[dotcom.name.to_sym][mode.first.to_sym][:key]
          # !! Don't save secret in DB
        )

      end
    end
    puts "===== 'Api' #{Api.count} record(s) created"
  else
    puts "===== 'Api' seeding skipped"
  end
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end
