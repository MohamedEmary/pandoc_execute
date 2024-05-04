function CodeBlock(block)
  local lang = block.classes[1]
  if lang == "python" or lang == "cpp" or lang == "js" or lang == "java" then
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
    
      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()
    
      local handle = io.popen(executable .. " " .. source_file .. " 2>&1")
      local output_text = handle:read("*a")
      handle:close()
    
      local output_block = pandoc.CodeBlock(output_text, "text")
    
      local blocks = pandoc.List({block, output_block})
    
      os.remove(source_file)
      os.remove(output_file)
    
      return blocks
    
    elseif lang == "cpp" then
      file_extension = "cpp"
      source_file = block.identifier .. "." .. file_extension
      output_file = block.identifier .. "_output.txt"
      executable = "./" .. block.identifier

      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()

      os.execute("g++ -o " .. block.identifier .. " " .. source_file)
    elseif lang == "js" then
      file_extension = "js"
      source_file = block.identifier .. "." .. file_extension
      output_file = block.identifier .. "_output.txt"
      executable = "node"

      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()
    elseif lang == "java" then
      file_extension = "java"
      source_file = block.identifier .. "." .. file_extension
      output_file = block.identifier .. "_output.txt"
      executable = "java"

      local source_handle = io.open(source_file, "w")
      source_handle:write(block.text)
      source_handle:close()
    end

    local handle = io.popen(executable .. " " .. source_file .. " 2>&1")
    local output_text = handle:read("*a")
    handle:close()

    local output_block = pandoc.CodeBlock(output_text, "text")

    local blocks = pandoc.List({block, output_block})

    os.remove(source_file)
    os.remove(output_file)
    if lang == "cpp" or lang == "java" then
      os.remove(block.identifier)
    end

    return blocks
  end

  return block
end
