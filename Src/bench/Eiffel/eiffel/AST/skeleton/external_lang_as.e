class EXTERNAL_LANG_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

	EXTERNAL_CONSTANTS

	COMPILER_EXPORTER

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0)
			start_position := yacc_position
			parse
		ensure then
			language_name /= Void
		end
feature -- Attributes

	language_name: STRING_AS
			-- Language name
			-- might be replaced by external_declaration or external_definition

	extension: EXTERNAL_EXTENSION_AS
			-- Parsed external extension

	start_position: INTEGER
			-- Start position of AST

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: is_equivalent should be done on EXTERNAL_EXTENSION_AS
			Result := language_name.is_equivalent (other.language_name)
		end

feature -- Properties

	need_encapsulation: BOOLEAN is
			-- Is an encapsulation needed?
		do
			Result := extension /= Void and then extension.need_encapsulation
		end

feature

	extension_i (external_as: EXTERNAL_AS): EXTERNAL_EXT_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			if extension /= Void then
				Result := extension.extension_i (external_as)
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.format_ast (language_name)
		end

feature {NONE} -- Implementation

	parse is
			-- Parse external declaration
		local
			source: STRING
			image: STRING
			ext_language_name: STRING
			special_part: STRING
			special_type: STRING
			signature_part: STRING

			dll_ext: C_DLL_EXTENSION_AS
			start_special_part, end_special_part: INTEGER
			valid_language_name: BOOLEAN
			done: BOOLEAN
			pos: INTEGER
			index_pos: INTEGER
			dll_index: INTEGER
			nb: INTEGER
		do
			source := language_name.value
debug
	io.error.putstring ("Parsing ")
	io.error.putstring (source)
	io.error.new_line
end
				-- getting rid of extra blanks
			image := clone (source)
			image.left_adjust
			image.right_adjust

				-- extracting language name
			from
				nb := image.count
				pos := 1
			until
				pos > nb or else done
			loop
				inspect
					image.item (pos)
				when '%T', ' ','[','(',':','|' then
					done := True
				else
					pos := pos + 1
				end
			end

			pos := pos - 1
				-- The external name goes from 1 to `pos'

			if pos > 0 then
				ext_language_name := image.substring (1, pos)
				ext_language_name.to_upper

					-- Validity check on language name 
				if ext_language_name.is_equal ("C") then
					valid_language_name := True
				elseif ext_language_name.is_equal ("C++") then
					valid_language_name := True
				end
			end

			if not valid_language_name then
				if ext_language_name = Void then
debug
	io.error.putstring ("Void%N")
end
					raise_external_error ("Unrecognized external language", 1, 1)
				else
debug
	io.error.putstring (ext_language_name)
	io.error.new_line
end
					pos := source.substring_index (ext_language_name,1)
					raise_external_error ("Unrecognized external language",
						pos, pos + ext_language_name.count - 1)
				end
			else
					-- cleaning string for next operation
				image.tail (image.count - pos)
				image.left_adjust

					-- Extracting the special part
				if image.count /= 0 and then image.item (1) = '[' then
					start_special_part := source.index_of ('[', 1)
					end_special_part := source.index_of (']', 1)
					if end_special_part = 0 then
						raise_external_error ("Missing closing bracket ']'", start_special_part, source.count)
					elseif end_special_part = start_special_part + 1 then
						raise_external_error ("Empty brackets" , start_special_part, end_special_part)
					else
						special_part := source.substring (start_special_part + 1, end_special_part - 1)
						special_part.right_adjust
						special_part.left_adjust

							-- Only unprocessed part is kept in `image'
						image.tail (image.count - image.index_of (']', 1))
						image.left_adjust

							-- Checking the type of special part
						pos := special_part.index_of (' ', 1)
						if pos = 0 then
							pos := special_part.index_of ('%T', 1)
						end
						if pos = 0 then
								-- Only one word in brackets
							raise_external_error ("Only one word between brackets",
								source.index_of ('[', 1) + 1,
								source.index_of (']', 1) - 1)
						else
							if ext_language_name.is_equal ("C++") then
									-- C++
								!CPP_EXTENSION_AS!extension
							else
									-- C
								special_type := special_part.substring (1, pos - 1)
								special_type.to_lower

								dll_index := -1
								from
									done :=false
									nb := special_type.count
									index_pos := 1
								until
									index_pos > nb or else done
								loop
									inspect
										special_type.item (index_pos)
									when '@' then
										done := True
										dll_index := special_type.substring(index_pos + 1,special_type.count).to_integer
									else
										index_pos := index_pos + 1
									end
								end
								special_type := special_type.substring (1, index_pos-1)
								if special_type.is_equal (macro_string) then
									!C_MACRO_EXTENSION_AS!extension
								elseif special_type.is_equal (dll16_string) then
									!! dll_ext
									dll_ext.set_dll_type (dll16_type)
									extension := dll_ext
								elseif special_type.is_equal (dll32_string) then
									!! dll_ext
									dll_ext.set_dll_type (dll32_type)
									dll_ext.set_dll_index (dll_index) 
									extension := dll_ext
								elseif special_type.is_equal (dllwin32_string) then
									!! dll_ext
									dll_ext.set_dll_type (dllwin32_type)
									dll_ext.set_dll_index (dll_index) 
									extension := dll_ext
								else
									!C_EXTENSION_AS!extension
								end
								special_part := special_part.substring (pos + 1, special_part.count)
							end

								-- Remove special type from special_part
							special_part.left_adjust
							extension.set_special_part (special_part)
						end
					end
				end

					-- Extracting the signature
				if image.count /= 0 and then image.item (1) = '(' then
					pos := image.index_of (')',2)
					if pos = 0 then
						raise_external_error ("Missing closing parenthesis ) in signature clause",
							source.index_of ('(', 1), source.count)
					else
						signature_part := image.substring (1, pos)

							-- Only unprocessed part is kept in `image'
						image.tail (image.count - pos)
						image.left_adjust
					end
				end

					-- Return type
				if image.count /= 0 and then image.item (1) = ':' then
					if signature_part = Void then
						!! signature_part.make (0)
					end

					pos := image.index_of ('|', 1)
					if pos = 0 then
							-- No include part
						signature_part.append (image)
						image.wipe_out
					else
						signature_part.append (image.substring (1, pos - 1))
						signature_part.right_adjust
	
							-- Only unprocessed part is kept in `image'
						image.tail (image.count - pos + 1)
					end
				end

				if signature_part /= Void or else image.count /= 0 then
					if extension = Void then
						if ext_language_name.is_equal ("C++") then
							raise_external_error ("Missing special part", 1, 1)
						else
							!C_EXTENSION_AS!extension
						end
					end
				end

				if signature_part /= Void then
					extension.set_signature (signature_part)
				end

debug
	if extension /= Void then
		io.error.putstring ("Extension: ")
		io.error.putstring (extension.generator)
		io.error.new_line
	end
end

				if image.count /= 0 then
						-- Extracting the include part
					if image.item (1) = '|' then
						extension.set_include_files (image.substring (2, image.count))
					else
debug
	io.error.putstring (image)
end
						raise_external_error ("Extra text at end of external language specification",
							source.substring_index (image,1), source.count)
					end
				end

				if extension /= Void then
					extension.parse
				end
			end
		end

	raise_external_error (msg: STRING; start_p: INTEGER; end_p: INTEGER) is
			-- Raises error occured while parsing
		local
			ext_error: EXTERNAL_SYNTAX_ERROR
			line_start: INTEGER
		do
			!!ext_error.init
			line_start := ext_error.start_position
			ext_error.set_start_position (line_start + start_p)
			ext_error.set_end_position (line_start + end_p)
			ext_error.set_external_error_message (msg)
			Error_handler.insert_error (ext_error)
			Error_handler.raise_error
		end

end -- class EXTERNAL_LANG_AS
