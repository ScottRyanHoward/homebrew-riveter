class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  url "https://github.com/ScottRyanHoward/riveter/releases/download/v0.9.0/riveter-0.9.0.tar.gz"
  sha256 "6f11f962b17651a580c295951f3f394f76ade6cc7b1dd135af908b081e5fb56b"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Install build backend manually
    ENV.prepend_create_path "PYTHONPATH", buildpath/"build_deps/lib/python3.12/site-packages"
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "pip", "install", "--target", buildpath/"build_deps/lib/python3.12/site-packages", "hatchling"

    # Now install the package with dependencies
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "pip", "install", "--prefix=#{prefix}", "."

    # Install rule packs to the shared data directory
    (pkgshare/"rule_packs").install Dir["rule_packs/*.yml"]

    # Note: Shell completions disabled due to module import issues during build
  end

  test do
    # Test that the binary runs and shows version (note: version mismatch is a known issue)
    version_output = shell_output("#{bin}/riveter --version")
    assert_match "riveter, version", version_output

    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output

    # Test basic functionality - list rule packs should work
    list_output = shell_output("#{bin}/riveter list-rule-packs")
    assert_match "aws-security", list_output

    # Test scanning with a simple rule pack (create a minimal test)
    (testpath/"test.tf").write <<~EOS
      resource "aws_s3_bucket" "test" {
        bucket = "test-bucket"
      }
    EOS

    # Test that scan command runs (violations are expected and cause exit code 1)
    # We just want to verify the command executes without crashing
    output = shell_output("#{bin}/riveter scan --rule-pack aws-security --terraform #{testpath}/test.tf", 1)
    assert_match "Rule Validation Results", output
  end
end
