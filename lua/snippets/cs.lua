local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

local function node_text(node, bufnr)
    return vim.treesitter.get_node_text(node, bufnr)
end

local function get_root(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "c_sharp")
    if not parser then
        return nil
    end
    local tree = parser:parse()[1]
    return tree and tree:root() or nil
end

local function is_decl(node)
    if not node then
        return false
    end
    local t = node:type()
    return t == "class_declaration"
        or t == "constructor_declaration"
        or t == "method_declaration"
end

local function collect_decls(node, out)
    for child in node:iter_children() do
        if is_decl(child) then
            table.insert(out, child)
        end
        collect_decls(child, out)
    end
end

local function sort_nodes_by_pos(nodes)
    table.sort(nodes, function(a, b)
        local ar, ac = a:range()
        local br, bc = b:range()
        if ar == br then
            return ac < bc
        end
        return ar < br
    end)
end

local function get_attribute_rows(decl)
    local rows = {}

    for child in decl:iter_children() do
        if child:type() == "attribute_list" then
            local sr = child:range()
            table.insert(rows, sr)
        end
    end

    table.sort(rows)
    return rows
end

local function get_valid_doc_row(decl)
    local decl_row = decl:range()
    local attr_rows = get_attribute_rows(decl)

    if #attr_rows > 0 then
        return attr_rows[1] - 1
    end

    return decl_row - 1
end

local function find_next_decl_after_row(root, row)
    local decls = {}
    collect_decls(root, decls)
    sort_nodes_by_pos(decls)

    for _, decl in ipairs(decls) do
        local decl_row = decl:range()
        if decl_row > row then
            return decl
        end
    end

    return nil
end

local function get_parameter_list_node(decl)
    for child in decl:iter_children() do
        if child:type() == "parameter_list" then
            return child
        end
    end
    return nil
end

local function extract_param_names(param_list, bufnr)
    local params = {}

    for child in param_list:iter_children() do
        if child:type() == "parameter" then
            local name_field = child:field("name")
            local name_node = name_field and name_field[1] or nil

            if name_node then
                table.insert(params, node_text(name_node, bufnr))
            else
                for grandchild in child:iter_children() do
                    if grandchild:type() == "identifier" then
                        table.insert(params, node_text(grandchild, bufnr))
                        break
                    end
                end
            end
        end
    end

    return params
end

local function get_return_type(decl, bufnr)
    if decl:type() ~= "method_declaration" then
        return nil
    end

    local type_field = decl:field("type")
    if type_field and type_field[1] then
        return node_text(type_field[1], bufnr)
    end

    return nil
end

local function should_add_returns(decl, bufnr)
    if decl:type() ~= "method_declaration" then
        return false
    end

    local return_type = get_return_type(decl, bufnr)
    if not return_type then
        return false
    end

    return return_type ~= "void"
end

local function find_target_decl_if_valid_position(bufnr)
    local root = get_root(bufnr)
    if not root then
        return nil
    end

    local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
    local decl = find_next_decl_after_row(root, cursor_row)
    if not decl then
        return nil
    end

    local valid_doc_row = get_valid_doc_row(decl)

    if cursor_row ~= valid_doc_row then
        return nil
    end

    return decl
end

local function generate_csharp_doc()
    local bufnr = vim.api.nvim_get_current_buf()
    local decl = find_target_decl_if_valid_position(bufnr)

    if not decl then
        return nil
    end

    local lines = {
        "/// <summary>",
        "/// ",
        "/// </summary>",
    }

    local param_list = get_parameter_list_node(decl)
    if param_list then
        local params = extract_param_names(param_list, bufnr)
        for _, name in ipairs(params) do
            table.insert(lines, ('/// <param name="%s"></param>'):format(name))
        end
    end

    if should_add_returns(decl, bufnr) then
        table.insert(lines, "/// <returns></returns>")
    end

    return lines
end

ls.add_snippets("cs", {
    s({ trig = "///", snippetType = "autosnippet" }, {
        f(function()
            local lines = generate_csharp_doc()
            if lines then
                return lines
            end
            return { "///" }
        end, {}),
    }),
})
