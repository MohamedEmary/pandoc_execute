# Pandoc Executable Code Block Filter

This lua filter adds the exection of a code block inside a markdown file to the PDF right after the code block.

## Supported Languages

The filter supports these languages:

1. **Python**
2. **Javascript**
3. **Java**
4. **C++**

## Usage

To use the filter, just add `#exe` between the `{}` of the code block like this:

````text
```{.python #exec}
print("Hello World")
```
````

You can also use anything else instead of `#exe` like `#execute` or `#run` or anything else you want, but you can't leave it empty like this `{python #}`.

Then add the filter to your pandoc filters folder and run pandoc with the `--lua-filter` option.

```bash
pandoc input.md -o output.pdf --lua-filter execute.lua
```

> [!CAUTION]
> Ensure that no file in the same folder as the markdown file shares the name you've used after the `#`. For instance, if you've used `#execute`, confirm that there isn't a file named `execute.lang` in the same folder as the markdown file. If such a file exists, the filter will delete it.
> For instance, if you use `#execute` with a Python code block like this `{.python #execute}`, the filter will delete the `execute.py` file if it exists. This occurs because the filter creates a temporary file named `execute.py`, executes it, and then removes it upon completion.

## Example

To see an example of the filter in action, check the [`example`](https://github.com/MohamedEmary/pandoc_execute/tree/main/example) folder.
