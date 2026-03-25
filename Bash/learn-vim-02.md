
# Learn Vim

Vim has different "modes" and "command types" that are easy to confuse. This guide covers ranges, substitution, global commands, normal commands, and advanced techniques like using the quickfix list and macros.

---

## 1. Fundamentals

### 1️⃣ Ranges in Vim Commands

The general form is:

```vim
:[range]s/pattern/replacement/[flags]
```

Some common ranges:

| Range         | Meaning                                                  |
| ------------- | -------------------------------------------------------- |
| `1,$`         | From first line to last line (whole file)                |
| `%`           | Shortcut for `1,$` (whole file)                          |
| `.`           | Current line                                             |
| `.,+3`        | Current line to 3 lines below                            |
| `10,20`       | Line 10 to 20                                            |
| `'<,'>`       | Start and end of the **last visual selection**           |
| `'<, '>s/...` | Substitute only in the lines that were visually selected |

### 2️⃣ Substitution with `%s`

The general form of `:s` is:

```vi
:[range]s/{pattern}/{replacement}/[flags]
```

* `range` → specifies which lines to apply the substitution.
* `pattern` → what you want to match.
* `replacement` → what you want to replace it with.
* `flags` → extra options like `g` (global) or `c` (confirm).

**Examples:**

1. Replace `foo` with `bar` in the current line:

```vi
:s/foo/bar/
```

1. Replace `foo` with `bar` in the **whole file**:

```vi
:%s/foo/bar/g
```

Here:

* `%` → whole file (shortcut for `1,$`, i.e., line 1 to the last line)
* `g` → replace **all occurrences** in a line, not just the first one
* `c` → ask for confirmation on each match

Example with confirmation:

```vi
:%s/foo/bar/gc
```

1. Using `'<,'>` (visual selection) with `:s`

1. Go to **Visual Line** mode (`V`) or **Visual** mode (`v`) and select the text you want.
1. Type `:`. Vim will automatically fill in `:'<,'>` as the range.
1. Complete the command:

```vi
:'<,'>s/foo/bar/g
```

* Only lines you selected will be affected.
* `g` → replace all occurrences in each line
* `c` → confirm each replacement

Example:

* Highlight 5 lines with `v` or `V`.
* `:s/old/new/gc` → replace all `old` with `new` **only in selected lines**.

---

### 3️⃣ Global Commands with `%g`

The `:g` command runs an **ex command** on every line matching a pattern.

```vi
:[range]g/{pattern}/[command]
```

* `%g/foo/d` → delete all lines containing `foo` in the whole file
* `%g/^#/s/old/new/g` → in all lines starting with `#`, replace `old` with `new`

Similarly, `:v` is the opposite of `:g` – runs the command on lines **not matching** the pattern.

---

## 2. Core Commands

### 4️⃣ Normal Commands

Normal commands are the ones you use **without `:`**, while in Normal mode. Examples:

* `dd` → delete current line
* `yy` → copy (yank) current line
* `p` → paste
* `>>` → indent line
* `>>` → indent selection in Visual mode
* `u` → undo
* `Ctrl-r` → redo
* `gg` → go to the top
* `G` → go to the bottom

You can also run normal mode commands from an ex command with `:normal`:

```vi
:[range]normal {commands}
```

Example:

* `:%normal dd` → delete every line in the file (don’t actually do this unless you want an empty file 😅)
* `:g/foo/normal dd` → delete all lines containing `foo`

---

### 5️⃣ Combining Commands with Ranges

You can combine the visual selection range with other ex commands too:

```vim
:'<,'>normal >>   " indent selected lines
:'<,'>g/foo/d     " delete lines in selection containing 'foo'
```

* `'<,'>` always refers to the **last visual selection**.
* It’s very handy for editing **a block of text** instead of the whole file.

---

## 3. Advanced Techniques

### 6️⃣ Quickfix List Commands

The quickfix list lets you run commands over multiple files or errors. Typically:

1. Populate quickfix with a search or compiler error:

```vi
:vimgrep /pattern/ *.txt
```

* `:copen` → open the quickfix window

1. Move through results:

* `:cnext` → go to next quickfix item
* `:cprev` → previous
* `:cc 5` → go to item #5

1. Run normal commands on all quickfix entries:

```vi
:cfdo normal {commands}
```

* `:cfdo normal dd` → delete the line in all quickfix items
* `:cfdo %s/foo/bar/g | update` → replace `foo` with `bar` in all files in the quickfix list and save them

**Notes:**

* `:cfdo` → “do this command for all files in the quickfix list”
* You can also use `:cdo` to run commands at the **current cursor position of each quickfix item** without opening each file.

**Commands:**

| Command      | Use                                                           |
|--------------|---------------------------------------------------------------|
| `:copen`     | Open quickfix window                                          |
| `:cnext`     | Go to next item in quickfix                                   |
| `:cprev`     | Go to previous item                                           |
| `:cc 5`      | Go to item #5                                                 |
| `:cfdo`      | Run a command on all files in the quickfix list               |
| `:cdo`       | Run a command on all items (current cursor line in each file) |
| `:ccexpr []` | Clear entire Quick Fix List                                   |

---

### 7️⃣ Running Macros on Ranges

* You can combine macros with **Visual mode** or `:normal`:

```vim
:'<,'>normal @a
```

* `'<,'>` → your visual selection range
* This runs macro `a` **on each line** of the selection

Example:

* Select 5 lines with `V`
* Run `:'<,'>normal @a`
* Macro `a` runs once on each line

---

### 8️⃣ Using Macros with Global Commands

You can also use macros on all lines matching a pattern:

```vim
:g/pattern/normal @a
```

* This runs macro `a` on every line containing `pattern`.

---

## 4. Tips & Reference

### 9️⃣ Best Practices

* Macros are stored in registers `a–z` temporarily.
* If you want a macro to repeat actions across files, combine with `:cfdo normal @a` (quickfix list) or `:argdo normal @a` (all files in arglist).
* Use `q:` to see your recorded commands in the command-line window.

---

## 5. Quick Reference

### ✅ Command Summary

| Command           | Use                                                            |
| ----------------- | -------------------------------------------------------------- |
| `:%s/foo/bar/g`   | Substitute all `foo` → `bar` in the whole file                 |
| `:%g/pattern/cmd` | Run `cmd` on all lines matching `pattern`                      |
| `normal`          | Run normal-mode commands from ex command                       |
| `:cfdo`           | Run commands on all files in quickfix list                     |
| `:cdo`            | Run commands on all quickfix entries without opening each file |
