import subprocess
from pathlib import Path

if Path("/project").exists():
    ROOT = Path("/project")
else:
    ROOT = Path(__file__).resolve().parents[1]

BIN = ROOT / "build" / "bin" / "cache_audit"

def run(cmd, cwd=ROOT):
    result = subprocess.run(cmd, cwd=str(cwd), capture_output=True, text=True)
    assert result.returncode == 0, (
        f"command failed: {cmd}\n"
        f"stdout:\n{result.stdout}\n"
        f"stderr:\n{result.stderr}"
    )
    return result.stdout

def test_show_config_reports_resolved_version():
    out = run(["make", "show-config"])
    assert "pulsefmt_version=2.0" in out

def test_build_succeeds():
    run(["make", "clean"])
    run(["make"])
    assert BIN.exists(), "expected build/bin/cache_audit to exist"

def test_binary_output_is_exact():
    if not BIN.exists():
        run(["make"])
    out = run([str(BIN)])
    assert "CACHE_AUDIT_OK\n" in out
    assert "pulsefmt=2.0\n" in out
    assert "rendered=cache-audit:7:1048576\n" in out
