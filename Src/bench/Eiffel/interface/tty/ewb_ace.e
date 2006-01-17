indexing
	description: "Displays Ace text in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	EWB_ACE 

inherit
	EWB_CMD
		rename
			name as ace_cmd_name,
			help_message as ace_loop_help,
			abbreviation as ace_abb
		end

feature {NONE} -- Execution

	execute is
			-- Execute Current batch command.
		local
			text: STRING;
		do
			check
				has_ace_file: Eiffel_ace.file_name /= Void
			end
			text := Eiffel_ace.text

			if text /= Void then
				output_window.put_string (text)
				output_window.put_new_line
			else
				output_window.put_string (Warning_messages.w_Cannot_read_file (Eiffel_ace.file_name))
				output_window.put_new_line
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

end -- class EWB_ACE
