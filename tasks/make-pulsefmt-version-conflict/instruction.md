A command-line utility named `cache_audit` now depends on the local `pulsefmt` 2.0 API, but the build still points at an older dependency version.

Your task is to fix the repository so that the project builds successfully with `make` and the resulting binary produces the expected output.

Constraints:
- Work only within this repository.
- Do not fetch external dependencies.
- Keep the solution deterministic.
- The final build must be produced by `make`.

Expected binary path:
- `build/bin/cache_audit`
