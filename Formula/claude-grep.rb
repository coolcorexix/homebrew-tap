class ClaudeGrep < Formula
  desc "Search Claude Code, OpenCode, and Hermes conversation history"
  homepage "https://github.com/coolcorexix/claude-grep"
  url "https://github.com/coolcorexix/claude-grep/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "a35b19784c134792a74c46800e1ece50c03312fd7e65a9cee2b19720df62795a"
  license "MIT"

  depends_on "fzf"
  depends_on "python@3.12"
  depends_on "ripgrep"

  def install
    # python@3.12 is keg-only, so pin the shebang to Homebrew's interpreter.
    inreplace "ccfind", "#!/usr/bin/env python3",
              "#!#{Formula["python@3.12"].opt_bin}/python3.12"
    bin.install "ccfind"
  end

  def caveats
    <<~EOS
      claude-grep installs the `ccfind` command. Run it with:
        ccfind

      It also needs Anthropic's Claude Code CLI (`claude`) on your PATH, which
      Homebrew does not manage. claude-grep reads the transcripts Claude Code
      writes under ~/.claude/projects/.
    EOS
  end

  test do
    assert_predicate bin/"ccfind", :executable?
    # A short query (< 2 chars) returns immediately without launching the UI.
    system bin/"ccfind", "--backend", "z"
  end
end
