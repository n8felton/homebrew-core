class Aribb24 < Formula
  desc "Library for ARIB STD-B24, decoding JIS 8 bit characters and parsing MPEG-TS"
  homepage "https://code.videolan.org/jeeb/aribb24"
  url "https://code.videolan.org/jeeb/aribb24/-/archive/v1.0.4/aribb24-v1.0.4.tar.bz2"
  sha256 "88b58dd760609372701087e25557ada9f7c6d973306c017067c5dcaf9e2c9710"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "60ea5e1c7b35cde769b03c6172b4ff78dec340a91f8ae2e1c6b490fdce65c34a"
    sha256 cellar: :any,                 arm64_monterey: "9e6741b85e4276c01c4ee9a9a304f816a2bbc7c848bf3f2607308af48c2464b0"
    sha256 cellar: :any,                 arm64_big_sur:  "14ac368a22499dc0de526a744fd69ba07c64a01de95e5f9fbf16df2a90c38a6e"
    sha256 cellar: :any,                 monterey:       "58a30ff5299bfc9311c30ae8ff571f156eb336add5b25d35d36c6e2a8e8d5534"
    sha256 cellar: :any,                 big_sur:        "fe1e9015a5c0791019bcdf64b980730d8736c85ea6cf306beef8e06ce8ebfaf9"
    sha256 cellar: :any,                 catalina:       "31520472d7d33c860fff359b7ca6cd3e724bf504d9926c601a4db798d21df600"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5a53b1584bef9b5d6aead4cc62266c67a9e642ea7234479516f4c083d0316f34"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libpng"

  def install
    system "./bootstrap"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <aribb24/aribb24.h>
      #include <stdlib.h>
      int main() {
        arib_instance_t *ptr = arib_instance_new(NULL);
        if (!ptr)
          return 1;
        arib_instance_destroy(ptr);
        return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c", "-I#{include}",
                   "-L#{lib}", "-laribb24"
    system "./test"
  end
end
