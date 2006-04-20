indexing
	description: "Encapsulation of a macro external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MACRO_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part
		end

create
	make,
	initialize

feature  -- Initialization

	make (is_cpp_macro: like is_cpp) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_macro'.
		do
			is_cpp := is_cpp_macro
		ensure
			is_cpp_set: is_cpp = is_cpp_macro
		end

	initialize (is_cpp_macro: like is_cpp; sig: SIGNATURE_AS; use_list: USE_LIST_AS) is
			-- Create MACRO_EXTENSION_AS node.
		require
			use_list_not_void: use_list /= Void
			use_list_not_empty: not use_list.is_empty
		do
			is_cpp := is_cpp_macro
			if sig /= Void then
				argument_types := sig.arguments_id_array
				if sig.return_type /= Void then
					return_type := sig.return_type.value_id
				end
			end
			header_files := use_list.array_representation
		ensure
			is_cpp_set: is_cpp = is_cpp_macro
			header_files_not_void: header_files /= Void
			good_header_files_count: header_files.count >= 1
		end

feature -- Properties

	is_cpp: BOOLEAN
			-- Is Current macro a C++ one?

feature -- Get the macro extension

	extension_i: MACRO_EXTENSION_I is
			-- MACRO_EXTENSION_I corresponding to current extension
		do
			create Result.make (is_cpp)
			init_extension_i (Result)
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

end -- class MACRO_EXTENSION_AS
