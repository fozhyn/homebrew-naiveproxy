# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  desc "naiveproxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  # download binary from upstream directly
  url "https://github.com/klzgrad/naiveproxy/releases/download/v116.0.5845.92-2/naiveproxy-v116.0.5845.92-2-mac-arm64.tar.xz"
  version "v116.0.5845.92-2"
  sha256 "9e4a554f77b9d67d6e6c9dda97ba5963d160b651d04c7d44b6660b6f53d81ff0"
  license "BSD 3-Clause"

  def install
    bin.install "naive"
    (etc/"naiveproxy").mkpath
    etc.install "config.json" => "naiveproxy/config.json-example"
  end

  def caveats
    <<~EOS
      client config example has been installed to #{etc}/naiveproxy/config.json-example
      please modify it and rename to config.json
    EOS
  end

  test do
    system "#{bin}/naive", "--version"
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <true/>
          <key>RunAtLoad</key>
          <true/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{bin}/naive</string>
            <string>#{etc}/naiveproxy/config.json</string>
          </array>
          <key>StandardErrorPath</key>
          <string>/opt/homebrew/var/log/naive.log</string>
          <key>StandardOutPath</key> 
          <string>/opt/homebrew/var/log/naive.log</string>
        </dict>
      </plist>
    EOS
  end
end