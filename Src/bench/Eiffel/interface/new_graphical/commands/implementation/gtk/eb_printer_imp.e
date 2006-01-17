indexing
	description: "Implementation of a printer under GTK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINTER_IMP

inherit

	EB_CONSTANTS

	EB_SHARED_MANAGERS

create {EB_PRINTER}
	make

feature {NONE} -- Initialization

	make (interf: EB_PRINTER) is
			-- Initialize `Current' and associate it with `interf'.
		require
			valid_interface: interf /= Void
		do
			interface := interf
		ensure
			set_interface: interface = interf
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature {EB_PRINTER} -- Basic operations

	send_print_request is
			-- Send a print request based on the parameters in `interface'.
		require
			text_set: interface.text /= Void
			options_set: interface.context /= Void
			do_not_print_to_file: not interface.context.output_to_file
		local
			cmd: STRING
			name: STRING
			fn: FILE_NAME
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			wd: EV_WARNING_DIALOG
			sent_text: STRING
		do
			if not retried then
				cmd := "lp -d "
				name := interface.context.printer_name
				cmd.append (name)
				
					-- Generate the file we put the text in.
				create fn.make_temporary_name
				create file.make (fn)
				if file.exists then
					file.open_write
				else
					file.create_read_write
				end
				sent_text := interface.text.image
				sent_text.prune_all ('%R')
				sent_text.replace_substring_all ("%N", "%R%N")
				file.put_string (sent_text)
				file.close
				
					-- Launch the print session.
				cmd.append_character (' ')
				cmd.append (fn)
				(create {EXECUTION_ENVIRONMENT}).launch (cmd)
			else
				if fn = Void then
					create fn.make_from_string ("")
				end
				create wd.make_with_text (Warning_messages.w_Not_writable (fn))
				wd.show_modal_to_window (window_manager.last_focused_window.window)
			end
		rescue
			retried := True
			retry
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRINTER} -- Implementation

	interface: EB_PRINTER
			-- The object that is visible from outside.

feature {NONE} -- Implementation

	generate_temp_name: STRING is
			-- Generate a temporary file name.
		local
			prefix_name: STRING
			a: ANY
			p: POINTER
		do
			prefix_name := "estudio_"
			a := prefix_name.to_c
			p := tempnam (default_pointer, $a)

			create Result.make (0)
			Result.from_c (p)
		end

	tempnam (d,p: POINTER): POINTER is
		external
			"C | <stdio.h>"
		end

invariant
	valid_interface: interface /= Void

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

end -- class EB_PRINTER_IMP
