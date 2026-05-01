# This formula is auto-updated by the release workflow in ScottRyanHoward/riveter.
# To release a new version, run the "Release" workflow in that repository.
class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/ScottRyanHoward/riveter"
  version "0.2.36"
  license "MIT"

  if OS.mac?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.36/riveter-0.2.36-macos-arm64.tar.gz"
    sha256 "df6bb5a874ee510400c624635e7e702796fc66682ee46aacbf113044d4288730"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.36/riveter-0.2.36-linux-x86_64.tar.gz"
    sha256 "a691b90ae8b81cc5a4a7029f4b051616f011d7ed75e689314c14a268125853ae"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.2.36.tar.gz"
    sha256 "6c695baa545937d24fb7b605090f202a269dcd4eeb3ae11e6c0478a35198c2b4"
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
