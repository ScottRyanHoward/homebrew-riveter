class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.13.14"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.14/riveter-0.13.14-macos-intel.tar.gz"
    sha256 "0fa73304b8fc15f5907563d6f364a5c1ea26b483b5274499b7043aad5403b69b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.14/riveter-0.13.14-macos-arm64.tar.gz"
    sha256 "82c069c8b3326dab0f2768b81dc72564c631e69d3bff308655bc2b7b0fdbd242"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.14/riveter-0.13.14-linux-x86_64.tar.gz"
    sha256 "ec66a3bafb02103fd4b4742b212758eb40e41a9fce943f31901e519a3d858d86"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.13.14.tar.gz"
    sha256 "46da38a66cac98d07ecb129b608e38aba35e122e64f626220982a2f2b9af1d30"
  end

  def install
    bin.install "riveter"

    # Install rule packs
    resource("rule_packs").stage do
      (share/"riveter/rule_packs").install Dir["rule_packs/*.yml"]
    end
  end

  def caveats
    <<~EOS
      Rule packs have been installed to:
        #{share}/riveter/rule_packs/

      To scan a Terraform file against a built-in rule pack:
        riveter scan -p aws-security -t main.tf

      To list all available rule packs:
        riveter list-rule-packs

      To use a custom rule file:
        riveter scan -r my-rules.yml -t main.tf
    EOS
  end

  test do
    # Test that the binary runs and reports the correct version
    assert_match version.to_s, shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
