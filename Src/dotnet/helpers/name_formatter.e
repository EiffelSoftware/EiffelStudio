indexing
	description: "Provide formatting of .NET identifiers into Eiffel"

class
	NAME_FORMATTER

feature -- Basic Operations

	formatted_type_name (name: STRING; depth: INTEGER): STRING is
			-- Format `name' to Eiffel conventions.
			-- Use last `depth' . in .NET name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty and then name.item (1) /= '.'
			valid_depth: depth >= 0 and depth <= name.occurrences ('.')
		local
			partial: STRING
			i, index, count: INTEGER
		do
			count := name.count
			index := name.last_index_of ('.', count)
			if index > 0 then
				from
					i := 1
				until
					i > depth
				loop
					index := name.last_index_of ('.', index - 1)
					i := i + 1
				end
				partial := name.substring (index + 1, count)
			else
				partial := name
			end
			Result := full_formatted_type_name (partial)
		ensure
			non_void_name: Result /= Void
		end
		
	full_formatted_type_name (name: STRING): STRING is
			-- Format .NET type name `name' to Eiffel class name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			i: INTEGER
			container, nested: STRING
		do
			type_mapping_table.search (name)
			if type_mapping_table.found then
				Result := type_mapping_table.found_item
			else
				Result := clone (name)
				if Result.item (name.count) = ']' then
					Result.keep_head (Result.count - 2)
					Result := "NATIVE_ARRAY [" + full_formatted_type_name (Result) + "]"
				else
					i := name.index_of ('+', 1)
					if i > 0 then
						container := name.substring (1, i - 1)
						nested := name.substring (i + 1, name.count)
						Result := full_formatted_type_name (nested) + "_IN_" + full_formatted_type_name (container)
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
						Result := eiffel_format (Result)
						Result.to_upper
					end
				end
			end
		ensure
			non_void_name: Result /= Void
		end
	
	formatted_feature_name (name: STRING): STRING is
			-- Format `name' to Eiffel conventions
		require
			non_void_name: name /= Void
		local
			container, nested: STRING
			i: INTEGER
		do
			operators.search (name)
			if operators.found then
				Result := operators.found_item
			else
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
				Result := eiffel_format (Result)
			end
		ensure
			non_void_result: Result /= Void
		end	

	formatted_variable_name (name: STRING): STRING is
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
					Result := full_formatted_type_name (nested) + "_IN_" + full_formatted_type_name (container)
				else
					Result := clone (name)
					if Result.item (name.count) = ']' then
						Result.keep_head (Result.count - 2)
						Result := "array_" + full_formatted_type_name (Result)
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
					Result := eiffel_format (Result)
				end
			end
		ensure
			non_void_result: Result /= Void
		end
		
	formatted_argument_type_name (name: STRING): STRING is
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
				Result := formatted_variable_name (name)
			else
				Result := formatted_variable_name (name)
			end
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation

	eiffel_format (s: STRING): STRING is
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
				elseif c.is_digit and not previous_digit and not previous_underscore then
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

	operators: HASH_TABLE [STRING, STRING] is
			-- Operator symbols table
		once
			create Result.make (50)
			
			-- Unary operators
			Result.put ("#--", "op_Decrement");
			Result.put ("#++", "op_Increment");
			Result.put ("-", "op_UnaryNegation");
			Result.put ("+", "op_UnaryPlus");
			Result.put ("not", "op_LogicalNot");
			Result.put ("#true", "op_True");
			Result.put ("#false", "op_False");
			Result.put ("&", "op_AddressOf");
			Result.put ("#~", "op_OnesComplement");
			Result.put ("*", "op_PointerDereference");
			
			-- Binary operators
			Result.put ("+", "op_Addition" );
			Result.put ("-", "op_Subtraction");
			Result.put ( "*", "op_Multiply");
			Result.put ( "/", "op_Division");
			Result.put ( "\\", "op_Modulus");
			Result.put ( "xor", "op_ExclusiveOr");
			Result.put ("&", "op_BitwiseAnd");
			Result.put ("|", "op_BitwiseOr");
			Result.put ("and", "op_LogicalAnd");
			Result.put ("or", "op_LogicalOr");
			Result.put ("#=", "op_Assign");
			Result.put ("#<<", "op_LeftShift");
			Result.put ("#>>", "op_RightShift");
			Result.put ("#|>>", "op_SignedRightShift");
			Result.put ("|>>", "op_UnsignedRightShift");
			Result.put ("#==", "op_Equality");
			Result.put (">", "op_GreaterThan");
			Result.put ("<", "op_LessThan");
			Result.put ("|=", "op_Inequality");
			Result.put (">=", "op_GreaterThanOrEqual");
			Result.put ("<=", "op_LessThanOrEqual");
			Result.put ("#|>>=", "op_UnsignedRightShiftAssignment");
			Result.put ("#->", "op_MemberSelection");
			Result.put ("#>>=", "op_RightShiftAssignment");
			Result.put ("#*=", "op_MultiplicationAssignment");
			Result.put ("#->*", "op_PointerToMemberSelection");
			Result.put ("#-=", "op_SubtractionAssignment");
			Result.put ("#^=", "op_ExclusiveOrAssignment");
			Result.put ("#<<=", "op_LeftShiftAssignment");
			Result.put ("#\\=", "op_ModulusAssignment");
			Result.put ("#+=", "op_AdditionAssignment");
			Result.put ("#&=", "op_BitwiseAndAssignment");
			Result.put ("#|=", "op_BitwiseOrAssignment");
			Result.put ("#,", "op_Comma");
			Result.put ("#/=", "op_DivisionAssignment");
		end
		
end -- class NAME_FORMATTER

