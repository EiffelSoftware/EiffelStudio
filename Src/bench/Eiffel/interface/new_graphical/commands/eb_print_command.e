indexing
	description: "Command to print an editor content"
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

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_RESOURCES
		export
			{NONE} all
		end

	EB_SHARED_EDITOR_FONT
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_dev_win: EB_DEVELOPMENT_WINDOW) is
			-- Create a formatter associated with `a_manager'.
		do
		--	create accelerator.make_with_key_combination (
		--		create {EV_KEY}.make_with_code (Key_constants.Key_p),
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

	execute is
			-- Save a file with the chosen name.
		local
			printer: EB_PRINTER
		do
			if not dev_window.is_empty then
				create printer.make
				printer.set_text (dev_window.editor_tool.text_area.structured_text)
				printer.set_font (font)
				printer.set_window (dev_window.window)
				printer.set_job_name (dev_window.stone.history_name)
				if not use_external_editor then
					printer.ask_and_print
				else
					if use_postscript then
						printer.enable_postscript
					else
						printer.disable_postscript
					end
					printer.set_external_command (external_editor)
					printer.print_via_command
				end
			end
		end

	launch (shell_cmd: STRING; print_to_file, postscript: BOOLEAN) is
		local
			file_name: STRING
			cmd: STRING
			editor: EB_EDITOR
			shell_request: COMMAND_EXECUTOR
			file: PLAIN_TEXT_FILE
		do
			cmd := clone (shell_cmd)
				-- let's check if passed command is well written
			if cmd.substring_index ("$target", 1) /= 0 then
				editor := dev_window.current_editor
				file_name := generate_temp_name
				cmd.replace_substring_all ("$target", file_name)
				save_to_file (editor.text, file_name)
				if saved then
					create file.make (file_name)
					create shell_request
					shell_request.execute (cmd)
					file.delete
				end
			end
	--		if filterable_format = Void or else not postscript_t.is_selected then
	--			new_text := tool.text_area.text
	--		else
	--			new_text := filterable_format.filtered_text 
	--				(tool.stone, "PostScript")
	--		end
		end
		
feature {NONE} -- Implementation


	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Print
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_print
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Print
		end

	description: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_Print
		end

	name: STRING is "Print"
			-- Name of the command. Used to store the command in the
			-- preferences.

	on_text_edited (directly_edited: BOOLEAN) is
			-- Nothing.
		do
			--enable_sensitive
		end

	on_text_loaded is
			-- Update the command sensitivity.
		do
			if dev_window.is_empty then
				disable_sensitive
			else
				enable_sensitive
			end
		end

feature {NONE} -- implementation

	saved: BOOLEAN

	save_to_file (a_text: STRING; a_filename: STRING) is
			-- Save `a_text' in `a_filename'.
		require
			a_text_not_void: a_text /= Void
			a_filename_not_void: a_filename /= Void
		local
			char: CHARACTER
			new_file: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
		do
			saved := False
			if not a_filename.is_empty then
				create new_file.make (a_filename)
				if new_file.exists and then not new_file.is_plain then
					create wd.make_with_text (Warning_messages.w_Not_a_plain_file (new_file.name))
					wd.show_modal_to_window (dev_window.window)
				elseif new_file.exists and then not new_file.is_writable then
					create wd.make_with_text (Warning_messages.w_Not_writable (new_file.name))
					wd.show_modal_to_window (dev_window.window)
				elseif not new_file.exists and then not new_file.is_creatable then
					create wd.make_with_text (Warning_messages.w_Not_creatable (new_file.name))
					wd.show_modal_to_window (dev_window.window)
				else
					new_file.create_read_write
					if not a_text.is_empty then
						new_file.putstring (a_text)
						char := a_text.item (a_text.count)
						if char /= '%N' and then char /= '%R' then
								-- Add a carriage return like vi
								-- if there's none at the end
							new_file.new_line
						end
					end
					new_file.add_permission ("u", "wr")
					new_file.close
					saved := True
				end
			end
		end

	enable_toolbar_items is
			-- make toolbar items sensitive
		do
			from
				managed_toolbar_items.start
			until
				managed_toolbar_items.exhausted
			loop
				managed_toolbar_items.item.enable_sensitive
				managed_toolbar_items.forth
			end
		end

	disable_toolbar_items is
			-- make toolbar items insensitive
		do
			from
				managed_toolbar_items.start
			until
				managed_toolbar_items.exhausted
			loop
				managed_toolbar_items.item.disable_sensitive
				managed_toolbar_items.forth
			end
		end

feature {NONE} -- Implementation

	use_external_editor: BOOLEAN is
			-- Should we use an external editor to print?
		do
			Result := boolean_resource_value ("use_external_editor", False)
		end

	external_editor: STRING is
			-- Command line to invoke to use an external editor to print.
		do
			Result := string_resource_value ("print_shell_command", "lpr $target")
		end

	use_postscript: BOOLEAN is
			-- Should we use postscript when using an external editor to print?
		do
			Result := boolean_resource_value ("use_postscript", False)
		end

feature {NONE} -- Externals

	generate_temp_name: STRING is
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

	tempnam (d,p: POINTER): POINTER is
		external
			"C | <stdio.h>"
		end

end -- class EB_PRINT_COMMAND
