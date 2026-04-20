# This formula is auto-updated by the release workflow in ScottRyanHoward/riveter.
# To release a new version, run the "Release" workflow in that repository.
class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/ScottRyanHoward/riveter"
  version "0.2.24"
  license "MIT"

  if OS.mac?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.24/riveter-0.2.24-macos-arm64.tar.gz"
    sha256 "139114adc301249563578ef1038a57b94e5a5521fefd9de21882788c064db468"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.24/riveter-0.2.24-linux-x86_64.tar.gz"
    sha256 "3b15d9a240360e6cb9d7c14fec02ca4b0c559333fa79c7a06dea1f7353d51fa1"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.2.24.tar.gz"
    sha256 "583c29d2059a82072aeb531f4e5c56b8868bfd43bc84245fcc5a836f8416de07"
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

      Note: Intel Mac users can run this binary via Rosetta 2.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/riveter --version")
    assert_match "Infrastructure Rule Enforcement", shell_output("#{bin}/riveter --help")
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
