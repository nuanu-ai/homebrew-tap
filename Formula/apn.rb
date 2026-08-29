# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.3.0/nuanu-ai-apn-0.3.0.tgz"
  sha256 "81fc02d9fab3d7339349fafd025b2669455907512ec1af7b2634c2c6decf2075"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/apn"
  end

  test do
    assert_match '"product_version":"0.3.0"', shell_output("#{bin}/apn --version")
  end
end
