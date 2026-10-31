# poweramp-skins

Skins for [Poweramp](https://powerampapp.com/) v3. Each skin is a small Android app in its own folder.

| Skin | Folder | What it is |
| --- | --- | --- |
| Liquid Glass | [liquid-glass/](liquid-glass/) | Glass on controls and navigation only (per Apple's HIG). Light and dark skins, Regular/Clear variant, "Reduce transparency" option. |

## Getting a build

Push to `main`. After a few minutes a new release shows up under **Releases** with one APK per skin
(`liquid-glass-1.0.N.apk`). Install it on the phone, then in Poweramp: **Settings > Skin > Liquid Glass**.
Progress (and errors) are under **Actions**.

Every release is signed with the same key, so a new APK installs over the previous one.
Pushes that only change `.md` files don't make a release.

## Where to change things (Liquid Glass)

All under `liquid-glass/src/main/res/`:

- `values/liquid_glass_styles.xml`: the skin itself. The top of each theme (`LiquidGlass` light,
  `LiquidGlassDark` dark) holds the glass colors: change those to retune the whole look.
- `drawable/lg_*.xml`: the glass shapes (bar, capsule, button, label), drawn from those colors.
- `xml/skins.xml`: the skins and options Poweramp lists.
- `values/liquid_glass_strings.xml`: names and descriptions shown in Poweramp.

Poweramp's docs on skinning: [poweramp_skin_sample/readme.md](https://github.com/maxmpz/powerampapi/blob/master/poweramp_skin_sample/readme.md).
Its resources, for looking up what can be overridden: [poweramp_skin_sdk/reference_resources](https://github.com/maxmpz/powerampapi/tree/master/poweramp_skin_sdk/reference_resources).

### stable-ids.txt

`liquid-glass/stable-ids.txt` keeps resource IDs the same between builds, so users' skin options aren't reset.
The build updates it when you add styles. Commit it when it changes. If a release run warns that it changed,
the run log shows the lines to add.

## Building locally (optional)

Needs JDK 17+ and the Android SDK (Android Studio has both).

```sh
scripts/fetch-poweramp-resources.sh   # once: Poweramp resources the skin links against
./gradlew assembleRelease             # liquid-glass/build/outputs/apk/release/
```

Local builds are signed with the debug key, so uninstall the release version first.
To link against a different Poweramp APK, put `poweramp.apk=<path>` in `local.properties`.
In Poweramp, **Settings > Misc > Always Reload Skin** helps while iterating.

## Adding another skin

Copy `liquid-glass/` to a new folder and change `namespace`/`applicationId` in its `build.gradle`,
the Java package, and the style names, and empty its `stable-ids.txt`. Then add the folder to `settings.gradle`. Releases pick it up automatically.
