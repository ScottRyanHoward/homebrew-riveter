class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/ScottRyanHoward/riveter"
  version "0.11.10"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.10/riveter-0.11.10-macos-intel.tar.gz"
    sha256 "db5db7f392dc378a368b35691c9d2e97a8e4995a57bc72f4685d1e269dcac3e3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.10/riveter-0.11.10-macos-arm64.tar.gz"
    sha256 "8da710de9647cb3c90ff929d985e09e183c5672f1b01a854f745f1f8e5986e13"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.10/riveter-0.11.10-linux-x86_64.tar.gz"
    sha256 "514ae950f8c709aa5f974dc8a3bd666df1c74716061bb43f15aa97e5b81946ea"
  end

  def install
    bin.install "riveter"
  end

  test do
    # Test that the binary runs and shows version
    assert_match "0.11.10", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output
  end
end
