# frozen_string_literal: true

# Homebrew Formula for Agent Payment Node.
class Apn < Formula
  desc "Local-first payment runtime for AI agents"
  homepage "https://github.com/nuanu-ai/agent-payment-node"
  url "https://github.com/nuanu-ai/agent-payment-node/releases/download/v0.5.87/nuanu-ai-apn-0.5.87.tgz"
  sha256 "6d6efe36bbce6d6922723c9154ab90bb884fe57626befd682a501ec7e3ce4d22"
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
    assert_match '"product_version":"0.5.87"', shell_output("#{bin}/apn --version")
  end
end
