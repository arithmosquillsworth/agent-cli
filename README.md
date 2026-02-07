# Agent CLI

🔧 One-command installer for the complete Agent Security Stack.

## Quick Install

```bash
curl -fsSL https://arithmos.dev/install.sh | bash
```

Or manually:

```bash
git clone https://github.com/arithmosquillsworth/agent-cli.git
cd agent-cli
./install.sh
```

## What Gets Installed

| Tool | Binary | Purpose |
|------|--------|---------|
| agent-tx-firewall | `firewall` | Transaction policy enforcement |
| agent-honeypot | (library) | Attack pattern detection |
| prompt-guard | (library) | Prompt injection detection |
| tx-simulator | (library) | Pre-flight transaction validation |
| agent-security-dashboard | `dashboard` | Unified security monitoring |
| agent-wallet-monitor | `monitor` | Real-time wallet monitoring |
| agent-reputation-scanner | `scanner` | Address risk assessment |
| agent-config-manager | `acm` | Configuration management |

## Post-Install Setup

```bash
# Initialize configuration
acm init

# Add API keys
acm set api_keys.etherscan YOUR_ETHERSCAN_KEY
acm set api_keys.basescan YOUR_BASESCAN_KEY

# Check wallet
monitor balance

# Start dashboard
dashboard
```

## Directory Structure

```
~/.local/share/agent-cli/     # Tool sources
~/.local/bin/                 # Compiled binaries
~/.config/agent/              # Configuration
```

## Requirements

- Go 1.21+
- Git
- Unix-like system (Linux/macOS)

## Updating

Run the installer again to update all tools:

```bash
curl -fsSL https://arithmos.dev/install.sh | bash
```

## Uninstalling

```bash
rm -rf ~/.local/share/agent-cli
rm ~/.local/bin/firewall ~/.local/bin/monitor ~/.local/bin/scanner
rm ~/.local/bin/dashboard ~/.local/bin/acm
rm -rf ~/.config/agent
```

## Part of Agent Security Stack

Complete defense-in-depth security for autonomous AI agents:

1. **Pre-execution**: Prompt Guard + Transaction Simulator
2. **Policy enforcement**: Transaction Firewall
3. **Monitoring**: Wallet Monitor + Security Dashboard
4. **Intelligence**: Honeypot + Reputation Scanner
5. **Management**: Config Manager

## License

MIT
