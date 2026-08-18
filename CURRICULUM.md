# Git/GitHub Curriculum

This repo is the practice ground. Each level is a puzzle: you'll be told the
*situation* (what your teammate did, what state the repo is in, what's
broken), not the *command* to run. Figuring out which tool fits the
situation -- and why -- is the actual skill being trained. The app (TaskFlow)
just needs to be real enough to produce genuine file-level conflicts; treat
its feature requirements as flavor text.

Levels are roughly ordered by how often you'll hit the technique on a real
team, with your stated fears (PRs, conflicts, cherry-picks, tangled history,
agile process) pulled to the front rather than saved for "advanced" status.

## Level 0 -- Foundations (solo warm-up)

Goal: get the repo and the "team" set up so that, from this point on,
**nothing lands on `main` without a pull request.**

- `git init`, first commit, `gh repo create` (or the website), push `main`.
- Turn on branch protection on `main`: require a pull request before
  merging, require 1 approval, require the CI status check to pass, block
  force-pushes to `main`.
- Set up a second GitHub identity to act as your teammate; add it as a
  collaborator; generate a fine-grained PAT scoped to just this repo.
- Confirm CI (`.github/workflows/ci.yml`) runs and passes on a dummy PR.

Why first: branch protection is what makes every later level *real*. Without
it, "you're supposed to use a PR" is a suggestion you can ignore under
pressure. With it, GitHub enforces the habit for you.

## Level 1 -- Your first feature branch + PR

Concepts: branch naming, small focused commits, `gh pr create`, responding
to review comments, merge-commit vs squash vs rebase-merge, deleting a
merged branch, syncing local `main` after merge.

Scenario: wire up the `task add` command. Your teammate will leave a couple
of review comments before approving -- one nitpick, one real design
question. Practice pushing a fix commit vs amending, and notice how each
shows up in the PR's review thread.

**Decision point:** when you hit "should I `--amend` or add a new commit?"
-- the answer depends on whether the PR has already been reviewed. Amending
after a review makes the reviewer re-diff everything from scratch; a new
commit lets them see just what changed.

## Level 2 -- Your first real merge conflict

Concepts: why conflicts happen, reading conflict markers, `git status`
mid-conflict, `git diff`, `--ours`/`--theirs`, `git merge --abort`, merging
main into your branch vs the reverse.

Scenario: your teammate ships `task complete` while you're mid-flight on
`task list --filter`, and you both touch the same region of
`TaskRepository`. You'll need to bring your branch up to date and resolve
the overlap by hand.

**Decision point:** a conflict is not a sign you did something wrong -- it's
two valid ideas about the same code existing at once. The job is to figure
out what the *combined* correct code is, not to pick a side by reflex.

## Level 3 -- Rebase instead of merge

Concepts: `git pull --rebase`, `git rebase main`, resolving conflicts
commit-by-commit (`--continue`/`--skip`/`--abort`), why rebased commits get
new hashes, `git push --force-with-lease` (never bare `--force`) on a branch
only you own.

Scenario: redo a Level 2-style conflict via rebase, then compare
`git log --graph --oneline --all` for the merge version vs the rebase
version side by side.

**Decision point:** rebase rewrites history, so it's only safe on a branch
nobody else has pulled. Merge is always safe but leaves a merge commit.
Neither is "correct" -- it depends on whether the branch is still private.

## Level 4 -- Cleaning up history before review

Concepts: `git rebase -i HEAD~n`, squash/fixup/reword/reorder,
`git commit --fixup` + `git rebase -i --autosquash`.

Scenario: you'll accumulate a handful of "wip", "typo", "actually fix"
commits on a feature branch. Clean them into 1-2 meaningful commits before
opening the PR.

**Decision point:** if this repo squash-merges every PR anyway (see
CONTRIBUTING.md), does interactive rebase even matter? Yes, but for a
different reason than you'd think -- it's about making the PR *diff* and
*review* easier to follow, not about the final `main` history, which the
squash already flattens for you.

## Level 5 -- Cherry-picking a hotfix

Concepts: `git cherry-pick <sha>`, cherry-pick conflicts, `-x` to record
provenance, release branches, tags.

Scenario: a bug is found in the already-tagged `v0.1.0`, while `main` has
since moved on with unrelated features. Your teammate's fix lands on
`main`; you need exactly that commit on `release/0.1`, and only that commit,
then tag `v0.1.1`.

**Decision point:** cherry-pick is for "I need this one commit somewhere it
didn't originate," not a general substitute for merging. Reach for it when
merging the whole branch would drag in things that aren't ready to ship.

## Level 6 -- Undoing mistakes without fear

Concepts: `git reset --soft/--mixed/--hard` (what each touches), `git
revert` vs `reset` (safe-for-shared vs local-only), `git reflog` as the
actual safety net, recovering a "lost" commit or deleted branch.

Scenario: you'll deliberately wreck something (reset to the wrong commit,
delete a branch with unmerged work) and recover fully using reflog.

**Decision point:** this is the level aimed straight at the fear itself.
The honest fact: as long as a commit was ever made, it's recoverable from
`reflog` for months even if no branch or tag points to it anymore. The
things that are genuinely unrecoverable are narrower than they feel.

## Level 7 -- Untangling messy history

Concepts: `git log --graph`, splitting an oversized commit, `git blame`,
`git bisect`, `git log -S"..."` / `-G"..."` (pickaxe search).

Scenario: a regression is hiding somewhere in ~8 commits of history. Bisect
to find the culprit commit, then use blame/pickaxe to understand *why* that
line exists before fixing it.

**Decision point:** bisect answers "which commit," blame answers "who/when
for this specific line," pickaxe answers "when did this string/pattern
appear or disappear anywhere in the file." Picking the right search tool
first saves a lot of manual log-reading.

## Level 8 -- Parallel work with worktrees (this is the multi-agent one)

Concepts: `git worktree add`, running several branches checked out
simultaneously instead of stashing/switching, integrating them in a
deliberate order, `git rerere` to auto-replay a conflict resolution you've
already done once.

Scenario: three competing branches land at once (standing in for three
parallel AI agents or teammates), touching overlapping files. Set up a
worktree per branch, review each independently, then integrate them one at
a time -- turn on `rerere` before the second integration so the second and
third conflicts don't require redoing the same manual resolution.

**Decision point:** the order you integrate parallel branches in isn't
arbitrary -- integrating the branch most likely to conflict with the others
*first* means the remaining integrations conflict with an already-updated
`main`, not with each other's untested combination.

## Level 9 -- Agile/GitHub-flow, end to end

Concepts: GitHub-flow vs git-flow vs trunk-based (and why GitHub-flow fits
most small teams), `Closes #12` issue linking, draft PRs, CODEOWNERS-driven
review assignment, required status checks, the "Update branch" button vs a
manual rebase, stale-branch cleanup, release notes from commit history.

Scenario: run one full mini-sprint -- issue created, branch linked, draft PR
opened early for visibility, CI red then green, CODEOWNERS auto-requests
your teammate as reviewer, merge, tag a release with generated notes.

**Decision point:** draft PRs exist for a reason distinct from regular PRs
-- they're for "look at my direction before I finish," not "review my
finished work." Using one vs the other is a signal to the team about what
kind of feedback you want.

## Level 10 -- Capstone: everything at once

Concepts: all of the above, combined, with no hint about which tool fixes
it.

Scenario: a branch that's diverged from `main`, has a real conflict, needs
one specific commit cherry-picked elsewhere, has messy history, *and* had
an accidental force-push somewhere in its past. You'll be given the
symptoms, not the diagnosis.

---

## How each level actually runs

1. I (as your teammate, from a second GitHub identity) push commits/branches
   and open PRs that set up the scenario.
2. I describe the situation -- what's true about the repo right now, what
   the goal is -- without naming the git command.
3. You investigate and act, entirely in your own terminal.
4. We debrief: why that command, what else would've worked, what a senior
   engineer would check first, and what the *wrong* fix would have looked
   like.
