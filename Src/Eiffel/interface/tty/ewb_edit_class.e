note

	description:
		"Edit class text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EDIT_CLASS

inherit

	EWB_EDIT
	EWB_CLASS
		rename
			name as edit_class_cmd_name,
			help_message as edit_class_help,
			abbreviation as edit_class_abb
		redefine
			process_uncompiled_class
		end

feature {NONE} -- Execution

	associated_cmd: E_CLASS_CMD
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			check
				not_be_called: false
			end
		end

	process_uncompiled_class (class_i: CLASS_I)
			-- Edit class `class_i'.
		do
			edit (class_i.file_name.string_representation)
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

end -- class EWB_EDIT_CLASS
