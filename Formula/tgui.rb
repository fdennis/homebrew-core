class Tgui < Formula
  desc "GUI library for use with sfml"
  homepage "https://tgui.eu"
  url "https://github.com/texus/TGUI/archive/v0.8.9.tar.gz"
  sha256 "1f0fe130aa4c88e33791fcb5f7ed1e8836d4396e728110ece0f9845be1f9fe2e"
  license "Zlib"

  bottle do
    sha256 cellar: :any, big_sur:     "444fd41c767dee6a1c372d282aec98f42f5056a0940f33cc57272cb2b9cf9cd9"
    sha256 cellar: :any, catalina:    "195afefa361330ca0a2ff5c582162bb1c7b4a55e32c3454bbece2d6053e52872"
    sha256 cellar: :any, mojave:      "2ee5a851b200d21f8c70bb82daaef342c9d0d2f8dee94c143855a55f6b6a29a9"
    sha256 cellar: :any, high_sierra: "3272f8d3194ed5a1f55503ac524d67dd03cabb80f6ac7aa8aeee43f322a3db08"
  end

  depends_on "cmake" => :build
  depends_on "sfml"

  def install
    system "cmake", ".", *std_cmake_args,
                    "-DTGUI_MISC_INSTALL_PREFIX=#{pkgshare}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <TGUI/TGUI.hpp>
      int main()
      {
        sf::Text text;
        text.setString("Hello World");
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-I#{include}",
      "-L#{lib}", "-L#{Formula["sfml"].opt_lib}",
      "-ltgui", "-lsfml-graphics", "-lsfml-system", "-lsfml-window",
      "-o", "test"
    system "./test"
  end
end
