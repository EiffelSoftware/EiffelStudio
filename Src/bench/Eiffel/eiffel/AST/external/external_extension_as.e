indexing
	description: "Encapsulation of an external extension."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_EXTENSION_AS

inherit
	COMPILER_EXPORTER
	
	SHARED_AST_CONTEXT

	SHARED_ERROR_HANDLER
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Properties

	argument_types: ARRAY [INTEGER]
			-- Types of the arguments (extracted from the C signature)

	return_type: INTEGER
			-- Return type (extracted from the C signature)

	header_files: ARRAY [INTEGER]
			-- Header files to include

feature -- Conveniences

	is_macro: BOOLEAN is
			-- Is this a macro extension?
		do
		end

	is_struct: BOOLEAN is
			-- Is this a struct extension?
		do
		end

	is_dll: BOOLEAN is
			-- Is this a dll extension?
		do
		end

	has_signature: BOOLEAN is
			-- Does the extension define a c_signature?
		do
			Result := return_type > 0 or else argument_types /= Void
		end

feature {EXTERNAL_LANG_AS} -- Implementation

	parse is
			-- Parse the external extension.
		do
			parse_signature
			parse_include_files
			parse_special_part

				-- Clean memory from non-used attributes
			c_signature := Void
			include_files := Void
			special_part := Void
		end

feature -- Feature information

	extension_i: EXTERNAL_EXT_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		deferred
		end

	init_extension_i (ext_i: EXTERNAL_EXT_I) is
			-- Initialize `ext_i'
		require
			ext_i_not_void: ext_i /= Void
		do
			ext_i.set_argument_types (argument_types)
			ext_i.set_header_files (header_files)
			ext_i.set_return_type (return_type)
		end

	need_encapsulation: BOOLEAN is
			-- Does this language extension need an encapsulation?
		deferred
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS) is
			-- Perform type check on Current associated with `ext_as_b'.
		do
			type_check_signature
		end

	type_check_signature is
			-- Perform type check on the signature.
		local
			ext_same_sign: EXT_SAME_SIGN
			error: BOOLEAN
		do
			if has_signature then
				if argument_types /= Void then
					if argument_types.count /= context.current_feature.argument_count then
						error := True
					end
				end
				if (return_type = 0) = context.current_feature.is_function then
					error := True
				end

				if error then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
			end
		end

feature -- Byte code

	byte_node: EXT_EXT_BYTE_CODE is
			-- Byte code for external extension
		deferred
		end

	init_byte_node (b: EXT_EXT_BYTE_CODE) is
			-- Initialize byte node.
		require
			b_not_void: b /= Void
		do
			b.set_argument_types (argument_types)
			b.set_header_files (header_files)
			b.set_return_type (return_type)
		end

feature -- Setting

	set_include_files (s: STRING) is
			-- Assign `s' to `include_files'.
		do
			include_files := s
		end

	set_signature (s: STRING) is
			-- Assign `s' to `c_signature'.
		do
			c_signature := s
		end

	set_special_part (s: STRING) is
			-- Assign `s' to `special_part'.
		do
			special_part := s
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the special part clause.
		do
		end

	parse_signature is
			-- Parse the signature clause.
		local
			end_arg_list: INTEGER
			pos, comma_pos, end_pos: INTEGER
			arg_count: INTEGER
			a_type: STRING
		do
			if c_signature /= Void then
				if c_signature @ 1 = '(' then
					end_arg_list := c_signature.index_of (')', 1)
					!! argument_types.make (1, 0)
					from
						pos := 2
					until
						pos >= end_arg_list
					loop
						comma_pos := c_signature.index_of (',', pos)
						if comma_pos = 0 then
								-- Last type
							end_pos := end_arg_list - 1
						else
							end_pos := comma_pos - 1
						end
						a_type := c_signature.substring (pos, end_pos)
						a_type.right_adjust
						a_type.left_adjust
						if a_type.is_empty then
							raise_error ("Empty type declaration in signature")
						else
							arg_count := arg_count + 1
							Names_heap.put (a_type)
							argument_types.force (Names_heap.found_item, arg_count)
						end
						pos := end_pos + 2 -- position after comma or after )
					end
				else
					end_arg_list := 1
				end
				pos := c_signature.index_of (':', end_arg_list)
				if pos /= 0 then
					if pos = c_signature.count - 1 then
						raise_error ("Missing return type in signature")
					else
						a_type := c_signature.substring (pos + 1, c_signature.count)
						a_type.right_adjust
						a_type.left_adjust
						if a_type.is_empty then
							raise_error ("Missing return type in signature")
						else
							Names_heap.put (a_type)
							return_type := Names_heap.found_item
						end
					end
				end
			end
		end

	parse_include_files is
			-- Parse the include file clause.
		local
			start_pos, end_pos: INTEGER
			include_count: INTEGER
			unprocessed: STRING
			header_f: STRING
			nb: INTEGER
		do
			if include_files /= Void then
				include_files.left_adjust
				if include_files.is_empty then
					include_files := Void
				end
			end
			if include_files /= Void then
debug
	io.error.putstring ("Processing include files: ")
	io.error.putstring (include_files)
	io.error.new_line
end

				unprocessed := clone (include_files)
					-- Compute maximum number of include files
				nb := unprocessed.occurrences (',') + 1
				!! header_files.make (1, nb)

				from
					start_pos := 1
				until
					unprocessed.is_empty 
				loop
					end_pos := parse_file_name (unprocessed, start_pos)
					if end_pos = 0 then
						raise_error ("Invalid include file")
					else
						include_count := include_count + 1
						header_f := unprocessed.substring (start_pos, end_pos)
						Names_heap.put (header_f)
						header_files.put (Names_heap.found_item, include_count)
						unprocessed.remove_head (end_pos)
						unprocessed.left_adjust
						if not unprocessed.is_empty then
								-- Must have a comma separator
							if unprocessed @ 1 = ',' then
									-- Remove comman and white space
								unprocessed.remove_head (1)
								unprocessed.left_adjust
							else
								raise_error ("Invalid character after include file")
							end
						end
					end
				end
			end
		end

	parse_file_name (s: STRING; start: INTEGER): INTEGER is
			-- Return position of the end of the file name in `s'
			-- or 0 for invalid construct (parsing starts at `start')
		require
			string_non_void: s /= Void and then s.count > 0
		do
debug
	io.error.putstring ("Parsing file name from ")
	io.error.putstring (s.substring (start, s.count))
	io.error.new_line
end
			inspect
				s @ start
			when '<' then
				Result := s.index_of ('>', start)
			when '%"' then
				if s.count >= start + 1 then
					Result := s.index_of ('%"', start + 1)
				end
			else
				Result := 0
			end
debug
	io.error.putint (start)
	io.error.new_line
	io.error.putint (s.count)
	io.error.new_line
	io.error.putint (Result)
	io.error.new_line
end
		end

	raise_error (msg: STRING) is
			-- Raise syntax error (`msg' is the explanation).
		local
			ext_error: EXTERNAL_SYNTAX_ERROR
			line_start: INTEGER
		do
			!! ext_error.init
			line_start := ext_error.start_position
			ext_error.set_start_position (line_start)
				-- We add 5 otherwise there won't be any visible selection
				-- on the screen.
			ext_error.set_end_position (line_start + 5)
			ext_error.set_external_error_message (msg)
			Error_handler.insert_error (ext_error)
			Error_handler.raise_error
		end

feature {NONE} -- Implementation

	c_signature: STRING
			-- Signature

	include_files: STRING
			-- Include files

	special_part: STRING
			-- Special part

end -- class EXTERNAL_EXTENSION_AS
