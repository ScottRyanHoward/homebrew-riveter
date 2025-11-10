class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.13.7"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.7/riveter-0.13.7-macos-intel.tar.gz"
    sha256 "0a1a09d3730a76a855b2e9ba6a42ade30f8fc5f550a8b2d96e6fac384637b30e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.7/riveter-0.13.7-macos-arm64.tar.gz"
    sha256 "b9ebb7bf87a0d58707ae97f1f39aa89b6ad4f68fce3f6fa066b2e9f379365b72"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.7/riveter-0.13.7-linux-x86_64.tar.gz"
    sha256 "8d1f4d27dc5f99089b212adc502dc52469d0bbe763030affc9b08d6b730302cb"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.13.7.tar.gz"
    sha256 "66f64ba1b60b436b26b00ae2585d1e27e900dc1b5d2eed2f60db0a594c041421"
  end

  def install
    bin.install "riveter"

    # Install rule packs
    resource("rule_packs").stage do
      (share/"riveter/rule_packs").install Dir["rule_packs/*.yml"]
    end
  end

  test do
    # Test that the binary runs and shows version
    assert_match "0.13.7", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
