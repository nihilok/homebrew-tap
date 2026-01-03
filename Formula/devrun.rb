class Devrun < Formula
  desc "A lightweight task runner for defining and executing shell commands with a clean, readable syntax."
  homepage "https://github.com/nihilok/devrun"
  url "https://github.com/nihilok/devrun/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "2313c996ae82d0f35e2ee6b0241669ac78f43ef62b0837713151bf41e02cc9b8"
  license "MIT"
  head "https://github.com/nihilok/devrun.git", branch: "main"

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
      See https://github.com/nihilok/devrun for documentation.
    EOS
  end

  test do
    # Test that the binary exists and can show version
    assert_match "devrun", shell_output("#{bin}/run --version")
    
    # Test basic functionality with a simple Runfile
    (testpath/"Runfile").write <<~EOS
      test() echo "Hello from Homebrew test"
    EOS
    
    output = shell_output("#{bin}/run test")
    assert_match "Hello from Homebrew test", output
  end
end
