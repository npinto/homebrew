require 'formula'

class Tig < Formula
  url 'https://github.com/jonas/tig/tarball/tig-0.18'
  homepage 'http://jonas.nitro.dk/tig/'
  version '0.18'
  md5 '52031d9528a2db9d87cee242a8e068fb'

  head 'https://github.com/jonas/tig.git'

  depends_on 'libiconv'
  depends_on 'autoconf-archive'

  def options
    [['--build-docs', "Build man pages using asciidoc and xmlto"]]
  end

  if ARGV.include? '--build-docs'
    # these are needed to build man pages
    depends_on 'asciidoc'
    depends_on 'xmlto'
  end

  def install
    ENV['ACLOCAL'] = "aclocal -I#{HOMEBREW_PREFIX}/share/aclocal"

    system "make configure"
    system "./configure", "--prefix=#{prefix}"
    system "make install"

    if ARGV.include? '--build-docs'
      system "make install-doc-man"
    end
  end
end
