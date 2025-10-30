class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.11.11"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.11/riveter-0.11.11-macos-intel.tar.gz"
    sha256 "1ee0ac1975c5952d4c50d922c5959419d85e73c192dd65b4eaa3417016466e5f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.11/riveter-0.11.11-macos-arm64.tar.gz"
    sha256 "92eec4a7330f733315599f0f7648abee308b92b6cd4e8ca38124aef62e61ad92"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.11.11/riveter-0.11.11-linux-x86_64.tar.gz"
    sha256 "3bb4e7192c1529cc455456579bff6d2278f02dc030c05219bf1da64a636ffb6a"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.11.11.tar.gz"
    sha256 "b64cedbf22840c81c085b871b21bbce89c018c8d2b5a1d9b08e1ae9509c542a4"
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
    assert_match "0.11.11", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output
    
    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
