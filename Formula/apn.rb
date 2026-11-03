# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.5.86/nuanu-ai-apn-0.5.86.tgz"
  sha256 "cf4a91a2efc466c76bd6ce33b03f9017e37b2cd3e6fe2d3eb368ae163211690b"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    # A global npm install does not apply the package's nested shrinkwrap.
    system formula_opt_bin("node@24")/"npm", "ci", *std_npm_args(prefix: false, ignore_scripts: true), "--omit=dev"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/apn.js" => "apn"
  end

  test do
    assert_match '"product_version":"0.5.86"', shell_output("#{bin}/apn --version")
  end
end
