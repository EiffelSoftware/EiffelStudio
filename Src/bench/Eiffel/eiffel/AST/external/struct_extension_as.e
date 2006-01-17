indexing
	description: "Encapsulation of a struct external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class STRUCT_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part, type_check
		end

create
	make,
	initialize

feature  -- Initialization

	make (is_cpp_struct: like is_cpp) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_struct'.
		do
			is_cpp := is_cpp_struct
		ensure
			is_cpp_set: is_cpp = is_cpp_struct
		end

	initialize (is_cpp_struct: like is_cpp; a_name: EXTERNAL_TYPE_AS; a_field_name: ID_AS; type: EXTERNAL_TYPE_AS; use_list: USE_LIST_AS) is
			-- Create STRUCT_EXTENSION_AS node.
		require
			use_list_not_void: use_list /= Void
			use_list_not_empty: not use_list.is_empty
			a_name_not_void: a_name /= Void
			a_field_name_not_void: a_field_name /= Void
			a_field_name_not_empty: a_field_name.count > 0
		local
			id: INTEGER
		do
			is_cpp := is_cpp_struct
			id := a_name.value_id
			if type /= Void then
					-- It is a `setter'
				create argument_types.make (1, 2)
				argument_types.put (id, 1)
				argument_types.put (type.value_id, 2)
			else
				create argument_types.make (1, 1)
				argument_types.put (id, 1)
			end
			Names_heap.put (a_field_name)
			field_name_id := Names_heap.found_item
			header_files := use_list.array_representation
		ensure
			is_cpp_set: is_cpp = is_cpp_struct
			field_name_id_set: field_name_id > 0
			arguments_set: argument_types /= Void
			good_arguments_count: argument_types.count = 1 or argument_types.count = 2
			valid_setting_1: type = Void implies argument_types.count = 1
			valid_setting_2: type /= Void implies (argument_types.count = 2
							and then argument_types.item (2) = type.value_id)
			header_files_not_void: header_files /= Void
			good_header_files_count: header_files.count >= 1
		end

feature -- Properties

	is_cpp: BOOLEAN
			-- Is Current struct a C++ one?

	field_name_id: INTEGER
			-- Name of struct.
			--| Can be empty if parsed through the old syntax

feature -- Get the struct extension

	extension_i: STRUCT_EXTENSION_I is
			-- STRUCT_EXTENSION_I corresponding to current extension
		do
			create Result.make (field_name_id, is_cpp)
			init_extension_i (Result)
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS) is
			-- Perform type check on Current associated with `ext_as_b'.
		local
			feat: EXTERNAL_I
			struct_error: EXT_STRUCT
			has_new_syntax: BOOLEAN
			has_error: BOOLEAN
			arg_type: TYPE_A
		do
			if field_name_id = 0 then
				field_name_id := ext_as_b.alias_name_id
			else
				has_new_syntax := True
			end
				
			if field_name_id = 0 then
				has_error := True
				create struct_error
				struct_error.set_error_message ("The struct field name part should always be present.")
			else
				feat ?= context.current_feature
				if feat.is_function then
						-- A struct external function definition has always one
						-- argument of type POINTER
					if feat.argument_count /= 1 then
						has_error := True
					else
						arg_type ?= feat.arguments.i_th (1)
						has_error := not arg_type.is_pointer
					end
					if has_error then
						create struct_error
						struct_error.set_error_message ("The only argument should be of type POINTER")
					end
				else
						-- It is a procedure and it's valid only if there are two arguments
						-- the first one being of type POINTER.
					if feat.argument_count /= 2 then
						has_error := True
					else
						arg_type ?= feat.arguments.i_th (1)
						has_error := not arg_type.is_pointer
					end
					if has_error then
						create struct_error
						struct_error.set_error_message ("There should be 2 arguments where first argument is of type POINTER")
					end
				end
			end
			if not has_error then
				if argument_types = Void then
					create struct_error
					struct_error.set_error_message ("The struct name or the field type part should be precised.")
					has_error := True
				end
			end
			if has_error then
				context.init_error (struct_error)
				Error_handler.insert_error (struct_error)
				Error_handler.raise_error
			else
				if not has_new_syntax then
						-- With the new syntax there is no signature to check
					type_check_signature
				end
			end
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse include file containing struct definition
		local
			end_file: INTEGER
			count : INTEGER
			remaining: STRING
			special_file_name: STRING
		do
			end_file := parse_file_name (special_part, 1)

			if end_file = 0 then
					-- Invalid file
				raise_error ("Invalid file name")
			else
				special_file_name := special_part.substring (1, end_file)
				count := special_part.count
				if end_file /= count then
					remaining := special_part.substring (end_file + 1, count)
					remaining.left_adjust
					if remaining.count > 0 then
						raise_error ("Extra characters after file name")
					end
				end
					-- Add special file name to the list of header files at the
					-- first position.
				if header_files = Void then
					create header_files.make (1,1)
				else
					header_files.force (header_files.item (header_files.lower), header_files.upper + 1)
				end
				Names_heap.put (special_file_name)
				header_files.put (Names_heap.found_item, header_files.lower)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class STRUCT_EXTENSION_AS
