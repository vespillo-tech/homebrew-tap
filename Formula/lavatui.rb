class Lavatui < Formula
  desc "A lava lamp for your terminal: glowing wax blobs that rise, sink, merge and split, with a clock, a pomodoro timer and now-playing music"
  homepage "https://github.com/vespillo-tech/LavaTUI"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vespillo-tech/LavaTUI/releases/download/v1.3.0/lavatui-aarch64-apple-darwin.tar.xz"
      sha256 "f3a23536ffc0192addd5cf0ca6781bb8224de1dca2fd9deda72d3ac57a5ea6a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vespillo-tech/LavaTUI/releases/download/v1.3.0/lavatui-x86_64-apple-darwin.tar.xz"
      sha256 "deb9398256b863337c6e9fd5800e61623cab407a6da8cdf3f551328abcc19414"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vespillo-tech/LavaTUI/releases/download/v1.3.0/lavatui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e830c71b8ca73248e5ce859a066d27ea32b7790c8f19eeb2d6a21187fd30207d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vespillo-tech/LavaTUI/releases/download/v1.3.0/lavatui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "23dfb8fa16cd30e80b3e6e3dfb346cd9bee1d0b58c833cd05565e68c1b46ada2"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lavatui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lavatui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lavatui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lavatui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
