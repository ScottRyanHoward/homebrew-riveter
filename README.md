# Homebrew Tap for Riveter

This is the official Homebrew tap for [Riveter](https://github.com/ScottRyanHoward/riveter), an Infrastructure Rule Enforcement as Code tool for Terraform.

**Note:** You don't need to clone or interact with this repository directly. Use the installation commands below.

---

## Installation

### Quick Install (Recommended)

```bash
brew install ScottRyanHoward/riveter/riveter
```

### Two-Step Install

```bash
brew tap ScottRyanHoward/riveter
brew install riveter
```

---

## Usage

```bash
# Check version
riveter --version

# List available built-in rule packs
riveter list-rule-packs

# Scan Terraform source files against a built-in rule pack
riveter scan -p aws-security -t path/to/terraform/

# Scan with a custom rules file
riveter scan -r my-rules.yml -t main.tf

# Combine multiple rule packs
riveter scan -p aws-security -p cis-aws -t main.tf

# Validate deployed state for drift detection
riveter scan-state -p aws-security -s terraform.tfstate

# Pipe remote state from any Terraform backend
terraform state pull | riveter scan-state -p aws-security -s -
```

### Output Formats

Both `scan` and `scan-state` support multiple output formats via `-f`:

| Format | Flag | Use case |
|--------|------|----------|
| Table | `-f table` | Default — color-coded terminal output |
| JSON | `-f json` | Machine-readable, pipe-friendly |
| JUnit XML | `-f junit` | GitHub Actions, Jenkins, GitLab CI |
| SARIF | `-f sarif` | GitHub Code Scanning annotations |
| HTML | `-f html` | Self-contained report for stakeholders |

```bash
# HTML report
riveter scan -p aws-security -t main.tf -f html > report.html

# JUnit for CI
riveter scan -p aws-security -t main.tf -f junit > results.xml
```

---

## Upgrading

Run `brew update` first to sync the tap, then upgrade:

```bash
brew update && brew upgrade riveter
```

---

## Uninstalling

```bash
brew uninstall riveter
brew untap ScottRyanHoward/riveter
```

---

## About Riveter

Riveter validates Terraform configurations and deployed state against YAML rules, catching security misconfigurations and compliance violations before (and after) deployment. It ships with 15 built-in rule packs:

| Category | Packs |
|----------|-------|
| Security baselines | `aws-security`, `azure-security`, `gcp-security`, `kubernetes-security`, `multi-cloud-security` |
| CIS Benchmarks | `cis-aws`, `cis-azure`, `cis-gcp` |
| Well-Architected | `aws-well-architected`, `azure-well-architected`, `gcp-well-architected` |
| Compliance | `aws-hipaa`, `azure-hipaa`, `aws-pci-dss`, `soc2-security` |

You can also write custom rules in YAML and use them alongside or instead of the built-in packs.

For full documentation, see the [main Riveter repository](https://github.com/ScottRyanHoward/riveter).

---

## Support

- [User Guide](https://github.com/ScottRyanHoward/riveter/blob/main/docs/user-guide.md)
- [Open an issue](https://github.com/ScottRyanHoward/riveter/issues)

This tap is automatically updated when new Riveter releases are published.
