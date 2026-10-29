# Upstream maintenance

This template retains the Git history of
[anishathalye/gemini](https://github.com/anishathalye/gemini), so future Gemini
changes can be merged into the KIT/FZI branch.

- **Upstream remote:** `https://github.com/anishathalye/gemini.git`
- **Upstream branch:** `upstream/master`
- **Template branch:** `main`
- **Starting revision:** [`079a1eb4d46f56a645a1865d1922f4553c7fa9d1`](https://github.com/anishathalye/gemini/commit/079a1eb4d46f56a645a1865d1922f4553c7fa9d1), which includes the KIT color theme

Local styling belongs in `beamerthemekitfzi.sty`. Keeping the upstream Gemini
theme and color themes intact makes future updates easier to review.

Git remotes are local configuration and are not inherited when someone clones
this repository. The current local checkout already has `upstream`. In a fresh
clone, check `git remote -v` and add it if it is missing:

```sh
git remote add upstream https://github.com/anishathalye/gemini.git
```

## Bring in Gemini changes

First commit or otherwise save your local edits, including new files. Start
the update with a clean working tree; `git status --short` should produce no
output. The commands below are maintenance instructions to run when ready.

```sh
git switch main
git fetch upstream
git log --oneline HEAD..upstream/master
git diff HEAD...upstream/master
```

Review the incoming changes, then merge them:

```sh
git merge upstream/master
make
make preview
make color-previews
```

A merge may create a commit. Resolve any conflicts while retaining the
KIT/FZI example content and wrapper, then check the generated PDF and all
color-preview PNGs for layout changes before publishing.

## Publish updates

The project is hosted at
[`omersahintas/kit-fzi-latex-poster`](https://github.com/omersahintas/kit-fzi-latex-poster)
with `main` as its default branch. The `origin` remote points to this repository;
keep `upstream` pointing to Gemini.

This is a separate GitHub repository that retains Gemini's history, rather than
a GitHub-managed fork. After committing local changes and checking the previews,
publish updates with:

```sh
git push origin main
```
