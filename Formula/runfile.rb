class Runfile < Formula
  desc "A lightweight task runner for defining and executing shell commands with a clean, readable syntax."
  homepage "https://github.com/nihilok/run"
  url "https://github.com/nihilok/run/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "afab70be8840835a12293a2275b488652f362095dcf55acd1108bf2e1f8ddca4"
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
