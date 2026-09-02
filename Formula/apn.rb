# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.4.3/nuanu-ai-apn-0.4.3.tgz"
  sha256 "c5fe89c9ec96f95c65fa76c655ef50478d3b2cf06ff77c1134f741bcdf5d8657"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/apn"
  end

  test do
    assert_match '"product_version":"0.4.3"', shell_output("#{bin}/apn --version")
  end
end
