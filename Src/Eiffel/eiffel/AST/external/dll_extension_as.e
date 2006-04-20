indexing
	description: "Encapsulation of a DLL external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class DLL_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part, type_check
		end

create
	default_create,
	initialize

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (a_dll_type: like type; a_dll_name: ID_AS;
			a_dll_index: like index; sig: SIGNATURE_AS; use_list: USE_LIST_AS)
		is
			-- Create a new C_EXTENSION_AS node
		require
			a_dll_type_valid: a_dll_type = {EXTERNAL_CONSTANTS}.dll32_type or
				a_dll_type = {EXTERNAL_CONSTANTS}.dllwin32_type
			a_dll_name_not_void: a_dll_name /= Void
		do
			type := a_dll_type
			index := a_dll_index
			name := a_dll_name.string
			if sig /= Void then
				argument_types := sig.arguments_id_array
				if sig.return_type /= Void then
					return_type := sig.return_type.value_id
				end
			end
			if use_list /= Void then
				header_files := use_list.array_representation
			end
		ensure
			type_set: type = a_dll_type
			index_set: index = a_dll_index
		end

feature -- Access

	name: STRING
			-- File name associated with extension

	type: INTEGER
		-- Dll type

	index: INTEGER
		-- Dll index

feature -- Initialization

	extension_i: DLL_EXTENSION_I is
			-- DLL_EXTENSION_I corresponding to current extension
		do
			create Result.make (type, index, name)
			init_extension_i (Result)
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS) is
			-- Perform type check on Current associated with `ext_as_b'.
		local
			error: BOOLEAN
			ext_dll_sign: EXT_DLL_SIGN
		do
			type_check_signature

				-- For DLL - Windows, a signature is compulsory
			if context.current_feature.argument_count > 0 and argument_types = Void then
				error := True
			end
			if context.current_feature.is_function = (return_type = 0) then
				error := True
			end
			if error then
				create ext_dll_sign
				context.init_error (ext_dll_sign)
				Error_handler.insert_error (ext_dll_sign)
				Error_handler.raise_error
			end
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the dll name
		do
			parse_dll_name
		end

	parse_dll_name is
			-- Parse the end of the special part: it should only have a
			-- file name
		local
			end_file: INTEGER
			count : INTEGER
			remaining: STRING
		do
			end_file := parse_file_name (special_part, 1)
debug
	io.error.put_string (special_part)
	io.error.put_new_line
	io.error.put_integer (special_part.count)
	io.error.put_new_line
	io.error.put_integer (end_file)
	io.error.put_new_line
end

			if end_file = 0 then
					-- Invalid file
				raise_error ("Invalid file name")
			else
				name := special_part.substring (1, end_file)
				count := special_part.count
				if end_file /= count then
					remaining := special_part.substring (end_file + 1, count)
					remaining.left_adjust
					if remaining.count > 0 then
						raise_error ("Extra characters after file name")
					end
				end
			end
		end
 
feature -- {EXTERNAL_LANG_AS} Implementation

	set_type (t: INTEGER) is
			-- Assign `t' to `type'.
		do
			type := t
		ensure
			type_set: type = t
		end

	set_index (i: INTEGER) is
			-- Assign `i' to `index'.
		do
			index := i
		ensure
			index_set: index = i
		end

indexing
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

end -- class DLL_EXTENSION_AS
