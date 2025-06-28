Rust Linux GNU Builder Action
========================

![GitHub](https://img.shields.io/github/license/sevco/rust-linux-gnu-action)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/sevco/rust-linux-gnu-action)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/sevco/rust-linux-gnu-action/CI)

GitHub action for building rust binaries linked to glibc 2.17 (x86_64-unknown-linux-gnu - based on CentOS 7).

```yaml
- uses: sevco/rust-linux-gnu-action@1.88.0
  with:
    args: build --release --all-features
    git_credentials: ${{ secrets.GIT_CREDENTIALS }}
```
### Inputs
| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| args     | Arguments passed to cargo | true | `build --release` | 
| git_credentials | If provided git will be configured to use these credentials and https | false | |
| directory | Relative path under $GITHUB_WORKSPACE where Cargo project is located | false | |
