# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.5.1/nuanu-ai-apn-0.5.1.tgz"
  sha256 "bc327317d45f8a99fb4ec246e3be7b978060400a8e36fc8da0c07d764cc25ec8"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/apn"
  end

  test do
    assert_match '"product_version":"0.5.1"', shell_output("#{bin}/apn --version")
  end
end
