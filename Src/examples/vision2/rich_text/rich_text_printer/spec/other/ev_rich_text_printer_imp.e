note
	description: "Implementation of a printer under unices"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_PRINTER_IMP

inherit
	SHARED_EXECUTION_ENVIRONMENT

create {EV_RICH_TEXT_PRINTER}
	make

feature {NONE} -- Initialization

	make (interf: EV_RICH_TEXT_PRINTER)
			-- Initialize `Current' and associate it with `interf'.
		require
			valid_interface: interf /= Void
		do
			interface := interf
		ensure
			set_interface: interface = interf
		end

feature {EV_RICH_TEXT_PRINTER} -- Basic operations

	send_print_request
			-- Send a print request based on the parameters in `interface'.
		require
			text_set: interface.rich_text /= Void
			options_set: interface.context /= Void
			do_not_print_to_file: not interface.context.output_to_file
		local
			cmd: STRING_32
			name: STRING_32
			file: PLAIN_TEXT_FILE
			fn: PATH
			retried: INTEGER
			wd: EV_WARNING_DIALOG
			sent_text: STRING_32
			utf: UTF_CONVERTER
		do
			if retried = 0 then
				cmd := {STRING_32} "lp -d "
				name := interface.context.printer_name
				cmd.append (name)

					-- Generate the file we put the text in.
				create file.make_open_temporary_with_prefix (execution_environment.temporary_directory_path.extended ("ev-rtf-printer-").name)
				fn := file.path
					--| FIXME: for now, just using the plain text (without formatting)
				sent_text := interface.rich_text.text
				file.put_string (utf.utf_32_string_to_utf_8_string_8 (sent_text))
				file.close

					-- Launch the print session.
				cmd.append_character (' ')
				cmd.append (file.path.name)
				(create {EXECUTION_ENVIRONMENT}).system (cmd)
				file.delete
			elseif retried = 1 then
				if fn = Void then
					create fn.make_from_string ("")
				end
				create wd.make_with_text ({STRING_32} "Can not write in file %"" + fn.name + "%"")
				wd.show_modal_to_window (interface.window)
				if file /= Void then
					file.delete
				end
			end
		rescue
			retried := retried + 1
			retry
		end

feature {EV_RICH_TEXT_PRINTER} -- Implementation

	interface: EV_RICH_TEXT_PRINTER
			-- The object that is visible from outside.

invariant
	valid_interface: interface /= Void

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
