# Homebrew Tap for Riveter

This is the official Homebrew tap for [Riveter](https://github.com/riveter/riveter), an Infrastructure Rule Enforcement as Code tool.

## Installation

### Quick Install (Recommended)

Install Riveter directly with a single command:

```bash
brew install scottryanhoward/homebrew-riveter/riveter
```

### Two-Step Install

First, add the tap to your Homebrew:

```bash
brew tap scottryanhoward/homebrew-riveter
```

Then install Riveter:

```bash
brew install riveter
```

## Usage

After installation, Riveter will be available in your PATH:

```bash
# Check version
riveter --version

# List available rule packs
riveter list-rule-packs

# Scan Terraform files
riveter scan -p aws-security -t path/to/terraform/files
```

## Upgrading

To upgrade to the latest version:

```bash
brew upgrade riveter
```

## Uninstalling

To remove Riveter:

```bash
brew uninstall riveter
```

To remove the tap:

```bash
brew untap scottryanhoward/homebrew-riveter
```

## About Riveter

Riveter is a powerful tool for enforcing infrastructure rules and best practices in Terraform configurations. It supports multiple cloud providers and compliance frameworks including:

- AWS Security Best Practices
- Azure Security Guidelines
- GCP Security Recommendations
- CIS Benchmarks
- HIPAA Compliance
- PCI DSS Requirements
- SOC 2 Controls

For more information, visit the [main Riveter repository](https://github.com/riveter/riveter).

## Support

If you encounter issues with the Homebrew installation:

1. Check the [troubleshooting guide](https://github.com/riveter/riveter#troubleshooting)
2. Open an issue in the [main Riveter repository](https://github.com/riveter/riveter/issues)
3. For tap-specific issues, open an issue in this repository

## Contributing

This tap is automatically updated when new Riveter releases are published. Manual contributions are generally not needed, but if you notice issues with the formula, please open an issue.