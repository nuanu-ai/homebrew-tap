# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.2.2/nuanu-ai-apn-0.2.2.tgz"
  sha256 "2417395d0256a856490fc1abf9ec89112e86bf6d0adb57ced5ad5e240355e312"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/apn"
  end

  test do
    assert_match '"product_version":"0.2.2"', shell_output("#{bin}/apn --version")
  end
end
