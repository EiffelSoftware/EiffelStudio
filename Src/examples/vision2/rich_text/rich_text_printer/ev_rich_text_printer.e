note
	description: "[
			Printer of EV_RICH_TEXT content.
			On Windows, using the RTF formatted content.
			On others, for now, just printing the plain text via the "lp" utility.
			
			
			TODO:
			on non Windows platform, a few ideas to print the rich text content:
			
				to convert RTF to PDF:
				- using "ted"
					sudo apt-get install ted
					/usr/share/ted/Ted/rtf2pdf.sh source-file dest-file
				- using libreoffie
					libreoffice --headless --invisible --norestore --convert-to pdf source-file.rtf

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_PRINTER

inherit
	EV_PRINT_DIALOG
		redefine
			create_implementation,
			implementation
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_rich_text: EV_RICH_TEXT; a_window: EV_WINDOW)
		do
			rich_text := a_rich_text
			window := a_window
			default_create
		end

feature -- Status report

	rich_text: EV_RICH_TEXT
			-- Text that will be printed next time.

	job_name: detachable STRING_GENERAL
			-- Name for the print job.
			--| Optional, only used on Windows.

	window: EV_WINDOW
			-- Window to which dialogs will be relative.

feature -- Status setting

	set_rich_text (rt: EV_RICH_TEXT)
			-- Set the text that should be printed next.
		do
			rich_text := rt
		ensure
			rich_text = rt
		end

	set_window (wnd: EV_WINDOW)
			-- Define the window to which dialogs will be relative.
		do
			window := wnd
		ensure
			window = wnd
		end

	set_job_name (nname: like job_name)
			-- Set the name of the next print job.
			--| Only used on Windows. Optional.
		do
			job_name := nname
		end

feature -- Conversion

	to_rtf: STRING
			-- RTF formatted content from `a_rich_text` content.
		local
			f: RAW_FILE
		do
			if attached execution_environment.temporary_directory_path as tmp then
				create f.make_open_temporary_with_prefix (tmp.extended ("ev-rtf-printer-").name)
			else
				create f.make_open_temporary_with_prefix ("ev-rtf-printer-")
			end
			f.close
			rich_text.save_to_named_path (f.path)
			create Result.make (f.count)
			f.open_read
			from
			until
				f.end_of_file or f.exhausted
			loop
				f.read_stream (1_024)
				Result.append_string (f.last_string)
			end
			f.close
			f.delete
		end

feature -- Basic operations

	print_text (ctx: EV_PRINT_CONTEXT)
			-- Launch an effective print job.
		require
			text_set: rich_text /= Void
			valid_options: (ctx.output_to_file) implies (attached ctx.file_path as fp and then
						(create {RAW_FILE}.make_with_path (fp)).is_creatable)
		local
			retried: BOOLEAN
		do
			if not retried then
				if ctx.output_to_file then
					rich_text.save_to_named_path (ctx.file_path)
				else
					implementation.send_print_request (ctx)
				end
			end
		rescue
			retried := True
			retry
		end

	ask_and_print
			-- Pop up an EV_PRINT_DIALOG to query the context and then print `text'.
			-- May be cancelled.
		require
			text_set: rich_text /= Void
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

feature {NONE} -- Implementation: graphical interface

	call_print_from (d: EV_PRINT_DIALOG)
			-- Initialize `Current's parameters with the values in `d' and call `print_text'.
		require
			valid_print_dialog: d /= Void -- and not d.is_destroyed to query it?
			text_set: rich_text /= Void
			window_set: window /= Void
		local
			fn: PATH
			f: FILE
			err_dlg: EV_ERROR_DIALOG
			ctx: EV_PRINT_CONTEXT
		do
			ctx := d.print_context
			fn := ctx.file_path
			if ctx.output_to_file then
				if fn = Void then
					create err_dlg.make_with_text ({STRING_32} "Cannot create file %"%"")
					err_dlg.show_modal_to_window (window)
				else
					create {RAW_FILE} f.make_with_path (fn)
					if f.exists or not f.is_creatable then
						create err_dlg.make_with_text ({STRING_32} "Cannot create file %"" + fn.name + "%"")
						err_dlg.show_modal_to_window (window)
					else
						print_text (ctx)
					end
				end
			else
				print_text (ctx)
			end
		end

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_RICH_TEXT_PRINTER_IMP
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_RICH_TEXT_PRINTER_IMP} implementation.make
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
