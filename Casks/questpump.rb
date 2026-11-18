# QuestPump's cask (the desktop app, built from helper/) in the tap Pluxia-GmbH/homebrew-tap. The helper's release
# workflow (.github/workflows/helper-release.yml in Pluxia-GmbH/questpump) writes Casks/questpump.rb there from the
# template helper/packaging/homebrew/questpump.rb, with each release's version and the two disk images' checksums:
# change the template, never the tap's copy.
cask "questpump" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.0"
  sha256 arm:   "879fc257d785eb84eab130d5f4415417d76e54f2b75f880c50872e258e9031ca",
         intel: "3a6b000d3555448233950addc4e3f36043a9a60a3a5922894d04bb75a54a138c"

  url "https://github.com/Pluxia-GmbH/questpump/releases/download/helper-v#{version}/QuestPump_#{version}_#{arch}.dmg",
      verified: "github.com/Pluxia-GmbH/questpump/"
  name "QuestPump"
  desc "Exercise pumps between games, synced with the add-on and the phone app"
  homepage "https://questpump.com/helper"

  livecheck do
    url :url
    regex(/^helper[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # the app installs its own signed updates
  auto_updates true
  depends_on macos: :sonoma

  app "QuestPump.app"

  # start at login is a login item registered through SMAppService, so there is no LaunchAgent file to remove
  zap trash: [
    "~/Library/Application Support/QuestPump",
    "~/Library/Caches/ai.pluxia.questpump.bridge",
    "~/Library/Logs/ai.pluxia.questpump.bridge",
    "~/Library/WebKit/ai.pluxia.questpump.bridge",
  ]
end
