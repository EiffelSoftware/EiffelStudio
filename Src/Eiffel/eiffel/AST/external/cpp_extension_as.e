note
	description: "Encapsulation of a C++ external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CPP_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			type_check, type_check_signature, parse_special_part
		end

	SHARED_CPP_CONSTANTS

create
	default_create,
	initialize

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (a_type: INTEGER; base_class: ID_AS; a_sig: SIGNATURE_AS; use_list: USE_LIST_AS)
			-- Create a new CPP_EXTENSION_AS node.
		require
			valid_type: valid_type (a_type)
			class_not_void: base_class /= Void
			use_list_not_void: use_list /= Void
		do
			class_name := base_class.name
			type := a_type

			if a_sig /= Void then
				argument_types := a_sig.arguments_id_array
				if a_sig.return_type /= Void then
					return_type := a_sig.return_type.value_id
				end
			end
			if use_list /= Void then
				header_files := use_list.array_representation
			end
		ensure
			class_name_set: class_name.is_equal (base_class.name)
			type_set: type = a_type
		end

feature -- Properties

	type: INTEGER
			-- Kind of C++ call (possible values defined in SHARED_CPP_CONSTANTS).

	class_name: STRING
			-- Name of C++ external class

feature -- Get the C++ extension

	extension_i: CPP_EXTENSION_I
			-- CPP_EXTENSION_I corresponding to current extension
		do
			create Result
			init_extension_i (Result)
			Result.set_type (type)
			Result.set_class_name (class_name)
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS)
			-- Perform type check on Current associated with `ext_as_b'.
		local
			a_feat: EXTERNAL_I
			arg_type: TYPE_A
			error: BOOLEAN
			cpp_error: EXT_CPP
			l_error_level: NATURAL_32
		do
			l_error_level := error_handler.error_level
			a_feat ?= context.current_feature

				-- Check first argument if necessary
			inspect
				type
			when standard, delete, data_member then
					-- First argument has to be a pointer
				if a_feat.argument_count = 0 then
					error := True
				else
					arg_type ?= a_feat.arguments.i_th (1)
					error := not arg_type.actual_type.is_pointer
				end
				if error then
					create cpp_error
					cpp_error.set_error_message ("First argument must be of type POINTER")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
				end
			when new, static, static_data_member then
				-- No restriction on first parameter
			end

			if error_handler.error_level = l_error_level then
				inspect
					type
				when data_member, static_data_member then
						-- Must be a function
					if not a_feat.is_function then
						create cpp_error
						cpp_error.set_error_message ("This external must be a function")
						context.init_error (cpp_error)
						Error_handler.insert_error (cpp_error)
					end
					if type = data_member then
						error := a_feat.argument_count /= 1
						create cpp_error
						cpp_error.set_error_message ("First argument must be of type POINTER")
					else
						error := a_feat.argument_count /= 0
						create cpp_error
						cpp_error.set_error_message ("No argument allowed")
					end
					if error then
						context.init_error (cpp_error)
						Error_handler.insert_error (cpp_error)
					end
				when new then
						-- Must return a pointer
					arg_type ?= a_feat.type
					if not arg_type.actual_type.is_pointer then
						create cpp_error
						cpp_error.set_error_message ("The return type must be POINTER")
						context.init_error (cpp_error)
						Error_handler.insert_error (cpp_error)
					end
					if a_feat.alias_name_id > 0 then
						create cpp_error
						cpp_error.set_error_message ("The alias clause is not allowed")
						context.init_error (cpp_error)
						Error_handler.insert_error (cpp_error)
					end
				when delete then
						-- Must be a procedure
					if a_feat.is_function then
						create cpp_error
						cpp_error.set_error_message ("This external must be a procedure")
						context.init_error (cpp_error)
						Error_handler.insert_error (cpp_error)
					end
					if a_feat.argument_count /= 1 then
						create cpp_error
						cpp_error.set_error_message ("The only argument must be of type POINTER")
						context.init_error (cpp_error)
						Error_handler.insert_error (cpp_error)
					end
					if a_feat.alias_name_id > 0 then
						create cpp_error
						cpp_error.set_error_message ("The alias clause is not allowed")
						context.init_error (cpp_error)
						Error_handler.insert_error (cpp_error)
					end
				when standard, static then
						-- No restriction
				end
				if error_handler.error_level = l_error_level then
					type_check_signature
				end
			end
		end

	type_check_signature
			-- Perform type check on the signature.
		local
			cpp_error: EXT_CPP
			error: BOOLEAN
			arg_count, feature_count: INTEGER
			a_feat: FEATURE_I
			error_msg: STRING
		do
			if has_signature then
				a_feat := context.current_feature
				feature_count := a_feat.argument_count
				if argument_types /= Void then
						-- Check for arguments
					arg_count := argument_types.count

					inspect
						type
					when standard, delete, data_member then
						error := arg_count /= feature_count - 1
						error_msg := "number of arguments in the signature must be number of arguments in the Eiffel definition - 1"
					when new, static, static_data_member then
						error := arg_count /= feature_count
						error_msg := "number of arguments in the signature must match number of arguments in the Eiffel definition"
					end
				else
						-- No argument specified
					inspect
						type
					when standard, delete, data_member then
						error := feature_count /= 1
						error_msg := "number of arguments in the signature must be number of arguments in the Eiffel definition - 1"

					when new, static, static_data_member then
						error := feature_count /= 0
						error_msg := "number of arguments in the signature must match number of arguments in the Eiffel definition"
					end
				end

				if not error then
						-- Check for return type
					if return_type = 0 then
						inspect
							type
						when new then
						else
							error := a_feat.is_function
							error_msg := "Missing return type in signature"
						end
					else
						error := not a_feat.is_function or else type = new
						error_msg := "Invalid return type in signature"
					end
				end

				if error then
					create cpp_error
					cpp_error.set_error_message (error_msg)
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
				end
			end
		end

feature {NONE} -- Implementation

	parse_special_part
			-- Parse the special part clause.
		local
			word, lower_word, special: STRING
			parse_class_name, is_static, l_has_error: BOOLEAN
			end_keyword: INTEGER
			class_header_file: STRING
		do
debug
	io.error.put_string ("Parsing special part: ")
	io.error.put_string (special_part)
	io.error.put_new_line
end
			special := special_part

			end_keyword := next_white_space (special, 1)
			if end_keyword = 0 then
				insert_error ("Only one word in C++ specific part")
			else
				word := special.substring (1, end_keyword - 1)
				lower_word := word.as_lower

				special := special.substring (end_keyword, special.count)
				special.left_adjust

				if lower_word.is_equal (static_keyword) then
					is_static := True
					end_keyword := next_white_space (special, 1)
					if end_keyword = 0 then
						l_has_error := True
						insert_error ("Header file is missing in C++ specific part")
					else
						word := special.substring (1, end_keyword - 1)
						lower_word := word.as_lower

						special := special.substring (end_keyword, special.count)
						special.left_adjust
					end
				end

				if not l_has_error then
					parse_class_name := True
					if lower_word.is_equal (new_keyword) then
						type := new
						if is_static then
							l_has_error := True
							insert_error ("`static' cannot be used with `new'")
						end
					elseif lower_word.is_equal (delete_keyword) then
						type := delete
						if is_static then
							l_has_error := True
							insert_error ("`static' cannot be used with `delete'")
						end
					elseif lower_word.is_equal (static_keyword) then
						l_has_error := True
						insert_error ("`static' cannot appear twice in C++ specific part")
					elseif lower_word.is_equal (data_member_keyword) then
						if is_static then
							type := static_data_member
						else
							type := data_member
						end
					else
						parse_class_name := False
						if is_static then
							type := static
						else
							type := standard
						end
					end

					if not l_has_error then
						if parse_class_name then
							end_keyword := next_white_space (special, 1)
							if end_keyword = 0 then
								l_has_error := True
								insert_error ("Header file is missing in C++ specific part")
							else
								word := special.substring (1, end_keyword - 1)
								special := special.substring (end_keyword, special.count)
								special.left_adjust
							end
						end

						if not l_has_error then
							class_name := word

							end_keyword := parse_file_name (special, 1)
							if end_keyword = 0 then
								insert_error ("Invalid include file")
							else
								class_header_file := special.substring (1, end_keyword)
								special.remove_head (end_keyword)
								special.left_adjust
								if not special.is_empty then
									insert_error ("Invalid character after include file")
								else
										-- Add special file name to the list of header files at the
										-- first position.
									if header_files = Void then
										create header_files.make (1,1)
									else
										header_files.force (header_files.item (header_files.lower),
											header_files.upper + 1)
									end
									Names_heap.put (class_header_file)
									header_files.put (Names_heap.found_item, header_files.lower)
								end
							end
						end
					end
				end
			end
		end

	next_white_space (s: STRING; start: INTEGER): INTEGER
			-- Return the position of the next white space
			-- in `s' starting at `start'.
		local
			tab_pos: INTEGER
		do
			Result := s.index_of (' ', start)
			tab_pos := s.index_of ('%T', start)
			if tab_pos /= 0 then
				if Result = 0 then
					Result := tab_pos
				else
					Result := tab_pos.min (Result)
				end
			end
		end

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

end -- class CPP_EXTENSION_AS
