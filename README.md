# Pandoc Executable Code Block Filter

This lua filter adds the exection of a code block inside a markdown file to the PDF right after the code block.

## Supported Languages

The filter supports these languages:

1. **Python**
2. **Javascript**
3. **Java**
4. **C++**

## Usage

To use the filter, just add `#exec` between the `{}` of the code block like this:

````text
```{.python #exec}
print("Hello World")
```
````

then add the filter to your pandoc filters folder and run pandoc with the `--lua-filter` option.

```bash
pandoc input.md -o output.pdf --lua-filter execute.lua
```

> [!CAUTION]
> Make sure you don't have any file with the name `exec.lang` like `exec.py` or `exec.js` in the same folder as the markdown file you are trying to compile, otherwise the filter will overwrite it.

## Example

To see an example of the filter in action, check the [`example`](https://github.com/MohamedEmary/pandoc_execute/tree/main/example) folder.
