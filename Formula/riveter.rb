# This formula is auto-updated by the release workflow in ScottRyanHoward/riveter.
# To release a new version, run the "Release" workflow in that repository.
class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/ScottRyanHoward/riveter"
  version "0.2.6"
  license "MIT"

  if OS.mac?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.6/riveter-0.2.6-macos-arm64.tar.gz"
    sha256 "3611ccb3f04773c046e906ff7bbe6b177cdca81986c9e8f5704d4f5a54e84074"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.2.6/riveter-0.2.6-linux-x86_64.tar.gz"
    sha256 "507294bed2c5fc368e1a0add9dcabf91c69015e3f580434e99f9c4241510da3d"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.2.6.tar.gz"
    sha256 "066e02945388b324a429f286774ce8a629307009b3ca248409b59e451e66b1e9"
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
