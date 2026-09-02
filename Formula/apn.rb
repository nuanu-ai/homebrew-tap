# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.3.10/nuanu-ai-apn-0.3.10.tgz"
  sha256 "73cf05b3aa1536e28cc422ac0fe9c0b9cb02c128cc3ea5f1b3ce8d00166fde60"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/apn"
  end

  test do
    assert_match '"product_version":"0.3.10"', shell_output("#{bin}/apn --version")
  end
end
