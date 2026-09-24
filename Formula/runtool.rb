class Runtool < Formula
  desc "A.K.A. run - the bridge between human and AI tooling"
  homepage "https://github.com/nihilok/run"
  url "https://github.com/nihilok/run/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "7cc6e7f138616a299fd6bfe5868d5e81b7c19c500ad7da6cd153a2419f1ee4be"
  license "MIT"
  head "https://github.com/nihilok/run.git", branch: "main"

  depends_on "rust" => :build

  conflicts_with "run", because: "both install a `run` binary"
  conflicts_with "run-kit", because: "both install a `run` binary"

  def install
    system "cargo", "install", *std_cargo_args(path: "run")
    generate_completions_from_executable(bin/"run", "--generate-completion")
  end

  def caveats
    <<~EOS
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
