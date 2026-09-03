# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.5.0/nuanu-ai-apn-0.5.0.tgz"
  sha256 "0dff4cd2dfc64d4df33348d70b359fac10efaec1f818f6fe3ca66eb75bd6d9c7"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/apn"
  end

  test do
    assert_match '"product_version":"0.5.0"', shell_output("#{bin}/apn --version")
  end
end
