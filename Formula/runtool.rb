class Runtool < Formula
  desc "A.K.A. run - the bridge between human and AI tooling"
  homepage "https://github.com/nihilok/run"
  url "https://github.com/nihilok/run/archive/refs/tags/v0.3.14.tar.gz"
  sha256 "942fb2a939ccbf43960d1f4b88951c76033e5cb4d9467484c40246bb89196edb"
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
