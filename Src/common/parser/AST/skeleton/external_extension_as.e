indexing

	description: "Encapsulation of an external extension."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_EXTENSION_AS

inherit
	COMPILER_EXPORTER
	SHARED_ERROR_HANDLER

feature -- Properties

	language_name: STRING is
			-- External language name
		deferred
		end

	signature: STRING
			-- Signature

	include_files: STRING
			-- Include files

	special_part: STRING
			-- Special part

	argument_types: ARRAY [STRING]
			-- Types of the arguments (extracted from the signature)

	return_type: STRING
			-- Return type (extracted from the signature)

	header_files: ARRAY [STRING]
			-- Header files to include

feature -- Setting

	set_include_files (s: STRING) is
			-- Assign `s' to `include_files'.
		do
			include_files := s
		end

	set_signature (s: STRING) is
			-- Assign `s' to `signature'.
		do
			signature := s
		end

	set_special_part (s: STRING) is
			-- Assign `s' to `special_part'.
		do
			special_part := s
		end

feature -- Conveniences

	is_macro: BOOLEAN is
			-- Is this a macro extension?
		do
		end

	is_dll: BOOLEAN is
			-- Is this a dll extension?
		do
		end

	has_signature: BOOLEAN is
			-- Does the extension define a signature?
		do
			Result := return_type /= Void or else argument_types /= Void
		end

feature {EXTERNAL_LANG_AS} -- Implementation

	frozen parse is
			-- Parse the external extension.
		do
			parse_special_part
			parse_signature
			parse_include_files
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
			done: BOOLEAN
			pos, comma_pos, end_pos: INTEGER
			arg_count: INTEGER
			a_type: STRING
		do
			if signature /= Void then
				if signature @ 1 = '(' then
					end_arg_list := signature.index_of (')', 1)
					!! argument_types.make (1, 0)
					from
						pos := 2
					until
						pos >= end_arg_list
					loop
						comma_pos := signature.index_of (',', pos)
						if comma_pos = 0 then
								-- Last type
							end_pos := end_arg_list - 1
						else
							end_pos := comma_pos - 1
						end
						a_type := signature.substring (pos, end_pos)
						a_type.right_adjust
						a_type.left_adjust
						if a_type.empty then
							raise_error ("Empty type declaration in signature")
						else
							arg_count := arg_count + 1
							argument_types.force (a_type, arg_count)
						end
						pos := end_pos + 2 -- position after comma or after )
					end
				else
					end_arg_list := 1
				end
				pos := signature.index_of (':', end_arg_list)
				if pos /= 0 then
					if pos = signature.count - 1 then
						raise_error ("Missing return type in signature")
					else
						a_type := signature.substring (pos + 1, signature.count)
						a_type.right_adjust
						a_type.left_adjust
						if a_type.empty then
							raise_error ("Missing return type in signature")
						else
							return_type := a_type
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
		do
			if include_files /= Void then
				include_files.left_adjust
				if include_files.empty then
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
				!! header_files.make (1, 0)

				from
					start_pos := 1
				until
					unprocessed.empty 
				loop
					end_pos := parse_file_name (unprocessed, start_pos)
					if end_pos = 0 then
						raise_error ("Invalid include file")
					else
						include_count := include_count + 1
						header_f := unprocessed.substring (start_pos, end_pos)
						header_files.force (header_f, include_count)
						unprocessed.tail (unprocessed.count - end_pos)
						unprocessed.left_adjust
						if not unprocessed.empty then
								-- Must have a comma separator
							if unprocessed @ 1 = ',' then
									-- Remove comman and white space
								unprocessed.tail (unprocessed.count - 1)
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
			ext_error.set_end_position (line_start)
			ext_error.set_external_error_message (msg)
			Error_handler.insert_error (ext_error)
			Error_handler.raise_error
		end

end -- class EXTERNAL_EXTENSION_AS
