class Runfile < Formula
  desc "A lightweight task runner for defining and executing shell commands with a clean, readable syntax."
  homepage "https://github.com/nihilok/run"
  url "https://github.com/nihilok/run/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "db822500bd3e222fa180110cfd56afd696c1cb4fb0bbe4dd68de5c5b7aad14d2"
  license "MIT"
  head "https://github.com/nihilok/run.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      To enable tab completions, run:
        run --install-completion

      Or manually install for your shell:
        run --generate-completion bash > #{HOMEBREW_PREFIX}/etc/bash_completion.d/run
        run --generate-completion zsh > #{HOMEBREW_PREFIX}/share/zsh/site-functions/_run
        run --generate-completion fish > #{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/run.fish

      Create a Runfile in your project root or ~/.runfile for global commands.
      See https://github.com/nihilok/run for documentation.
    EOS
  end

  test do
    # Test that the binary exists and can show version
    assert_match "run", shell_output("#{bin}/run --version")
    
    # Test basic functionality with a simple Runfile
    (testpath/"Runfile").write <<~EOS
      test() echo "Hello from Homebrew test"
    EOS
    
    output = shell_output("#{bin}/run test")
    assert_match "Hello from Homebrew test", output
  end
end
