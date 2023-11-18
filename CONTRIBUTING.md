# Contribution Guidelines

> [!IMPORTANT]
> Contributions that were generated in whole or in-part from any
> language model or AI, such as GitHub Copilot, ChatGPT, BARD, or any other such tool
> are explicitly forbidden and will result in your permanent ban from contributing
> to this project.

## Contributing

Contributions to this project are released under the [project's open source license](LICENSE).

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.


## Submitting a Pull Request

 1. [Fork](https://github.com/lethalbit/discretize/fork) and clone the repository
 2. Create a new branch: `git switch -c branch-name` (`git checkout -b branch-name` in the old syntax)
 3. Make your change, create unit tests and sure all tests new and old pass
 4. Push to your fork and submit a [pull request](https://github.com/lethalbit/discretize/compare)

Before your pull request will be accepted, please keep in mind that unless your change is a bugfix, writing unit tests to prove your new code is mandatory.

Additionally, please write good and descriptive commit messages that both summarize the change and,
if necessary, expand on the summary using description lines.
"Patched the utility header" is, while terse and correct, an example of a bad commit message.
"Fixed a bug in core/lang_standards.cc causing issues in C++ handling" is an example of a better commit message.

We would like to be able to look back through the commit history and tell what happened, when, and why without having
to dip into the commit descriptions as this improves the `git bisect` experience and improves everyone's lives.

We use rebasing to merge pull requests, so please keep this in mind and aim to keep a linear history.
