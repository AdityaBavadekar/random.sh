"""Python script to back up open Firefox tabs"""

# requires !pip install lz4


import os
import json
import lz4.block

firefox_dir = os.path.expanduser("~/.mozilla/firefox")
profiles = [p for p in os.listdir(firefox_dir) if p.endswith(".default-release")]

if not profiles:
    print("No Firefox profile found!")
    exit(1)

session_file = os.path.join(firefox_dir, profiles[0], "sessionstore-backups", "recovery.jsonlz4")

if not os.path.exists(session_file):
    print("No active session backup found!")
    exit(1)

# Read and decompress the session file
with open(session_file, "rb") as f:
    data = f.read()

if data[:8] != b"mozLz40\0":
    print("Invalid LZ4 format")
    exit(1)

json_data = json.loads(lz4.block.decompress(data[8:]))  # Skip the magic bytes

backup_data = []
for i, window in enumerate(json_data.get("windows", [])):
    window_tabs = []
    for tab in window.get("tabs", []):
        index = tab.get("index", 1) - 1
        if "entries" in tab and index < len(tab["entries"]):
            window_tabs.append(tab["entries"][index]["url"])
 
    backup_data.append({
        "window": i + 1,
        "tabsCount": len(window_tabs),
        "tabs": window_tabs
    })


backup_file = "firefox_tabs_backup.json"
with open(backup_file, "w") as f:
    json.dump(backup_data, f, indent=4)

print(f"✅ Backup saved to {backup_file}")
