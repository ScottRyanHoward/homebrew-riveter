# This formula is auto-updated by the release workflow in ScottRyanHoward/riveter.
# To release a new version, run the "Release" workflow in that repository.
class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/ScottRyanHoward/riveter"
  version "0.2.39"
  license "MIT"

  if OS.mac?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.39/riveter-0.2.39-macos-arm64.tar.gz"
    sha256 "3e1d7817d18918410b716105bd0e471b19cb2476dd7bb36dc7aa9bdc1c03cf91"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.39/riveter-0.2.39-linux-x86_64.tar.gz"
    sha256 "4a275916e985c4f48a87a9f146a8756ffe4b764322c9ed53ce748ffc1f4e1968"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.2.39.tar.gz"
    sha256 "0b3019a4b2334da700dc262393241cdd419603ab0f21a40614c09c0308de6fb2"
  end

  def install
    bin.install "riveter"

    resource("rule_packs").stage do
      (share/"riveter/rule_packs").install Dir["src/riveter/rule_packs/*.yml"]
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
