note
	description: "Displays class's path in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	EWB_SHOW_FILE_PATH

inherit

	EWB_FILTER_CLASS
		rename
			name as path_cmd_name,
			help_message as path_help,
			abbreviation as path_abb
		redefine
			process_uncompiled_class, process_compiled_class,
			want_compiled_class
		end

create
	make, default_create

feature {NONE} -- Implementation

	associated_cmd: E_CLASS_CMD
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			check
				not_be_called: False
			end
		end

feature {NONE} -- Execution

	want_compiled_class (class_i: CLASS_I): BOOLEAN
			-- Does Current want `class_i' to be compiled?
			--| If the class is in the system: True
			--| else: False.
		do
			Result := class_i.compiled_class /= Void
		end

	process_compiled_class (a_class: CLASS_C)
			-- Display the path of `a_class'.
		do
			output_window.put_string (a_class.file_name)
			output_window.put_new_line
		end

	process_uncompiled_class (class_i: CLASS_I)
			-- Display the path of `class_i'.
		do
			output_window.put_string (class_i.file_name.name)
			output_window.put_new_line
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
