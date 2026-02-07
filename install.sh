#!/bin/bash
# agent-cli-install.sh - One-line installer for Agent Security Stack

set -e

REPO_BASE="https://github.com/arithmosquillsworth"
INSTALL_DIR="${HOME}/.local/share/agent-cli"
BIN_DIR="${HOME}/.local/bin"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_banner() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                                                            ║${NC}"
    echo -e "${BLUE}║  🔐 Agent Security Stack Installer                        ║${NC}"
    echo -e "${BLUE}║  One-command setup for autonomous agent security          ║${NC}"
    echo -e "${BLUE}║                                                            ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

check_dependencies() {
    print_info "Checking dependencies..."
    
    if ! command -v git &> /dev/null; then
        print_error "git is required but not installed"
        exit 1
    fi
    
    if ! command -v go &> /dev/null; then
        print_error "Go is required but not installed"
        print_info "Install from: https://go.dev/dl/"
        exit 1
    fi
    
    print_success "Dependencies satisfied"
}

setup_directories() {
    print_info "Setting up directories..."
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$BIN_DIR"
    mkdir -p "${HOME}/.config/agent"
    print_success "Directories created"
}

install_tool() {
    local tool=$1
    local repo_url="${REPO_BASE}/${tool}"
    local tool_dir="${INSTALL_DIR}/${tool}"
    
    if [ -d "$tool_dir" ]; then
        print_warning "${tool} already exists, updating..."
        cd "$tool_dir"
        git pull --quiet
    else
        print_info "Installing ${tool}..."
        git clone --quiet "$repo_url" "$tool_dir"
    fi
    
    # Build the tool
    cd "$tool_dir"
    if go build -o "${BIN_DIR}/${tool}" . 2>/dev/null; then
        print_success "${tool} installed"
    else
        # Some tools have different binary names
        case $tool in
            agent-tx-firewall)
                go build -o "${BIN_DIR}/firewall" . && print_success "firewall installed"
                ;;
            agent-wallet-monitor)
                go build -o "${BIN_DIR}/monitor" . && print_success "monitor installed"
                ;;
            agent-reputation-scanner)
                go build -o "${BIN_DIR}/scanner" . && print_success "scanner installed"
                ;;
            agent-config-manager)
                go build -o "${BIN_DIR}/acm" . && print_success "acm installed"
                ;;
            agent-security-dashboard)
                go build -o "${BIN_DIR}/dashboard" . && print_success "dashboard installed"
                ;;
            *)
                print_error "Failed to build ${tool}"
                ;;
        esac
    fi
}

install_all_tools() {
    print_info "Installing Agent Security Stack..."
    echo ""
    
    local tools=(
        "agent-tx-firewall"
        "agent-honeypot"
        "prompt-guard"
        "tx-simulator"
        "agent-security-dashboard"
        "agent-wallet-monitor"
        "agent-reputation-scanner"
        "agent-config-manager"
    )
    
    for tool in "${tools[@]}"; do
        install_tool "$tool" || print_warning "Skipping ${tool}"
    done
}

setup_path() {
    print_info "Checking PATH..."
    
    if [[ ":$PATH:" != *":${BIN_DIR}:"* ]]; then
        echo ""
        print_warning "${BIN_DIR} is not in your PATH"
        echo ""
        echo "Add this to your shell profile (~/.bashrc or ~/.zshrc):"
        echo ""
        echo "    export PATH=\"\$PATH:${BIN_DIR}\""
        echo ""
        read -p "Add to ~/.bashrc now? [Y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
            echo "export PATH=\"\$PATH:${BIN_DIR}\"" >> ~/.bashrc
            print_success "Added to ~/.bashrc"
            print_info "Run 'source ~/.bashrc' to update your current shell"
        fi
    else
        print_success "PATH already configured"
    fi
}

run_setup() {
    print_info "Running initial setup..."
    
    if command -v acm &> /dev/null; then
        acm init 2>/dev/null || print_warning "acm init failed, run manually later"
    fi
}

print_summary() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  Installation Complete!                                    ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Installed tools:"
    echo "  • firewall    - Transaction policy enforcement"
    echo "  • monitor     - Wallet monitoring"
    echo "  • scanner     - Address reputation scanner"
    echo "  • acm         - Configuration manager"
    echo "  • dashboard   - Security dashboard"
    echo ""
    echo "Quick start:"
    echo "  1. acm init              # Create config"
    echo "  2. acm set api_keys.etherscan YOUR_KEY"
    echo "  3. monitor balance       # Check wallet"
    echo "  4. dashboard             # Start dashboard"
    echo ""
    echo "Documentation: https://arithmos.dev/security-stack"
    echo ""
}

# Main
print_banner
check_dependencies
setup_directories
install_all_tools
setup_path
run_setup
print_summary
