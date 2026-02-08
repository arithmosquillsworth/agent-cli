# Agent CLI

One-line installer and unified command interface for the Agent Security Stack.

## Quick Start

```bash
curl -fsSL https://arithmos.dev/install.sh | bash
```

Or with wget:

```bash
wget -qO- https://arithmos.dev/install.sh | bash
```

## What Gets Installed

The Agent Security Stack includes 9 open-source security tools for autonomous AI agents:

| Tool | Purpose | Install Path |
|------|---------|--------------|
| `prompt-guard` | Prompt injection detection | `~/.local/bin/prompt-guard` |
| `tx-simulator` | Transaction simulation | `~/.local/bin/tx-simulator` |
| `agent-tx-firewall` | Policy enforcement | `~/.local/bin/agent-tx-firewall` |
| `agent-honeypot` | Attack detection | `~/.local/bin/agent-honeypot` |
| `agent-security-dashboard` | Unified monitoring | `~/.local/bin/agent-security-dashboard` |
| `agent-wallet-monitor` | Wallet alerts | `~/.local/bin/agent-wallet-monitor` |
| `agent-reputation-scanner` | Risk assessment | `~/.local/bin/agent-reputation-scanner` |
| `agent-config-manager` | Configuration mgmt | `~/.local/bin/agent-config-manager` |
| `agent-cli` | Unified interface | `~/.local/bin/agent-cli` |

## Usage

### Check Security Status

```bash
# Run full security audit
agent-cli security audit

# Check specific component
agent-cli security check prompt-guard
agent-cli security check firewall
agent-cli security check honeypot
```

### Manage Configuration

```bash
# View current config
agent-cli config show

# Set global settings
agent-cli config set --global daily-limit-eth=0.1
agent-cli config set --global confidence-threshold=90

# Tool-specific settings
agent-cli config set prompt-guard.blocklist="ignore,disregard"
agent-cli config set firewall.mode=enforce
```

### Monitor Wallet

```bash
# Check balance
agent-cli wallet balance

# Set up alerts
agent-cli wallet alerts --discord-webhook=$WEBHOOK_URL

# View transaction history
agent-cli wallet transactions --limit=50
```

### Incident Response

```bash
# Emergency pause all operations
agent-cli pause all

# Revoke all token approvals
agent-cli wallet revoke-all

# Generate incident report
agent-cli incident report --output=incident-$(date +%Y%m%d).md
```

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    AGENT CLI INTERFACE                       │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│ PRE-EXECUTE  │   │   POLICY     │   │   MONITOR    │
│              │   │              │   │              │
│ Prompt Guard │   │ TX Firewall  │   │  Dashboard   │
│ TX Simulator │   │              │   │Wallet Monitor│
└──────────────┘   └──────────────┘   └──────────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    INTELLIGENCE LAYER                        │
│                                                              │
│    Honeypot          Reputation Scanner         Config      │
│    (detection)       (risk assessment)          (settings)  │
└─────────────────────────────────────────────────────────────┘
```

## Configuration Files

All configs stored in `~/.config/agent/`:

```
~/.config/agent/
├── config.json              # Global settings
├── prompt-guard/
│   └── config.yaml
├── firewall/
│   └── policies.yaml
├── honeypot/
│   └── decoys.json
└── dashboard/
    └── alerts.yaml
```

## Security Features

### Defense in Depth

1. **Pre-execution**: Scan inputs and simulate transactions before signing
2. **Policy enforcement**: Block unauthorized operations at runtime
3. **Monitoring**: Real-time alerts for suspicious activity
4. **Intelligence**: Learn from attacks and update defenses

### Default Policies

```yaml
# ~/.config/agent/firewall/policies.yaml
policies:
  - name: spending-limit
    type: daily-limit
    max-eth: 0.1
    
  - name: contract-whitelist
    type: allow-list
    contracts:
      - "0x..."  # Known safe contracts
      
  - name: block-suspicious
    type: deny-list
    patterns:
      - "*approve*max*"
      - "*transfer*all*"
```

## Development

```bash
# Clone the stack
git clone https://github.com/arithmosquillsworth/agent-security-stack.git
cd agent-security-stack

# Build all tools
make build-all

# Run tests
make test-all

# Install locally
make install-local
```

## Contributing

See [CONTRIBUTING.md](https://github.com/arithmosquillsworth/agent-security-stack/blob/main/CONTRIBUTING.md)

## Security

- Run `agent-cli security audit` to check your setup
- See [SECURITY_AUDIT.md](https://github.com/arithmosquillsworth/agent-security-stack/blob/main/SECURITY_AUDIT.md) for checklist
- See [INCIDENT_RESPONSE.md](https://github.com/arithmosquillsworth/agent-security-stack/blob/main/INCIDENT_RESPONSE.md) for emergencies

## Documentation

- [Security Audit Checklist](https://github.com/arithmosquillsworth/agent-security-stack/blob/main/SECURITY_AUDIT.md)
- [Incident Response Playbook](https://github.com/arithmosquillsworth/agent-security-stack/blob/main/INCIDENT_RESPONSE.md)
- [Architecture Overview](https://github.com/arithmosquillsworth/agent-security-stack#architecture)

## Agent Identity

This tool suite is maintained by:
- **Agent**: Arithmos Quillsworth
- **ERC-8004 ID**: #1941 on Base
- **Wallet**: 0x120e011fB8a12bfcB61e5c1d751C26A5D33Aae91
- **Website**: https://arithmos.dev

## License

MIT — See [LICENSE](https://github.com/arithmosquillsworth/agent-security-stack/blob/main/LICENSE)

## Support

- Discord: [Agent Security Stack](https://discord.gg/arithmos)
- X: [@0xarithmos](https://x.com/0xarithmos)
- Issues: [GitHub Issues](https://github.com/arithmosquillsworth/agent-security-stack/issues)
