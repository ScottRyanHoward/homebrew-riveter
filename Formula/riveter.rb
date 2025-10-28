class Riveter < Formula
  desc "Infrastructure Rule Enforcement as Code for Terraform configurations"
  homepage "https://github.com/riveter/riveter"
  version "{{VERSION}}"
  license "MIT"
  
  # Bottle block will be added automatically by brew when building bottles
  # bottle do
  #   sha256 cellar: :any_skip_relocation, arm64_sonoma:   "..."
  #   sha256 cellar: :any_skip_relocation, arm64_ventura:  "..."
  #   sha256 cellar: :any_skip_relocation, arm64_monterey: "..."
  #   sha256 cellar: :any_skip_relocation, sonoma:         "..."
  #   sha256 cellar: :any_skip_relocation, ventura:        "..."
  #   sha256 cellar: :any_skip_relocation, monterey:       "..."
  #   sha256 cellar: :any_skip_relocation, x86_64_linux:   "..."
  # end

  # Platform-specific binary URLs and checksums
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/riveter/riveter/releases/download/v{{VERSION}}/riveter-{{VERSION}}-macos-intel.tar.gz"
    sha256 "{{MACOS_INTEL_SHA256}}"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/riveter/riveter/releases/download/v{{VERSION}}/riveter-{{VERSION}}-macos-arm64.tar.gz"
    sha256 "{{MACOS_ARM64_SHA256}}"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/riveter/riveter/releases/download/v{{VERSION}}/riveter-{{VERSION}}-linux-x86_64.tar.gz"
    sha256 "{{LINUX_X86_64_SHA256}}"
  end

  # No runtime dependencies required for standalone binary
  # The binary is self-contained and includes all necessary dependencies
  
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
    # Verify the binary exists in the extracted archive
    unless File.exist?("riveter")
      odie "riveter binary not found in the downloaded archive"
    end
    
    # Install the binary to the bin directory
    bin.install "riveter"
    
    # Ensure the binary is executable
    (bin/"riveter").chmod 0755
    
    # Verify the installed binary works
    system "#{bin}/riveter", "--version"
    unless $?.success?
      odie "riveter binary installation verification failed"
    end
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