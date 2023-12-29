function CodeBlock(block)
  -- Check if the code block is Python, C++, JavaScript, or Java
  local lang = block.classes[1]
  if lang == "python" or lang == "cpp" or lang == "javascript" or lang == "java" then
    -- If the code block has no identifier, skip it
    if not block.identifier or block.identifier == "" then
      return block
    end

    local file_extension
    local source_file
    local output_file
    local executable

    if lang == "python" then
      file_extension = "py"
      source_file = block.identifier .. "." .. file_extension
      output_file = block.identifier .. "_output.txt"
      executable = "python"
    
      -- Save the code to a source file
      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()
    
      -- Run the code block using pandoc.pipe and capture the output
      local handle = io.popen(executable .. " " .. source_file .. " 2>&1") -- Capture both stdout and stderr
      local output_text = handle:read("*a")
      handle:close()
    
      -- Create a code block with the output using pandoc.CodeBlock
      local output_block = pandoc.CodeBlock(output_text, "text")
    
      -- Append the output block after the code block using pandoc.List
      local blocks = pandoc.List({block, output_block})
    
      -- Cleanup: remove temporary files
      os.remove(source_file)
      os.remove(output_file)
    
      -- Return the blocks
      return blocks
    
    elseif lang == "cpp" then
      file_extension = "cpp"
      source_file = block.identifier .. "." .. file_extension
      output_file = block.identifier .. "_output.txt"
      executable = "./" .. block.identifier

      -- Save the code to a source file
      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()

      -- Compile the C++ code
      os.execute("g++ -o " .. block.identifier .. " " .. source_file)
    elseif lang == "javascript" then
      file_extension = "js"
      source_file = block.identifier .. "." .. file_extension
      output_file = block.identifier .. "_output.txt"
      executable = "node"

      -- Save the code to a source file
      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()
    elseif lang == "java" then
      file_extension = "java"
      source_file = block.identifier .. "." .. file_extension
      output_file = block.identifier .. "_output.txt"
      executable = "java"

      -- Save the code to a source file
      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()
    end

    -- Run the code block using pandoc.pipe and capture the output
    local handle = io.popen(executable .. " " .. source_file .. " 2>&1") -- Capture both stdout and stderr
    local output_text = handle:read("*a")
    handle:close()

    -- Create a code block with the output using pandoc.CodeBlock
    local output_block = pandoc.CodeBlock(output_text, "text")

    -- Append the output block after the code block using pandoc.List
    local blocks = pandoc.List({block, output_block})

    -- Cleanup: remove temporary files
    os.remove(source_file)
    os.remove(output_file)
    if lang == "cpp" or lang == "java" then
      os.remove(block.identifier)
    end

    -- Return the blocks
    return blocks
  end

  -- Otherwise, return the original block
  return block
end
