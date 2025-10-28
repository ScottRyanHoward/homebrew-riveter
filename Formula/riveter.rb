class Riveter < Formula
  include Language::Python::Virtualenv

  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  url "https://github.com/ScottRyanHoward/riveter/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "1e27357305bf001c9fc0546a27ce1788cae1fc56997e801f48a62b2134292f2e"
  license "MIT"
  
  depends_on "python@3.12"
  depends_on "rust" => :build
  
  def caveats
    <<~EOS
      Riveter has been installed as a Python package.
      
      To get started:
        riveter --help
        riveter list-rule-packs
        
      For documentation and examples, visit:
        https://github.com/riveter/riveter
    EOS
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")
    system venv/"bin/pip", "install", buildpath
    bin.install_symlink libexec/"bin/riveter"
  end

  test do
    # Test that the binary runs and shows version
    assert_match "riveter", shell_output("#{bin}/riveter --version")
    
    # Test that help command works and contains expected content
    help_output = shell_output("#{bin}/riveter --help")
    assert_match "Infrastructure Rule Enforcement", help_output
  end
end