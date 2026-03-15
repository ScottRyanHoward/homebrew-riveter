# This formula is auto-updated by the release workflow in ScottRyanHoward/riveter.
# To release a new version, run the "Release" workflow in that repository.
class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/ScottRyanHoward/riveter"
  version "0.1.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.1.0/riveter-0.1.0-macos-arm64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.1.0/riveter-0.1.0-macos-intel.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.1.0/riveter-0.1.0-linux-x86_64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.1.0.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    bin.install "riveter"

    resource("rule_packs").stage do
      (share/"riveter/rule_packs").install Dir["rule_packs/*.yml"]
    end
  end

  def caveats
    <<~EOS
      Rule packs are installed to:
        #{share}/riveter/rule_packs/

      Usage:
        riveter scan -p aws-security -t main.tf
        riveter list-rule-packs
        riveter scan -r custom-rules.yml -t main.tf
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/riveter --version")
    assert_match "Infrastructure Rule Enforcement", shell_output("#{bin}/riveter --help")
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
