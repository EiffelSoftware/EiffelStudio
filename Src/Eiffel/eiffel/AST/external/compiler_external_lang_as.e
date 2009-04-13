note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class COMPILER_EXTERNAL_LANG_AS

inherit
	EXTERNAL_LANG_AS
		redefine
			initialize, is_built_in
		end

	EXTERNAL_CONSTANTS

	COMPILER_EXPORTER

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	CONF_CONSTANTS
		export
			{NONE} all
		end

create
	initialize

feature {AST_FACTORY} -- Initialization

	initialize (l: like language_name)
			-- Create a new EXTERNAL_LANGUAGE AST node.
		do
			Precursor {EXTERNAL_LANG_AS} (l)
			parse
		end

feature -- Access

	extension: EXTERNAL_EXTENSION_AS
			-- Parsed external extension.
			--| It is enough to just compare `language_name' in `is_equivalent' since it stores
			--| full external specification. And if it is the same specification
			--| then it is the same external.

feature -- Status report

	is_built_in: BOOLEAN
			-- Is current a `built_in' one?
		local
			l_built_in: BUILT_IN_EXTENSION_AS
		do
			l_built_in ?= extension
			Result := l_built_in /= Void
		end

feature -- Properties

	extension_i: EXTERNAL_EXT_I
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			Result := extension.extension_i
		ensure
			extension_i_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	parse
			-- Parse external declaration
		local
			parser: like external_parser
			is_yacc_parsing_successful: BOOLEAN
			l_real_line_number, l_real_column_number: INTEGER
		do
			parser := External_parser
			parser.set_trigger_error (False)
			if attached {VERBATIM_STRING_AS} language_name as verbatim_string then
					-- The actual content of a verbatim string always starts at the line after the opening bracket.
				l_real_line_number := verbatim_string.line + 1
				l_real_column_number := verbatim_string.common_columns + 1
			else
				l_real_line_number := language_name.line
				l_real_column_number := language_name.column + 1
			end
			parser.parse_external (Eiffel_parser.current_class, l_real_line_number, l_real_column_number, Eiffel_parser.filename, language_name.value)
			extension := parser.root_node
			is_yacc_parsing_successful := extension /= Void
			if not is_yacc_parsing_successful then
				extension := Void
				old_parse
				if has_parsing_error then
						-- Use the new syntax to report the error
					parser.set_trigger_error (True)
					parser.parse_external (Eiffel_parser.current_class, l_real_line_number, l_real_column_number, Eiffel_parser.filename, language_name.value)
				end
			end
		ensure
			extension_set: error_handler.error_level = old error_handler.error_level implies extension /= Void
		end

	has_parsing_error: BOOLEAN
			-- Is last call to `old_parse' successful?

	old_parse
			-- Parse external declaration
		require
			extension_not_yet_set: extension = Void
		local
			source, image: STRING
			ext_language_name: STRING
			special_part: STRING
			special_type: STRING
			signature_part: STRING
			dll_ext: DLL_EXTENSION_AS
			start_special_part, end_special_part: INTEGER
			valid_language_name: BOOLEAN
			done, is_cpp_extension: BOOLEAN
			pos: INTEGER
			index_pos: INTEGER
			dll_index: INTEGER
			nb: INTEGER
		do
			has_parsing_error := False
			source := language_name.value
			debug
				io.error.put_string ("Parsing ")
				io.error.put_string (source)
				io.error.put_new_line
			end
				-- getting rid of extra blanks
			image := source.twin
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
						io.error.put_string ("Void%N")
					end
					has_parsing_error := True
				else
					debug
						io.error.put_string (ext_language_name)
						io.error.put_new_line
					end
					pos := source.substring_index (ext_language_name,1)
					has_parsing_error := True
				end
			else
					-- cleaning string for next operation
				image.remove_head (pos)
				image.left_adjust

					-- Extracting the special part
				if image.count /= 0 and then image.item (1) = '[' then
					start_special_part := source.index_of ('[', 1)
					end_special_part := source.index_of (']', 1)
					if end_special_part = 0 then
						has_parsing_error := True
					elseif end_special_part = start_special_part + 1 then
						has_parsing_error := True
					else
						special_part := source.substring (start_special_part + 1, end_special_part - 1)
						special_part.right_adjust
						special_part.left_adjust

							-- Only unprocessed part is kept in `image'
						image.remove_head (image.index_of (']', 1))
						image.left_adjust

							-- Checking the type of special part
						pos := special_part.index_of (' ', 1)
						if pos = 0 then
								-- Case where the is no spaces, possibly just tabs.
							pos := special_part.index_of ('%T', 1)
						else
								-- Case where we might have both spaces and tabs, find out
								-- which one comes first.
							index_pos := special_part.index_of ('%T', 1)
							if index_pos /= 0 then
								pos := index_pos.min (pos)
							end
						end
						if pos = 0 then
								-- Only one word in brackets
								has_parsing_error := True
						else
								-- Is it a C++ external?
							is_cpp_extension := ext_language_name.is_equal ("C++")

								-- C
							special_type := special_part.substring (1, pos - 1)
							special_type.to_lower

							dll_index := -1
							from
								done := False
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
								create {MACRO_EXTENSION_AS} extension.make (is_cpp_extension)
									-- Even if used in a C++ context it is not a
									-- CPP extension.
								is_cpp_extension := False
							elseif special_type.is_equal (struct_string) then
								create {STRUCT_EXTENSION_AS} extension.make (is_cpp_extension)
									-- Even if used in a C++ context it is not a
									-- CPP extension.
								is_cpp_extension := False
							elseif special_type.is_equal (dll32_string) then
								create dll_ext
								dll_ext.set_type (dll32_type)
								dll_ext.set_index (dll_index)
								extension := dll_ext
							elseif special_type.is_equal (dllwin32_string) then
								create dll_ext
								dll_ext.set_type (dllwin32_type)
								dll_ext.set_index (dll_index)
								extension := dll_ext
							elseif is_cpp_extension then
								create {CPP_EXTENSION_AS} extension
							else
								create {C_EXTENSION_AS} extension
							end

							if not is_cpp_extension then
									-- Remove special type from special_part
								special_part := special_part.substring (pos + 1, special_part.count)
								special_part.left_adjust
							end
							extension.set_special_part (special_part)
						end
					end
				end

				if not has_parsing_error then
						-- Extracting the signature
					if image.count /= 0 and then image.item (1) = '(' then
						pos := image.index_of (')',2)
						if pos = 0 then
							has_parsing_error := True
						else
							signature_part := image.substring (1, pos)

								-- Only unprocessed part is kept in `image'
							image.remove_head (pos)
							image.left_adjust
						end
					end

					if not has_parsing_error then
							-- Return type
						if image.count /= 0 and then image.item (1) = ':' then
							if signature_part = Void then
								create signature_part.make (0)
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
								image.remove_head (pos - 1)
							end
						end

						if signature_part /= Void or else image.count /= 0 then
							if extension = Void then
								if ext_language_name.is_equal ("C++") then
									has_parsing_error := True
								else
									create {C_EXTENSION_AS} extension
								end
							end
						end

						if not has_parsing_error then
							if signature_part /= Void then
								extension.set_signature (signature_part)
							end

							debug
								if extension /= Void then
									io.error.put_string ("Extension: ")
									io.error.put_string (extension.generator)
									io.error.put_new_line
								end
							end

							if image.count /= 0 then
									-- Extracting the include part
								if image.item (1) = '|' then
									extension.set_include_files (image.substring (2, image.count))
								else
									debug
										io.error.put_string (image)
									end
									has_parsing_error := True
								end
							end

							if not has_parsing_error then
								if extension = Void and ext_language_name.is_equal ("C++") then
									has_parsing_error := True
								else
									if extension /= Void then
										extension.parse
										if extension.has_parsing_error then
											has_parsing_error := True
										else
											insert_external_warning
										end
									else
										insert_external_warning
									end
								end
							end
						end
					end
				end
			end
			if has_parsing_error then
				extension := Void
			end
		end

	insert_external_warning
			-- Raises warning when parsing an old external syntax but only if configuration says so.
		local
			l_warning: SYNTAX_WARNING
		do
				-- FIXME: Manu 04/11/2009. We do not yet raise a warning for 6.4 	
				-- because we do not have yet an automatic converter for our customers.
			if
				False and then
				(attached {CLASS_C} eiffel_parser.current_class as l_class_c and then
				l_class_c.lace_class.options.is_warning_enabled (w_syntax))
			then
				create l_warning.make (
					language_name.line,
					language_name.column,
					eiffel_parser.filename, "Use new external syntax instead.")
				l_warning.set_associated_class (l_class_c)
				Error_handler.insert_warning (l_warning)
			end
		end

invariant
	language_name_not_void: language_name /= Void
	extension_not_void: extension /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
