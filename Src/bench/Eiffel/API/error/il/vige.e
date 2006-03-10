indexing
	description	: "IL Generation error, occurs during IL code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	VIGE

inherit
	ERROR
		redefine
			error_string,
			print_error_message
		end

create
	make,
	make_com_error,
	make_output_in_use,
	make_pdb_in_use

feature {NONE} -- Initialization

	make (description: like error_string) is
			-- Set `Error_string' with `description'.
		require
			non_void_description: description /= Void
		do
			internal_error_string := description
		ensure
			Error_string_set: Error_string = description
		end

	make_com_error is
			-- Error when .NET COM component is not properly installed.
		do
			internal_error_string := "%
				%Unable to load .NET components. Make sure .NET and Eiffel for .NET%N%
				%are properly installed%N%N%
				%See http://docs.eiffel.com/technologies/dotnet for more details.%N"
		end
		
	make_output_in_use (t: STRING) is
			-- Error when trying to delete file `t'.
		require
			t_not_void: t /= Void
			t_not_empty: not t.is_empty
		do
			internal_error_string := "File: " + t + " is in use.%NSystem compilation aborted.%N"
		end

	make_pdb_in_use (module_name: STRING) is
			-- Error when trying to create PDB file associated to module `module_name'.
		require
			module_name_not_void: module_name /= Void
			module_name_not_empty: not module_name.is_empty
		do
			internal_error_string := "Cannot create PDB file associated to module:%N" +
				module_name + ".%NSystem compilation aborted.%N"
		end
		
feature -- Properties

	code: STRING is
			-- Error code
		once
			Result := "VIGE"
		end
	
	Error_string: STRING is
			-- Error description
		do
			Result := internal_error_string
		end
		
	file_name: STRING is
			-- No associated file
		do
		end
		
feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
		end

	print_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Print error message on output.
		local
			i, j: INTEGER
		do
			a_text_formatter.add ("IL Generation Error:")
			a_text_formatter.add_new_line

			i := error_string.index_of ('%N', 1)
			if i = 0 then
				a_text_formatter.add (error_string)
				a_text_formatter.add_new_line
			else
				from
				until
					i = 0
				loop
					a_text_formatter.add (error_string.substring (j + 1, i - 1))
					a_text_formatter.add_new_line
					j := i
					i := error_string.index_of ('%N', i + 1)
				end
			end
		end

feature {NONE} -- Implementation

	internal_error_string: STRING
			-- Internal copy of error description
			
invariant
	internal_error_string_not_void: internal_error_string /= Void

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

end -- class VIGE
