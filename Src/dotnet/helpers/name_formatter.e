indexing
	description: "Provide formatting of .NET identifiers into Eiffel"

class
	NAME_FORMATTER

feature -- Basic Operations

	format_type_name (name: STRING): STRING is
			-- Format `name' to Eiffel conventions
		require
			non_void_name: name /= Void
		local
			container, nested: STRING
			i: INTEGER
		do
			type_mapping_table.search (name)
			if type_mapping_table.found then
				Result := type_mapping_table.found_item
			else
				Result := clone (name)
				if Result.item (name.count) = ']' then
					Result.keep_head (Result.count - 2)
					Result := "NATIVE_ARRAY [" + format_type_name (Result) + "]"
				else
					i := name.index_of ('+', 1)
					if i > 0 then
						container := name.substring (1, i - 1)
						nested := name.substring (i + 1, name.count)
						Result := format_type_name (nested) + "_IN_" + format_type_name (container)
					else
						if Result.item (Result.count) = '&' then
							Result.keep_head (Result.count - 1)
						end
						Result.replace_substring_all (".", "_")
						Result.replace_substring_all ("___", "_")
						Result.replace_substring_all ("__", "_")
						if Result.item (1) = '_' then
							Result.prepend_character ('X')
						end
						Result := generic_format (Result)
						Result.to_upper
					end
				end
			end
		ensure
			non_void_result: Result /= Void
		end
	
	format_feature_name (name: STRING): STRING is
			-- Format `name' to Eiffel conventions
		require
			non_void_name: name /= Void
		local
			container, nested: STRING
			i: INTEGER
		do
			Result := clone (name)
			if Result.item (Result.count) = '&' then
				Result.keep_head (Result.count - 1)
			end
			Result.replace_substring_all (".", "_")
			Result.replace_substring_all ("___", "_")
			Result.replace_substring_all ("__", "_")
			if Result.item (1) = '_' then
				Result.prepend_character ('x')
			end
			Result := generic_format (Result)
		ensure
			non_void_result: Result /= Void
		end	

	format_variable_name (name: STRING): STRING is
			-- Format `name' to Eiffel conventions
		require
			non_void_name: name /= Void
		local
			l_name: STRING
			i: INTEGER
			container, nested : STRING
		do
				-- resolve conflict names	
			l_name := clone (name)
			l_name.to_lower
			variable_mapping_table.search (l_name)
			if variable_mapping_table.found then
				Result := variable_mapping_table.found_item
			else
				i := name.index_of ('+', 1)
				if i > 0 then
					container := name.substring (1, i - 1)
					nested := name.substring (i + 1, name.count)
					Result := format_type_name (nested) + "_IN_" + format_type_name (container)
				else
					Result := clone (name)
					if Result.item (name.count) = ']' then
						Result.keep_head (Result.count - 2)
						Result := "array_" + format_type_name (Result)
					end
					if Result.item (Result.count) = '&' then
						Result.keep_head (Result.count - 1)
					end
					Result.replace_substring_all (".", "_")
					Result.replace_substring_all ("___", "_")
					Result.replace_substring_all ("__", "_")
					if Result.item (1) = '_' then
						Result.prepend_character ('a')
					end
					Result := generic_format (Result)
				end
			end
		ensure
			non_void_result: Result /= Void
		end
		
	format_argument_type_name (name: STRING): STRING is
			-- Format `name' to Eiffel conventions
		require
			non_void_name: name /= Void
		local
			head: STRING
		do
			head := clone (name)
			head.keep_head (4)
			head.to_lower
			if head.is_equal ("ref ") then
				name.remove_head (4)
				Result := format_variable_name (name)
			else
				Result := format_variable_name (name)
			end
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation

	generic_format (s: STRING): STRING is
			-- Format from CamelCase to eiffel_case
		require
			non_void_value: s /= Void
			first_char: s.item (1) /= '_'
		local
			previous_underscore: BOOLEAN
			previous_digit: BOOLEAN
			i: INTEGER
			c: CHARACTER
		do
			previous_underscore := True
			previous_digit := False
			Result := ""
			from
				i := 1
			until
				i > s.count
			loop
				c := s.item (i)
				if (c.is_upper and not previous_underscore) or else (previous_digit and not c.is_digit) then
					Result := Result + "_" 
				elseif c.is_digit and not previous_digit then
					Result := Result + "_"
				end
				previous_underscore := c.is_upper or c = '_'
				previous_digit := c.is_digit
				Result.append_character (c.to_lower (c))
				i := i + 1
			end
		end

	type_mapping_table: HASH_TABLE [STRING, STRING] is
			-- Special types
		once
			create Result.make (25)
			Result.put ("INTEGER", "Int32")
			Result.put ("INTEGER", "UInt32")
			Result.put ("INTEGER_64", "Int64")
			Result.put ("INTEGER_64", "UInt64")
			Result.put ("INTEGER_16", "Int16")
			Result.put ("INTEGER_16", "Int16")
			Result.put ("INTEGER_8", "Byte")
			Result.put ("INTEGER_8", "SByte")
			Result.put ("CHARACTER", "Char")
			Result.put ("DOUBLE", "Double")
			Result.put ("REAL", "Single")
			Result.put ("BOOLEAN", "Boolean")
			Result.put ("POINTER", "UIntPtr")
			Result.put ("POINTER", "IntPtr")
			Result.put ("VALUE_TYPE", "ValueType")
			Result.put ("ENUM", "Enum")
			Result.put ("SYSTEM_OBJECT", "Object")
			Result.put ("SYSTEM_STRING", "String")
			Result.put ("SYSTEM_ARRAY", "Array")
			Result.put ("SYSTEM_QUEUE", "Queue")
			Result.put ("SYSTEM_CONSOLE", "Console")
			Result.put ("SYSTEM_STREAM", "Stream")
			Result.put ("SYSTEM_STACK", "Stack")
			Result.put ("SYSTEM_DIRECTORY", "Directory")
			Result.put ("SYSTEM_FILE", "File")
		end

	variable_mapping_table: HASH_TABLE [STRING, STRING] is
			-- Protected Eiffel identifiers
		once
			-- Features in ANY Eiffel class
			create Result.make (100)
			Result.put ("copy_", "copy")
			Result.put ("clone_", "clone")
			Result.put ("is_equal_", "is_equal")
			Result.put ("is_equal_", "isequal")
			Result.put ("equal_", "equal")
			Result.put ("default_", "default")
			Result.put ("default_create_", "default_create")
			Result.put ("default_create_", "defaultcreate")
			Result.put ("out_", "out")

			-- Eiffel keywords
			Result.put ("current_", "current")
			Result.put ("class_", "class")
			Result.put ("end_", "end")
			Result.put ("indexing_", "indexing")
			Result.put ("deferred_", "deferred")
			Result.put ("expanded_", "expanded")
			Result.put ("obsolete_", "obsolete")
			Result.put ("feature_", "feature")
			Result.put ("is_", "is")
			Result.put ("frozen_", "frozen")
			Result.put ("prefix_", "prefix")
			Result.put ("infix_", "infix")
			Result.put ("not_", "not")
			Result.put ("and_", "and")
			Result.put ("or_", "or")
			Result.put ("xor_", "xor")
			Result.put ("else_", "else")
			Result.put ("implies_", "implies")
			Result.put ("do_", "do")
			Result.put ("once_", "once")
			Result.put ("local_", "local")
			Result.put ("like_", "like")
			Result.put ("old_", "old")
			Result.put ("if_", "if")
			Result.put ("elseif_", "elseif")
			Result.put ("create_", "create")
			Result.put ("then_", "then")
			Result.put ("inspect_", "inspect")
			Result.put ("when_", "when")
			Result.put ("from_", "from")
			Result.put ("loop_", "loop")
			Result.put ("precursor_", "precursor")
			Result.put ("until_", "until")
			Result.put ("debug_", "debug")
			Result.put ("rescue_", "rescue")
			Result.put ("retry_", "retry")
			Result.put ("unique_", "unique")
			Result.put ("creation_", "creation")
			Result.put ("inherit_", "inherit")
			Result.put ("rename_", "rename")
			Result.put ("as_", "as")
			Result.put ("export_", "export")
			Result.put ("redefine_", "redefine")
			Result.put ("undefine_", "undefine")
			Result.put ("select_", "select")
			Result.put ("strip_", "strip")
			Result.put ("external_", "external")
			Result.put ("alias_", "alias")
			Result.put ("require_", "require")
			Result.put ("ensure_", "ensure")
			Result.put ("invariant_", "invariant")
			Result.put ("check_", "check")
			Result.put ("variant_", "variant")
			Result.put ("true_", "true")
			Result.put ("false_", "false")
			Result.put ("result_", "result")
			Result.put ("bit_", "bit")
		end

end -- class NAME_FORMATTER

