# make-pulsefmt-version-conflict

A small build-systems task about resolving a local dependency version conflict in a GNU Make project.

## Scenario

A command-line utility named `cache_audit` now depends on the `pulsefmt` 2.0 API, but the build still points at an older local dependency version. The repository includes both dependency versions, and the current build fails because the selected header/source pair no longer matches the application code.

Your job is to fix the build system so the project compiles and the binary produces the expected output.

## Constraints

- Work offline only.
- Do not fetch external dependencies.
- Keep the fix inside the repository.
- The final binary must be built by `make`.
- The output must remain deterministic.

## Expected binary path

`build/bin/cache_audit`
