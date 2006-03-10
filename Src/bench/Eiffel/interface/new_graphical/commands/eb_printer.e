indexing
	description: "Objects capable of printing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINTER

inherit
	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do

		end

feature -- Access

feature -- Measurement

feature -- Status report

	text: STRING
			-- Text that will be printed next time.
			--| To print a file, just generate a TEXT_FORMATTER with one token for example...

	job_name: STRING
			-- Name for the print job.
			--| Optional, only used on Windows.

	context: EV_PRINT_CONTEXT
			-- Options used for the print job.

	window: EV_WINDOW
			-- Window to which dialogs will be relative.

	external_command: STRING
			-- Command line used to print a file.
			--| $target in it will be automatically replaced with the file name when printing.
			--| Necessary only for `print_via_command'.

	use_postscript: BOOLEAN
			-- Should a postscript file be generated before sending it to the external command?

	font: EV_FONT
			-- Set the font used for direct printing.

feature -- Status setting

	set_text (stt: STRING) is
			-- Set the text that should be printed next.
		do
			text := stt
		ensure
			text = stt
		end

	set_window (wnd: EV_WINDOW) is
			-- Define the window to which dialogs will be relative.
		do
			window := wnd
		ensure
			window = wnd
		end

	set_print_context (pc: EV_PRINT_CONTEXT) is
			-- Define the options used for the next print job.
		do
			context := pc
		ensure
			context = pc
		end

	set_job_name (nname: STRING) is
			-- Set the name of the next print job.
			--| Only used on Windows. Optional.
		do
			job_name := nname
		end

	set_external_command (cmd: STRING) is
			-- Set the command that should be invoked to print files using an external editor.
		do
			external_command := cmd
		ensure
			command_set: (cmd = Void) = (external_command = Void)
			same_command: cmd /= Void implies cmd.is_equal (external_command)
		end

	enable_postscript is
			-- Set `use_postscript' to True.
		do
			use_postscript := True
		ensure
			use_postscript = True
		end

	disable_postscript is
			-- Set `use_postscript' to False.
		do
			use_postscript := False
		ensure
			use_postscript = False
		end

	set_font (f: EV_FONT) is
			-- Define the font used for direct printing.
			--| Windows only.
		require
			valid_font: f /= Void
		do
			font := f
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	print_text is
			-- Launch an effective print job.
		require
			text_set: text /= Void
			options_set: context /= Void
			valid_options: context.output_to_file implies (context.file_name /= Void and then
						(create {RAW_FILE}.make (context.file_name)).is_creatable)
		local
			f: FILE
			retried: BOOLEAN
		do
			if not retried then
				if context.output_to_file then
						-- Ok, that's an easy one, there is no actual print job.
					generate_postscript
					create {RAW_FILE} f.make_create_read_write (context.file_name)
					f.put_string (postscript_representation)
					f.close
				else
					implementation.send_print_request
				end
			end
		rescue
			retried := True
			retry
		end

	ask_and_print is
			-- Pop up an EV_PRINT_DIALOG to query the context and then print `text'.
			-- May be cancelled.
		require
			text_set: text /= Void
			window_set: window /= Void
		local
			dial: EV_PRINT_DIALOG
		do
			create dial
			dial.print_actions.extend (agent call_print_from (dial))
			dial.select_all_pages
			dial.disable_page_numbers
			dial.disable_selection

			dial.show_modal_to_window (window)
		end

	print_via_command is
			-- Invoke an external command to print `text'.
		require
			cmd_set: external_command /= Void and then not external_command.is_empty
			valid_text_set: text /= Void
		local
			file_name: FILE_NAME
			cmd: STRING
			sent_txt: STRING
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
					-- Generate the output text.
				if use_postscript then
					generate_postscript
					sent_txt := postscript_representation
				else
					sent_txt := text
					sent_txt.prune_all ('%R')
					sent_txt.replace_substring_all ("%N", "%R%N")
				end
					-- Generate the file we put the text in.
				create file_name.make_temporary_name
				create file.make (file_name)
				if file.exists then
					file.open_write
				else
					file.create_read_write
				end
				file.put_string (sent_txt)
				file.close
					-- Generate the actual command line.
				cmd := external_command.twin
				cmd.replace_substring_all ("$target", file_name)
					-- Send the command.
				(create {EXECUTION_ENVIRONMENT}).launch (cmd)
					-- Delete the temporary file.
					--| FIXME XR: It is too soon, the external command didn't have time to load the file!
				--file.delete
			end
		rescue
			retried := True
			retry
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRINTER_IMP} -- Implementation: Postscript generation

	postscript_representation: STRING
			-- What should be printed in a postscript format.

	generate_postscript is
			-- Fill in `postscript_representation'.
		require
			text_set: text /= Void
		local
			tf: TEXT_FILTER
		do
			if not text.is_empty then
					--| Fixme:
					--| We simply use text from the editor to print for the moment,
					--| A EDITOR_TOKEN_VISITOR will be made to generate text from text filter.
--				create tf.make ("PostScript")
--				tf.set_universe (create {DOCUMENTATION_UNIVERSE}.make)
--				tf.process_text (text)
--				postscript_representation := tf.image
				postscript_representation := text
			else
				create postscript_representation.make (1)
			end
		ensure
			postscript_generated: postscript_representation /= Void
		end

feature {NONE} -- Implementation: graphical interface

	implementation: EB_PRINTER_IMP is
			-- Object used to send print requests.
		do
			if internal_implementation = Void then
				create internal_implementation.make (Current)
			end
			Result := internal_implementation
		end

	internal_implementation: EB_PRINTER_IMP
			-- Once per object implementation.

	call_print_from (d: EV_PRINT_DIALOG) is
			-- Initialize `Current's parameters with the values in `d' and call `print_text'.
		require
			valid_print_dialog: d /= Void -- and not d.is_destroyed to query it?
			text_set: text /= Void
			window_set: window /= Void
		local
			wd: EV_WARNING_DIALOG
			fn: FILE_NAME
			f: FILE
		do
			context := d.print_context
			create fn.make_from_string (context.file_name)
			if context.output_to_file then
				if fn = Void then
					create wd.make_with_text (Warning_messages.w_Cannot_create_file (""))
					wd.show_modal_to_window (window)
				else
					create {RAW_FILE} f.make (fn)
					if f.exists or not f.is_creatable then
						create wd.make_with_text (Warning_messages.w_Cannot_create_file (fn))
						wd.show_modal_to_window (window)
					else
						print_text
					end
				end
			else
				print_text
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

end -- class EB_PRINTER
