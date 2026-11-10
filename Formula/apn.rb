# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.5.101/nuanu-ai-apn-0.5.101.tgz"
  sha256 "3311e4fe575c13635c2338ee62767ab90b0fbbf683a1a2bd7c0bc60d61fb23a4"
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
    assert_match '"product_version":"0.5.101"', shell_output("#{bin}/apn --version")
  end
end
