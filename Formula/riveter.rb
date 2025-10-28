class Riveter < Formula
  include Language::Python::Virtualenv

  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  url "https://github.com/ScottRyanHoward/riveter/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "1e27357305bf001c9fc0546a27ce1788cae1fc56997e801f48a62b2134292f2e"
  license "MIT"
  
  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/9f/33/c00162f49c0e2fe8064a62cb92b93e50c74a72bc370ab92f86112b33ff62/cryptography-46.0.3.tar.gz"
    sha256 "a8b17438104fed022ce745b362294d9ce35b4c2e45c1d958ad4a4b019285f4a1"
  end

  resource "python-hcl2" do
    url "https://files.pythonhosted.org/packages/50/8e/f82ed407a10c2dd4228ff0fceec8a16dd6a9191a2ed119233c04dccf2ca4/python_hcl2-7.3.1.tar.gz"
    sha256 "f8f55583703daf7bbcb595a33c68de891064d565974ea39998b81d15a4c4657b"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/ab/3a/0316b28d0761c6734d6bc14e770d85506c986c85ffb239e688eeaab2c2bc/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end
  
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
    virtualenv_install_with_resources
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