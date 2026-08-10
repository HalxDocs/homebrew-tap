# Homebrew tap for DLQ Inspector

Install [DLQ Inspector](https://github.com/HalxDocs/dlq_inspector) — a
local-first CLI for inspecting, analyzing, and safely recovering messages from
dead-letter queues — from prebuilt release binaries.

## Install

```bash
brew tap HalxDocs/homebrew-tap
# Newer Homebrew refuses formulas from untrusted third-party taps —
# approve when prompted, or run:
brew trust halxdocs/tap
brew install dlq-inspector
```

That's it — `dlq` lands on your PATH. Upgrade later with `dlq self-update
--confirm` (or `brew upgrade dlq-inspector` after a formula bump).

## What the formula does

`Formula/dlq-inspector.rb` downloads the static release archive for your
platform (macOS/linux × amd64/arm64), verifies it against the pinned `sha256`
from the release's `checksums.txt`, and installs the single `dlq` binary.
No Go toolchain, no cgo, no runtime dependencies.

## Bumping the formula

Each release of DLQ Inspector needs a formula bump (new `version`, `url`s, and
`sha256`s):

1. Fetch the hashes from the new release's `checksums.txt`.
2. Update `version`, the four `url`/`sha256` pairs in the formula, and the
   `livecheck` regex if the scheme changed.
3. Verify:
   ```bash
   brew audit --strict --online dlq-inspector
   brew install dlq-inspector && dlq version
   ```

The CI workflow in [dlq_inspector](https://github.com/HalxDocs/dlq_inspector)
runs `brew install` against this tap on every push, so a broken formula fails
the main repo's build.
