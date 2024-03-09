# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  desc "naiveproxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  # download binary from upstream directly
  url "https://github.com/klzgrad/naiveproxy/releases/download/v122.0.6261.43-1/naiveproxy-v122.0.6261.43-1-mac-arm64.tar.xz"
  version "v122.0.6261.43-1"
  sha256 "b9875eddbf9c20bedd811d85e4fde76f48a9c47bb8d22d4eceb79ba6b0c91d73"
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

  service do
    run [opt_bin/"naive", etc/"naiveproxy/config.json"]
    run_type :immediate
    keep_alive true
    log_path var/"log/naive.log"
    error_log_path var/"log/naive.error.log"
  end
end