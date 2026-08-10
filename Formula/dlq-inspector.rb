# Homebrew formula for DLQ Inspector.
#
# Distributes the prebuilt release binaries (one static archive per
# OS/arch) from https://github.com/HalxDocs/dlq_inspector/releases — no Go
# toolchain, no cgo.
#
# When a new release ships, bump `version`, the four `url`/`sha256` pairs
# (hashes come from the release's checksums.txt), and the `livecheck` regex
# if the version scheme changes. Verify with:
#   brew audit --strict --online dlq-inspector
#   brew install dlq-inspector && dlq version
class DlqInspector < Formula
  desc "Inspect, analyze, and safely recover messages from dead-letter queues"
  homepage "https://github.com/HalxDocs/dlq_inspector"
  url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.0.0/dlq-inspector_1.0.0_darwin_amd64.tar.gz"
  sha256 "4b4d939acd1428b2a8fb8f820b17a00fff6c835716381f2eecdb11487b931914"
  license "MIT"
  version "1.0.0"

  livecheck do
    url :stable
    regex(%r{/releases/download/v?(\d+(?:\.\d+)+)/dlq-inspector}i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.0.0/dlq-inspector_1.0.0_darwin_arm64.tar.gz"
      sha256 "7c0027b40b12f5421d7fe3c835ccafa97d7e6737efce0fa52610e61c0cf32560"
    else
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.0.0/dlq-inspector_1.0.0_darwin_amd64.tar.gz"
      sha256 "4b4d939acd1428b2a8fb8f820b17a00fff6c835716381f2eecdb11487b931914"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.0.0/dlq-inspector_1.0.0_linux_arm64.tar.gz"
      sha256 "c42f613aaa7910d10637ca3e0111f3cea92b6be77821ccf364c59bf980d722d1"
    else
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.0.0/dlq-inspector_1.0.0_linux_amd64.tar.gz"
      sha256 "d4b5f4a2dd8a1b962bfdd03945a93fb55939ea6559748043124c55d095908bb7"
    end
  end

  def install
    bin.install "dlq"
  end

  test do
    assert_match "dlq", shell_output("#{bin}/dlq version")
  end
end
