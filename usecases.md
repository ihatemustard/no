# Use Cases for `no`

`no` is a flexible automation and testing tool. While it looks simple, it is useful in many real-world and playful scenarios.

---

## 1. Default Negative Input Replacement

Example:

```sh
no
```

Example output:

```text
n
n
n
...
```

Why:
Some scripts or programs expect repeated input. `no` provides a fast, explicit way to send negative responses.

---

## 2. Custom Repeated Text

Example:

```sh
no "I disagree"
```

Example output:

```text
I disagree
I disagree
I disagree
...
```

Use case:
Testing programs that read from stdin, stress-testing input handling, or scripting repetitive output.

---

## 3. Limiting Output with --times / -t

Example:

```sh
no --times 3
```

Example output:

```text
n
n
n
```

Use case:
Prevent infinite output when piping into commands like head, sed, or logs.

---

## 4. Timed Input with --interval / -i

Example:

```sh
no --interval 0.5 --times 5
```

Example output:

```text
n
(wait 0.5s)
n
(wait 0.5s)
n
(wait 0.5s)
n
(wait 0.5s)
n
```

Use case:
Simulating human-like delays for scripts that expect pauses between inputs.

---

## 5. Logging Output with --output / -o

Example:

```sh
no example -o output.txt --times 3
```

Contents of output.txt:

```text
example
example
example
```

Use case:
Writing automated responses to files without shell redirection.

---

## 6. Counting Output with --count / -c

Example:

```sh
no --count --times 3
```

Example output:

```text
1: n
2: n
3: n
```

Use case:
Debugging, logging, or tracking how many responses were sent.

---

## 7. Randomized Responses with --random / -r

Example:

```sh
no --random "no,nah,nop,never" --times 4
```

Example output:

```text
nah
no
never
nop
```

Use case:
Testing scripts that should handle varying input instead of a fixed value.

---

## 8. Executing Commands Repeatedly (--command / -cmd)

Example:

```sh
no --command "date" --times 3
```

Example output:

```text
Mon Jan  1 12:00:01 UTC 2025
Mon Jan  1 12:00:02 UTC 2025
Mon Jan  1 12:00:03 UTC 2025
```

Why this exists:
Sometimes you want dynamic output, not static text.

Example with delay:

```sh
no --command "uptime" --interval 1
```

Example output:

```text
12:00  up 10 days,  2 users, load averages: 0.12 0.09 0.05
12:00  up 10 days,  2 users, load averages: 0.13 0.10 0.06
12:00  up 10 days,  2 users, load averages: 0.11 0.08 0.05
```

---

## 9. Combining Features

Example:

```sh
no --command "echo no" --count --interval 0.2 --times 5
```

Example output:

```text
1: no
2: no
3: no
4: no
5: no
```
