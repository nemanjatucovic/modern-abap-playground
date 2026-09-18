# Git Workflow

This repository uses a simple feature-branch workflow.

```text
main
  |
  +-- feature/<feature-name>
          |
          +-- focused commits
          |
          +-- pull request
                  |
                  +-- review
                  |
                  +-- merge to main
```

## Principles

- Keep `main` in a presentable state.
- Develop meaningful changes on feature branches.
- Prefer focused commit messages that describe the change.
- Use pull requests to review the complete change before merging.
- Never publish proprietary customer/employer code, credentials, internal URLs, or real business data.

The `feature/po-approval-engine` branch is the first example of this workflow in the repository.
