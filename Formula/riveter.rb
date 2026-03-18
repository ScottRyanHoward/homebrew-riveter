# This formula is auto-updated by the release workflow in ScottRyanHoward/riveter.
# To release a new version, run the "Release" workflow in that repository.
class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/ScottRyanHoward/riveter"
  version "0.2.7"
  license "MIT"

  if OS.mac?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.7/riveter-0.2.7-macos-arm64.tar.gz"
    sha256 "d358e6f33fb01ace4229103b54a40331c508a8caae6cb7e0d27ab7b2aa51475f"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.7/riveter-0.2.7-linux-x86_64.tar.gz"
    sha256 "25ff48e6ba7b0f4e35bcd13d318faf1fac8f5719dc9032f9a32d82538a1a60e6"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.2.7.tar.gz"
    sha256 "2962a3997b9cfcbd31e669d27c204f11b8ce462c4fb3312ac5a51591efe12860"
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
