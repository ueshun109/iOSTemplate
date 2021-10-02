require "pty"
require "expect"
require "fastlane"
require "spaceship"

def fastlane_spaceauth
  cmd = "bundle exec fastlane spaceauth"
  PTY.spawn(cmd) do |i, o|
    o.sync = true

    i.expect("Pass the following via the FASTLANE_SESSION environment variable:", 10) do |match|
      if match
        begin
          while (i.eof? == false)
            i.expect("🙄 Should fastlane copy the cookie into your clipboard, so you can easily paste it? (y/n)", 10) do |match|
              o.puts "y"
            end
          end
        rescue Errno::EIO
        end
      else 
        puts "Please execute `make generate-fastlane-session` and enter 6 digit code for 2FA."
      end
    end
  end
end

fastlane_spaceauth