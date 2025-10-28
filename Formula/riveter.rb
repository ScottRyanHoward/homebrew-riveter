class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  url "https://github.com/ScottRyanHoward/riveter/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "1e27357305bf001c9fc0546a27ce1788cae1fc56997e801f48a62b2134292f2e"
  license "MIT"
  
  depends_on "python@3.12"
  
  def caveats
    <<~EOS
      Riveter has been installed as a standalone binary.
      
      To get started:
        riveter --help
        riveter list-rule-packs
        
      For documentation and examples, visit:
        https://github.com/riveter/riveter
    EOS
  end

  def install
    virtualenv_install_with_resources using: "python@3.12"
  end

  test do
    # Test that the binary runs and shows version
    assert_match version.to_s, shell_output("#{bin}/riveter --version")
    
    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output
    
    # Test that list-rule-packs command works
    rule_packs_output = shell_output("#{bin}/riveter list-rule-packs")
    assert_match "aws-security", rule_packs_output
    
    # Test scan command help (without actually scanning)
    scan_help = shell_output("#{bin}/riveter scan --help")
    assert_match "Scan Terraform files", scan_help
  end
end