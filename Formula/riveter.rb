class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.13.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.2/riveter-0.13.2-macos-intel.tar.gz"
    sha256 "67ed14ba94ae97fa943998ef159bef0d3ffb59fbc6570383f4beda1f52237363"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.2/riveter-0.13.2-macos-arm64.tar.gz"
    sha256 "acb7acabc2b2bfa92a46bbb46a2ce5893c00bbec524c405fa68afa67936b5a08"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.2/riveter-0.13.2-linux-x86_64.tar.gz"
    sha256 "5ba7ab5454bfd3790964204f476ad2bd0933a86a88722ef15044c766497d3d48"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.13.2.tar.gz"
    sha256 "41bc42fe6b2f6c9a0f7e6d6e377adc9b5cbe5eb70a5aa86b105b112d0bb00c85"
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
    assert_match "0.13.2", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
