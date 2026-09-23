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
  url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.1.0/dlq-inspector_1.1.0_darwin_amd64.tar.gz"
  sha256 "4691c12359a397522c85cdd791c40214ca0e24bb355afe6df5ef696c367572b4"
  license "MIT"
  version "1.1.0"

  livecheck do
    url :stable
    regex(%r{/releases/download/v?(\d+(?:\.\d+)+)/dlq-inspector}i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.1.0/dlq-inspector_1.1.0_darwin_arm64.tar.gz"
      sha256 "daf49eef3b88301dc3bf8f825bfbcd426812d272f02d8a9a86a7b8b477fba60d"
    else
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.1.0/dlq-inspector_1.1.0_darwin_amd64.tar.gz"
      sha256 "4691c12359a397522c85cdd791c40214ca0e24bb355afe6df5ef696c367572b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.1.0/dlq-inspector_1.1.0_linux_arm64.tar.gz"
      sha256 "1810b676167a94f95cc9593cd22cf29f1748ddafbe97e900d2b7c74604c89ea7"
    else
      url "https://github.com/HalxDocs/dlq_inspector/releases/download/v1.1.0/dlq-inspector_1.1.0_linux_amd64.tar.gz"
      sha256 "828f53c3b826f3d4be006c175995f99464c1d438dcb33fa2e25326c07cbfcc4b"
    end
  end

  def install
    bin.install "dlq"
  end

  test do
    assert_match "dlq", shell_output("#{bin}/dlq version")
  end
end
