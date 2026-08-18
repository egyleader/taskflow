# Contributing conventions

These are the ground rules the "team" (you + your teammate persona) follows
in this repo. They're realistic defaults you'll see on most professional
Dart/Flutter teams -- not universal law, but a sane baseline worth having
opinions about once you've used it for a while.

## Branch naming

- `feat/<short-description>` -- new functionality
- `fix/<short-description>` -- bug fix
- `chore/<short-description>` -- tooling, CI, deps, non-behavioral cleanup
- `release/<version>` -- long-lived branch tracking a shipped release line

## Commit messages (Conventional Commits, lightly enforced)

```
<type>(optional scope): <short summary>

<optional body -- the "why", not the "what">
```

Types we use: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`.

Small, focused commits beat one giant commit. You can always squash later
(see Level 4) -- you can't easily un-squash.

## Pull requests

- One PR = one reviewable idea. If you're struggling to describe it in one
  sentence, it's probably two PRs.
- PR description should say *why*, link the issue if there is one
  (`Closes #12`), and call out anything you want the reviewer to look at
  specifically.
- Default merge strategy for this repo: **squash and merge**, unless a level
  explicitly asks you to try merge-commit or rebase-merge to compare.
- Don't force-push to `main`. Ever. Force-pushing your own feature branch
  after a rebase is fine and expected -- use `git push --force-with-lease`,
  never bare `--force`.

## Reviews

- Leave comments as questions or suggestions, not commands, when the call is
  genuinely a judgment call.
- The author resolves conversations after addressing them, not the
  reviewer.
- CI must be green before merge -- branch protection enforces this, so if
  you find yourself wanting to merge with a red check, that's a signal to
  stop and ask why, not to find a workaround.
