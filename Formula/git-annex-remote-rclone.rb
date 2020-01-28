class GitAnnexRemoteRclone < Formula
  desc "Use rclone supported cloud storage with git-annex"
  homepage "https://github.com/DanielDent/git-annex-remote-rclone"
  url "https://github.com/DanielDent/git-annex-remote-rclone/archive/v0.6.tar.gz"
  sha256 "fb9bb77c6dd30dad4966926af87f63be92ef442cfeabcfd02202c657f40439d0"

  depends_on "git-annex"
  depends_on "rclone"

  def install
    bin.install "git-annex-remote-rclone"
  end

  test do
    # try a test modeled after git-annex.rb's test (copy some lines
    # from there)

    # make sure git can find git-annex
    ENV.prepend_path "PATH", bin
    # We don't want this here or it gets "caught" by git-annex.
    rm_r "Library/Python/2.7/lib/python/site-packages/homebrew.pth"

    system "git", "init"
    system "git", "annex", "init"

    print "Failure is expected since this is a fake remote; we are testing to ensure git-annex-remote-rclone is available\n"
    output = shell_output "git annex initremote testremote type=external externaltype=rclone target=testtest123123 encryption=none", 1
    assert_match /^initremote testremote.*failed/m, output
  end
end
