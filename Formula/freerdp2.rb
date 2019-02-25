class Freerdp2 < Formula
  desc "X11 implementation of the Remote Desktop Protocol (RDP)"
  homepage "https://www.freerdp.com/"
  url "https://pub.freerdp.com/releases/freerdp-2.0.0-rc4.tar.gz"
  sha256 "bd1cd5579765b2d6b444508cafc7b3669c68ff2246941a081e771f744b150f6a"
  head "https://github.com/FreeRDP/FreeRDP.git"

  
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on :xcode => :build
  depends_on "openssl"
  depends_on :x11

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DWITH_X11=ON" << "-DBUILD_SHARED_LIBS=ON"
    system "cmake", ".", *cmake_args
    system "make", "install"
  end

  test do
    success = `#{bin}/xfreerdp --version` # not using system as expected non-zero exit code
    details = $CHILD_STATUS
    if !success && details.exitstatus != 128
      raise "Unexpected exit code #{$CHILD_STATUS} while running xfreerdp"
    end
  end
end
