note
	description: "Command to print an editor content"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINT_COMMAND

inherit

	TEXT_OBSERVER
		redefine
			on_text_loaded, on_text_edited
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_EDITOR_FONT
		export
			{NONE} all
		end

	EB_RECYCLABLE

create
	make

feature -- Initialization

	make (a_dev_win: EB_DEVELOPMENT_WINDOW)
			-- Create a formatter associated with `a_manager'.
		do
		--	create accelerator.make_with_key_combination (
		--		create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_p),
		--		True, False, False)
		--	accelerator.actions.extend (~execute)
			dev_window := a_dev_win
			if
				a_dev_win.is_empty
			then
				disable_sensitive
			else
				enable_sensitive
			end
		end

feature -- Access

	dev_window: EB_DEVELOPMENT_WINDOW
			-- development window to which this command is related

feature -- Execution

	execute
			-- Save a file with the chosen name.
		local
			printer: EB_PRINTER
			l_txt_gen: EB_PRINTER_TEXT_GENERATOR
			l_editor: EB_CLICKABLE_EDITOR
		do
			l_editor := dev_window.editors_manager.current_editor
			if l_editor /= Void then
				create l_txt_gen.make (l_editor)
				if not dev_window.is_empty then
					create printer.make
					printer.set_text (l_txt_gen.text_for_printing)
					printer.set_window (dev_window.window)
					printer.set_job_name (dev_window.stone.history_name)
					if not use_external_editor then
						printer.ask_and_print
					else
						printer.set_external_command (external_editor)
						printer.print_via_command
					end
				end
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Print
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_print_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_print_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Print
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Print
		end

	description: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_Print
		end

	name: STRING = "Print"
			-- Name of the command. Used to store the command in the
			-- preferences.

	on_text_edited (directly_edited: BOOLEAN)
			-- Nothing.
		do
			--enable_sensitive
		end

	on_text_loaded
			-- Update the command sensitivity.
		do
			if dev_window.is_empty then
				disable_sensitive
			else
				enable_sensitive
			end
		end

feature {NONE} -- Recyclable

	internal_recycle
			-- Recycle
		do
			dev_window := Void
		end

feature {NONE} -- implementation

	saved: BOOLEAN
			-- If saved?

	save_to_file (a_text: STRING; a_filename: READABLE_STRING_GENERAL)
			-- Save `a_text' in `a_filename'.
		require
			a_text_not_void: a_text /= Void
			a_filename_not_void: a_filename /= Void
		local
			char: CHARACTER
			new_file: PLAIN_TEXT_FILE
		do
			saved := False
			if not a_filename.is_empty then
				create new_file.make_with_name (a_filename)
				if new_file.exists and then not new_file.is_plain then
					prompts.show_error_prompt (Warning_messages.w_Not_a_plain_file (a_filename), dev_window.window, Void)
				elseif new_file.exists and then not new_file.is_writable then
					prompts.show_error_prompt (Warning_messages.w_Not_writable (a_filename), dev_window.window, Void)
				elseif not new_file.exists and then not new_file.is_creatable then
					prompts.show_error_prompt (Warning_messages.w_Not_creatable (a_filename), dev_window.window, Void)
				else
					new_file.create_read_write
					if not a_text.is_empty then
						new_file.put_string (a_text)
						char := a_text.item (a_text.count)
						if char /= '%N' and then char /= '%R' then
								-- Add a carriage return like vi
								-- if there's none at the end
							new_file.put_new_line
						end
					end
					new_file.add_permission ("u", "wr")
					new_file.close
					saved := True
				end
			end
		end

feature {NONE} -- Implementation

	use_external_editor: BOOLEAN
			-- Should we use an external editor to print?
		do
			Result := preferences.misc_data.use_external_editor
		end

	external_editor: STRING
			-- Command line to invoke to use an external editor to print.
		do
			Result := preferences.misc_data.print_shell_command
		end

feature {NONE} -- Externals

	generate_temp_name: STRING
			-- Generate a temporary file name.
		local
			prefix_name: STRING
			a: ANY
			p: POINTER
		do
			prefix_name := "bench_"
			a := prefix_name.to_c
			p := tempnam (default_pointer, $a)

			create Result.make (0)
			Result.from_c (p)
		end

	tempnam (d,p: POINTER): POINTER
		external
			"C | <stdio.h>"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class EB_PRINT_COMMAND
