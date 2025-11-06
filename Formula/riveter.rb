class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "0.13.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.3/riveter-0.13.3-macos-intel.tar.gz"
    sha256 "b7f8c29d86f4455771027e484320d5a861234b85241288e2e30763a18a662253"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.3/riveter-0.13.3-macos-arm64.tar.gz"
    sha256 "1cf7701643e5a4006b51ba0583bad9dd3a25529b2aac0537d995d4b71662a097"
  elsif OS.linux?
    url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.13.3/riveter-0.13.3-linux-x86_64.tar.gz"
    sha256 "f9364e983bf27aa705d9e5a63c56dd7443392e3deb4e3f69b2e0318b6c85f851"
  end

  resource "rule_packs" do
    url "https://github.com/ScottRyanHoward/riveter/archive/v0.13.3.tar.gz"
    sha256 "60a8b39c7ff485ec7a6b638900ca660a9b534479beac9c857b6c3cd7333eee97"
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
    assert_match "0.13.3", shell_output("#{bin}/riveter --version")

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test that rule packs are installed
    assert_predicate share/"riveter/rule_packs/aws-security.yml", :exist?
  end
end
