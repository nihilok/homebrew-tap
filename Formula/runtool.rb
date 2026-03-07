class Runtool < Formula
  desc "A.K.A. run - the bridge between human and AI tooling"
  homepage "https://github.com/nihilok/run"
  url "https://github.com/nihilok/run/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "b224f18f02ab239e7281ee9c4e0dc4257afb0938983e0b1f4d37935b3b47c740"
  license "MIT"
  head "https://github.com/nihilok/run.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root=#{prefix}", "--path=run"
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
