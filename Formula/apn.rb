# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.5.104/nuanu-ai-apn-0.5.104.tgz"
  sha256 "cb2954c7a4a5c90b1c99ef1d93034cd1b64e33c87435950cef24ade9c832b992"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  def install
    # A global npm install does not apply the package's nested shrinkwrap.
    system formula_opt_bin("node@24")/"npm", "ci", *std_npm_args(prefix: false, ignore_scripts: true), "--omit=dev"
    libexec.install Dir["*"]
    # Run apn, and every node it starts, on node@24 rather than whichever node is first on PATH.
    (bin/"apn").write_env_script libexec/"bin/apn.js", PATH: "#{formula_opt_bin("node@24")}:$PATH"
  end

  test do
    assert_match '"product_version":"0.5.104"', shell_output("#{bin}/apn --version")
  end
end
