# QuestPump's cask (the desktop app, built from helper/) in the tap Pluxia-GmbH/homebrew-tap. The helper's release
# workflow (.github/workflows/helper-release.yml in Pluxia-GmbH/questpump) writes Casks/questpump.rb there from the
# template helper/packaging/homebrew/questpump.rb, with each release's version and the two disk images' checksums:
# change the template, never the tap's copy.
cask "questpump" do
  arch arm: "aarch64", intel: "x64"

  version "1.3.0"
  sha256 arm:   "e4f67aed56c11d6cbfc419c594e23ab8d6aa983734a7bc7cfefa0ed011569614",
         intel: "ce2031114f28b7d0e884c4a33fb967866264d0af87d4749102ca01a465c2fe45"

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
