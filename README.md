# Pandoc Executable Code Block Filter

This Pandoc Lua filter allows you to execute code blocks within a markdown file and include the output in the generated PDF, right after the corresponding code block.

## Supported Languages

The filter supports the following languages:

1. **Python**
2. **Javascript**
3. **Java**
4. **C++**

## Prerequisites

To use this filter, you must have the corresponding language runtime or compiler installed and accessible from your system's command line:

- For Javascript, you need to have Node.js installed and the `node` command should be available.
- For C++, Java, and Python, the `g++`, `java`, and `python` commands should be available respectively.

If these commands are not recognized by your system, the filter will not work.

## Usage

To use the filter, add `#exec` within the `{}` of the code block, like so:

````text
```{.python #exec}
print("Hello World")
```
````

You can replace `#exec` with any other tag such as `#execute` or `#run`, but it cannot be left empty like `{python #}`.

Then, add the filter to your pandoc filters directory and run pandoc with the `--lua-filter` option:

```bash
pandoc input.md -o output.pdf --lua-filter execute.lua
```

> [!CAUTION]
> Ensure that no file in the directory you run your pandoc command from shares the name you've used after the `#`. For instance, if you've used `#execute` in `{.python #execute}`, confirm that there isn't a file named `execute.py` in the same directory. If such a file exists, the filter will delete it. This occurs because the filter creates a temporary file with the same name, executes it, and then removes it upon completion.
>
> Additionally, ensure there is no file named `_output.txt` in the working directory. This file will also be overwritten then deleted.

## Example

To see a working example of the filter, check the [`example`](https://github.com/MohamedEmary/pandoc_execute/tree/main/example) directory.
