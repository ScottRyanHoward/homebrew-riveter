class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.12.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.12.2/riveter-0.12.2-macos-intel.tar.gz"
    sha256 "PLACEHOLDER_CHECKSUM_MACOS_INTEL"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.12.2/riveter-0.12.2-macos-arm64.tar.gz"
    sha256 "PLACEHOLDER_CHECKSUM_MACOS_ARM64"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.12.2/riveter-0.12.2-linux-x86_64.tar.gz"
    sha256 "PLACEHOLDER_CHECKSUM_LINUX_X86_64"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.12.2.tar.gz"
    sha256 "PLACEHOLDER_SOURCE_CHECKSUM"
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
    assert_match "0.12.2", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
