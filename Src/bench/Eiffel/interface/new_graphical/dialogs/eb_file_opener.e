indexing
	description: "Command to open a file, and display warnings in case of errors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILE_OPENER

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_parent

feature {NONE} -- Initialization

	make_with_parent (caller: EB_FILE_OPENER_CALLBACK; fn: STRING; parent_window: EV_WINDOW) is
			-- Initialize with parent window `a_parent'
		local
			aok: BOOLEAN
			wd: EV_WARNING_DIALOG
			qd: EV_QUESTION_DIALOG
			warning_message: STRING
			file: RAW_FILE -- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
		do
			if not fn.is_empty then
				create file.make (fn)
				aok := True
				if file.exists and then not file.is_plain then
					warning_message := Warning_messages.w_Not_a_plain_file (fn)
					
				elseif file.exists and then not file.is_writable then
					warning_message := Warning_messages.w_Not_writable (fn)
					
				elseif not file.is_creatable then
					warning_message := Warning_messages.w_Not_creatable (fn)
					
				elseif file.exists and then file.is_writable then
					create qd.make_with_text (Warning_messages.w_File_exists (fn))
					qd.show_modal_to_window (parent_window)
					aok := qd.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_yes)
				end
			else
				warning_message := Warning_messages.w_Not_a_plain_file (fn)
			end
			
			if warning_message /= Void then
				aok := False
				create wd.make_with_text (warning_message)
				wd.show_modal_to_window (parent_window)
			end
			
			if aok then 
				caller.save_file (file)
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

end -- class EB_FILE_OPENER
