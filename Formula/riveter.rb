class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.11.12"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.12/riveter-0.11.12-macos-intel.tar.gz"
    sha256 "PLACEHOLDER_CHECKSUM_MACOS_INTEL"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.12/riveter-0.11.12-macos-arm64.tar.gz"
    sha256 "PLACEHOLDER_CHECKSUM_MACOS_ARM64"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.12/riveter-0.11.12-linux-x86_64.tar.gz"
    sha256 "PLACEHOLDER_CHECKSUM_LINUX_X86_64"
  end

  def install
    bin.install "riveter"
  end

  test do
    # Test that the binary runs and shows version
    assert_match "0.11.12", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output
  end
end
