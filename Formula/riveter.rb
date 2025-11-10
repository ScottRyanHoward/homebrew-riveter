class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.13.10"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.10/riveter-0.13.10-macos-intel.tar.gz"
    sha256 "bb284c4d7dd7d325e1abadefcf3989eff9bcad67a4e010029375cd2fb14e4bf0"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.10/riveter-0.13.10-macos-arm64.tar.gz"
    sha256 "203782bc359a8846d19de30fcd6b5300e1fe07f48732f0a71dc31c05b04743f3"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.10/riveter-0.13.10-linux-x86_64.tar.gz"
    sha256 "20fcf019892d5016d68b5c95c28eaef34a33223ec8a9f2f638d68c2a0d46f2f4"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.13.10.tar.gz"
    sha256 "75e09c955b58f2fcb1cb671022412a7ec5aeb5fdbf0882dc8610bc860e81b8b6"
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
    assert_match "0.13.10", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
