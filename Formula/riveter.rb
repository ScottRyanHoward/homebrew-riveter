class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.13.11"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.11/riveter-0.13.11-macos-intel.tar.gz"
    sha256 "4e36bab0578bd2c967cf8db5967ad1b09a596b74558d7027a8cd92b15acf232e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.11/riveter-0.13.11-macos-arm64.tar.gz"
    sha256 "0a4bd2afbe8a2bf9ac39506b6f46c71acd414465dec0547e00cf1fff396c7554"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.11/riveter-0.13.11-linux-x86_64.tar.gz"
    sha256 "8a188180dc911d4e0454e35ee1854818ec9218b75b50a2831a5ca177ca2619bd"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.13.11.tar.gz"
    sha256 "a4f623cd6cd28fb5024666ea47b50c4ae316218e5c1ce885b88252c69f1573cd"
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
    assert_match "0.13.11", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
