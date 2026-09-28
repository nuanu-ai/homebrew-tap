# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.5.29/nuanu-ai-apn-0.5.29.tgz"
  sha256 "8f883d572e6a48c6895e6a53b2e02727e058fa9d5882d38e9d4cbcec0e3a4238"
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
    assert_match '"product_version":"0.5.29"', shell_output("#{bin}/apn --version")
  end
end
