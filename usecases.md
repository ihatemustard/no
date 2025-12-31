# Use Cases for `no`

`no` is a modern, high-performance sequence generator and automation utility. While it begins as the logical opposite of the classic Unix `yes` command, its advanced features make it a lightweight alternative to complex loops in shell scripting.

## Why `no` is a Useful Tool

* **Readability:** Replaces messy `for i in $(seq 1 10); do...done` loops with clean, one-line commands.
* **Native Logic:** Handles floating-point math, zero-padding, and character sequences (`a:z`) natively, which standard POSIX shells struggle with.
* **Simulation:** With `--interval` and `--random`, it can simulate human input or unpredictable network traffic for testing.
* **Formatting:** Built-in `printf` support allows generating structured data (JSON, CSV, SQL) without piping into multiple text processors.

## 1. Sequence Generation (`--seq`, `--step`)

Handles numeric and alphabetical ranges, including reverse counts and custom increments.

**Example: Countdown for a script launch**

```bash
no --seq 5:1 --interval 1
```

**Example: Floating point increments**

```bash
no --seq 0:1 --step 0.25 --precision 2
```

Output:

```
0.00, 0.25, 0.50, 0.75, 1.00
```

## 2. Advanced Data Formatting (`--format` / `-f`)

Wrap output in a template instead of just printing a number.

**Example: Generating dummy filenames or URLs**

```bash
no --seq 1:3 -f "https://api.example.com/v1/user/%03d"
```

Output:

```
https://api.example.com/v1/user/001
https://api.example.com/v1/user/002
https://api.example.com/v1/user/003
```

## 3. Grid & Layout Control (`-cols`)

Useful for quick terminal dashboards or organizing long lists into readable chunks.

**Example: Organizing the alphabet into columns**

```bash
no --seq a:z -cols 13
```

Output:

```
a  b  c  d  e  f  g  h  i  j  k  l  m
n  o  p  q  r  s  t  u  v  w  x  y  z
```

## 4. Custom Delimiters (`--separator` / `-s`)

Define how items are separated instead of standard one-item-per-line output.

**Example: Creating a comma-separated list for a SQL IN clause**

```bash
no --seq 101:105 -s ", "
```

Output:

```
101, 102, 103, 104, 105
```

## 5. Automated System Monitoring (`--command` / `-cmd`)

Combine command execution with intervals to create a lightweight "watch" tool.

**Example: Check CPU temperature every second**

```bash
no --command "sysctl -n hw.acpi.thermal.tz0.temperature" --interval 1 --count
```

## 6. Zero-Padding & Precision (`--pad`, `--precision`)

Perfect for creating ordered backups or log files that sort correctly in a file explorer.

**Example: Create 10 empty log files with 3-digit padding**

```bash
no --seq 1:10 --pad 3 -f "log_%s.txt" | xargs touch
```

Creates: `log_001.txt`, `log_002.txt`, ...

## 7. Randomized Stress Testing (`--random` / `-r`)

Test how your applications handle non-deterministic input.

**Example: Fuzzing a form with random responses**

```bash
no --random "ACCEPT,REJECT,RETRY,PENDING" --times 10
```
