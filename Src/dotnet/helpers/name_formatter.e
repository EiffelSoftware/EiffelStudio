indexing
	description: "Provide formatting of .NET identifiers into Eiffel"

class
	NAME_FORMATTER

feature -- Basic Operations

	formatted_type_name (name: STRING; used_names: HASH_TABLE [STRING, STRING]): STRING is
			-- Format `name' to Eiffel conventions.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty and then name.item (1) /= '.'
			used_names_not_void: used_names /= Void
		local
			i, index, pos, count: INTEGER
		do
			index := name.occurrences ('.')
			if index > 0 then
				from
					count := name.count
					pos := name.last_index_of ('.', count)
					Result := full_formatted_type_name (name.substring (pos + 1, count))
					i := 2
				until
					i > index or else not used_names.has (Result)
				loop
					pos := name.last_index_of ('.', pos - 1)
					Result := full_formatted_type_name (name.substring (pos + 1, count))
					i := i + 1
				end
			else
				Result := full_formatted_type_name (name)
			end
			if used_names.has (Result) then
				from
					count := 2
				until
					not used_names.has (Result)
				loop
					trim_end_digits (Result)
					Result.append (count.out)
					count := count + 1
				end
			end
			used_names.put (Result, Result)
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
				create Result.make_from_string (name)
				if Result.item (name.count) = ']' then
					Result.keep_head (Result.count - 2)
					Result.append (native_array_string)
					Result.append (full_formatted_type_name (Result))
					Result.append_character (']')
				else
					i := name.index_of ('+', 1)
					if i > 0 then
						container := name.substring (1, i - 1)
						nested := name.substring (i + 1, name.count)
							-- Estimated allocation size.
						create Result.make (name.count + 5)
						Result.append (full_formatted_type_name (nested))
						Result.append (in_string)
						Result.append (full_formatted_type_name (container))
					else
						if Result.item (Result.count) = '&' then
							Result.keep_head (Result.count - 1)
						end
						Result.replace_substring_all (single_dot_string, single_underscore_string)
						Result.replace_substring_all (triple_underscore_string,
							single_underscore_string)
						Result.replace_substring_all (double_underscore_string,
							single_underscore_string)
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
		do
			operators.search (name)
			if operators.found then
				Result := operators.found_item
			else
				Result := formatted_variable_name (name)
			end
			Result := Result.twin
		ensure
			non_void_result: Result /= Void
		end	

	formatted_argument_name (name: STRING; pos: INTEGER): STRING is
			-- Format argument at position `pos'.
		require
			name_not_void: name /= Void
		do
			if name.is_empty then
				Result := "arg_" + pos.out
			else
				Result := formatted_variable_name (name)
			end
		ensure
			formatted_argument_name_not_void: Result /= Void
		end
		
	formatted_variable_name (name: STRING): STRING is
			-- Format `name' to Eiffel conventions
		require
			non_void_name: name /= Void
			name_not_empty: not name.is_empty
		local
			l_name: STRING
			l_var: like variable_mapping_table
		do
				-- resolve conflict names	
			create l_name.make_from_string (name)
			l_name.to_lower
			l_var := variable_mapping_table
			l_var.search (l_name)
			if l_var.found then
				Result := l_var.found_item
			else
				create Result.make_from_string (name)
				if Result.item (Result.count) = '&' then
					Result.keep_head (Result.count - 1)
				end
				Result.replace_substring_all (Single_dot_string, Single_underscore_string)
				Result.replace_substring_all (Triple_underscore_string, Single_underscore_string)
				Result.replace_substring_all (Double_underscore_string, Single_underscore_string)
				if Result.item (1) = '_' then
					Result.prepend_character ('a')
				end
				Result := eiffel_format (Result)
			end
		ensure
			non_void_result: Result /= Void
		end

	formatted_variable_type_name (name: STRING): STRING is
			-- Format variable name that represent a type into Eiffel
			-- naming convention.
		require
			non_void_name: name /= Void
		local
			i, index: INTEGER
			container, nested: STRING
			l_arg: like argument_mapping_table
		do
			index := name.last_index_of ('.', name.count)
			if index > 0 then
				Result := name.substring (index + 1, name.count)
			else
				Result := name
			end
			if name.item (name.count) = '&' then
				Result := Result.substring (1, Result.count - 1)
			end
			l_arg := argument_mapping_table
			l_arg.search (Result)
			if l_arg.found then
				Result := l_arg.found_item
			else
				i := name.index_of ('+', 1)
				if i > 0 then
					container := name.substring (1, i - 1)
					nested := name.substring (i + 1, name.count)
					create Result.make (name.count + 5)
					Result.append (formatted_variable_type_name (nested))
					Result.append (in_string)
					Result.append (formatted_variable_type_name (container))
				else
					if Result.item (Result.count) = ']' then
						container := Result.substring (1, Result.count - 2)
						create Result.make (container.count + 6)
						Result.append (formatted_variable_type_name (container))
						Result.append (array_string)
					end
					Result.replace_substring_all (".", single_underscore_string)
					Result.replace_substring_all (triple_underscore_string,
						single_underscore_string)
					Result.replace_substring_all (double_underscore_string,
						single_underscore_string)
					Result := eiffel_format (Result)
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	valid_variable_name (name: STRING): STRING is
			-- Format `name' to Eiffel valid variable name.
		require
			non_void_name: name /= Void
			name_not_empty: not name.is_empty
		local
			l_name: STRING
			l_var: like variable_mapping_table
		do
				-- resolve conflict names	
			create l_name.make_from_string (name)
			l_name.to_lower
			l_var := variable_mapping_table
			l_var.search (l_name)
			if l_var.found then
				Result := l_var.found_item
			else
				create Result.make_from_string (name)
				if Result.item (Result.count) = '&' then
					Result.keep_head (Result.count - 1)
				end
				Result.replace_substring_all (Single_dot_string, Single_underscore_string)
				Result.replace_substring_all (Triple_underscore_string, Single_underscore_string)
				Result.replace_substring_all (Double_underscore_string, Single_underscore_string)
				if Result.item (1) = '_' then
					Result.prepend_character ('a')
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	is_valid_variable_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid variable name?
		require
			non_void_a_name: a_name /= Void
		do
			if
				a_name.is_empty or
				variable_mapping_table.has (a_name) or
				a_name.has (' ') or
				a_name.has ('.') or
				a_name.has ('&') or
				a_name.has ('#') or
				a_name.has ('@')
			then
				Result := False
			else
				Result := True
			end
		end
		

feature {NONE} -- Implementation

	trim_end_digits (s: STRING) is
			-- 	Remove end digits from `s' and append `_' if needed.
		require
			non_void_string: s /= Void
		local
			i: INTEGER
			done: BOOLEAN
		do
			from
				i := s.count
			until
				done or i < 1
			loop
				inspect
					s.item (i)
				when '0'..'9' then
					s.keep_head (s.count - 1)
				else
					done := True
				end
				i := i - 1
			end
			if s.item (s.count) /= '_' then
				s.append_character ('_')
			end
		ensure
			trimmed: s.item (s.count) = '_'
		end

	eiffel_format (s: STRING): STRING is
			-- Format from CamelCase to eiffel_case
		require
			non_void_value: s /= Void
			valid_value: not s.is_empty
			first_char: s.item (1) /= '_'
		local
			p, c, n: CHARACTER
			nb, i: INTEGER
			put_us: BOOLEAN
		do
			create Result.make (s.count + (s.count // 2)) 
				-- Allocate an extra 1/3 to avoid unecessary resizing
			Result.append_character (s.item (1).lower)
			if s.count >= 2 then
				from
					i := 2
					p := s.item (i - 1) 
					c := s.item (i) 
					nb := s.count
				until
					i >= nb
				loop
					put_us := False
					n := s.item (i + 1)
					if c /= '_' then
						if c.is_digit and not p.is_digit and p /= '_' and not p.is_upper then
							-- add '_' before a digit only if nor preceeded by uppercase characters
							-- UTF8Decoder = UTF8_DECODER, Border3D = BORDER_3D
							put_us := True
						elseif p.is_digit and not c.is_digit then
							if n /= '_' and not n.is_digit then
								-- 3dd = 3_dd, 3Dd = 3_Dd, 3DD = 3DD, 3dD = 3d_D, 3D_ = 3D_, 3d_ = 3d_
								put_us := (c.is_lower and n.is_lower) or (c.is_upper and n.is_lower)
							end
						elseif p.is_upper and c.is_upper and n.is_lower then
							put_us := (i = 2 implies p /= 'I') or i > 2 -- allows IInterfaceName = IINTERFACE_NAME but FBar = F_BAR as per other rules, but allows UICues = UI_CUES
						elseif p.is_lower and c.is_upper then
							put_us := True
						end
					else
						put_us := False
					end	
	
					if put_us then
						Result.append_character ('_')				
					end					
					Result.append_character (c.lower)
					i := i + 1
					
					p := c
					c := n
				end
				
				if (p.is_alpha and p.is_lower and c.is_digit) or (p.is_lower and c.is_upper) then
					Result.append_character ('_')
				end
				Result.append_character (c.lower)
			end
		end
		
	type_mapping_table: HASH_TABLE [STRING, STRING] is
			-- Special types
		once
			create Result.make (100)
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
			Result.put ("SYSTEM_MEMORY_STREAM", "MemoryStream")
			Result.put ("SYSTEM_STACK", "Stack")
			Result.put ("SYSTEM_DIRECTORY", "Directory")
			Result.put ("SYSTEM_FILE", "File")
			Result.put ("SYSTEM_DATE_TIME", "DateTime")
			Result.put ("SYSTEM_SORTED_LIST", "SortedList")
			Result.put ("SYSTEM_RANDOM", "Random")
			Result.put ("SYSTEM_CONTAINER", "Container")
			Result.put ("SYSTEM_CONVERT", "Convert")
			
				-- Threading conflicts
			Result.put ("SYSTEM_THREAD", "Thread")
			Result.put ("SYSTEM_MUTEX", "Mutex")

				-- Zone
			Result.put ("SYSTEM_ZONE", "Zone")
		end

	variable_mapping_table: HASH_TABLE [STRING, STRING] is
			-- Protected Eiffel identifiers
		once
			-- Features in ANY Eiffel class
			create Result.make (65)

			-- Eiffel keywords
			Result.put ("agent_", "agent")
			Result.put ("alias_", "alias")
			Result.put ("all_", "all")
			Result.put ("and_", "and")
			Result.put ("as_", "as")
			Result.put ("assign_", "assign")
			Result.put ("bit_", "bit")
			Result.put ("check_", "check")
			Result.put ("class_", "class")
			Result.put ("convert_", "convert")
			Result.put ("create_", "create")
			Result.put ("creation_", "creation")
			Result.put ("current_", "current")
			Result.put ("debug_", "debug")
			Result.put ("deferred_", "deferred")
			Result.put ("do_", "do")
			Result.put ("else_", "else")
			Result.put ("elseif_", "elseif")
			Result.put ("end_", "end")
			Result.put ("ensure_", "ensure")
			Result.put ("expanded_", "expanded")
			Result.put ("export_", "export")
			Result.put ("external_", "external")
			Result.put ("false_", "false")
			Result.put ("feature_", "feature")
			Result.put ("from_", "from")
			Result.put ("frozen_", "frozen")
			Result.put ("if_", "if")
			Result.put ("implies_", "implies")
			Result.put ("indexing_", "indexing")
			Result.put ("infix_", "infix")
			Result.put ("inherit_", "inherit")
			Result.put ("inspect_", "inspect")
			Result.put ("invariant_", "invariant")
			Result.put ("is_", "is")
			Result.put ("like_", "like")
			Result.put ("local_", "local")
			Result.put ("loop_", "loop")
			Result.put ("not_", "not")
			Result.put ("obsolete_", "obsolete")
			Result.put ("old_", "old")
			Result.put ("once_", "once")
			Result.put ("or_", "or")
			Result.put ("prefix_", "prefix")
			Result.put ("precursor_", "precursor")
			Result.put ("pure_", "pure")
			Result.put ("redefine_", "redefine")
			Result.put ("reference_", "reference")
			Result.put ("rename_", "rename")
			Result.put ("require_", "require")
			Result.put ("rescue_", "rescue")
			Result.put ("result_", "result")
			Result.put ("retry_", "retry")
			Result.put ("select_", "select")
			Result.put ("separate_", "separate")
			Result.put ("strip_", "strip")
			Result.put ("then_", "then")
			Result.put ("true_", "true")
			Result.put ("tupple_", "tupple")
			Result.put ("undefine_", "undefine")
			Result.put ("unique_", "unique")
			Result.put ("until_", "until")
			Result.put ("variant_", "variant")
			Result.put ("when_", "when")
			Result.put ("xor_", "xor")
		end 

	argument_mapping_table: HASH_TABLE [STRING, STRING] is
			-- Mapping for type when used in feature name to distinguish between
			-- different overloading.
		once
			create Result.make (50)
			Result.put ("boolean", "Boolean")
			Result.put ("character", "Char")
			Result.put ("integer8", "Byte")
			Result.put ("integer8", "SByte")
			Result.put ("integer16", "Int16")
			Result.put ("integer16", "UInt16")
			Result.put ("integer", "Int32")
			Result.put ("integer", "UInt32")
			Result.put ("pointer", "IntPtr")
			Result.put ("integer64", "Int64")
			Result.put ("integer64", "UInt64")
			Result.put ("double", "Double")
			Result.put ("real", "Single")
		end

	operators: HASH_TABLE [STRING, STRING] is
			-- Operator symbols table
		once
			create Result.make (200)
			
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
	
feature {NONE} -- Constants

	single_dot_string: STRING is "."
	single_underscore_string: STRING is "_"
	double_underscore_string: STRING is "__"
	triple_underscore_string: STRING is "___"
	array_string: STRING is "_array"
	native_array_string: STRING is "NATIVE_ARRAY ["
	in_string: STRING is "_IN_"
			-- To save time in creating those strings in current class.

end -- class NAME_FORMATTER

