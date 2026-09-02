# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.4.1/nuanu-ai-apn-0.4.1.tgz"
  sha256 "0dc601e0d4a87e3f2e47701c08176b9247b23b52f825c7f49a9aab1e3d838a9a"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/apn"
  end

  test do
    assert_match '"product_version":"0.4.1"', shell_output("#{bin}/apn --version")
  end
end
