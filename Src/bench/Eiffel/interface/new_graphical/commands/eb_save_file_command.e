indexing
	description	: "Command to save a file. Used by the development window and the dynamic lib window"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SAVE_FILE_COMMAND

inherit
	EB_FILEABLE_COMMAND
		redefine
			executable,
			make
		end

	TEXT_OBSERVER
		redefine
			on_text_reset, on_text_edited,
			on_text_back_to_its_last_saved_state
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_WORKBENCH

		--| FIXME ARNAUD: The option "Create Backup" should not be
		--| in the preferences of the development window but in the
		--| preferences of the editor.

	EB_GENERAL_DATA

create
	make

feature -- Initialization

	make (a_manager: like target) is
			-- Create a formatter associated with `a_manager'.
		do
			Precursor (a_manager)
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_s),
				True, False, False)
			accelerator.actions.extend (~execute)
			disable_sensitive
		end

feature -- Execution

	execute is
			-- Save a file with the chosen name.
		local   
			new_file, tmp_file: RAW_FILE	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING
			aok, create_backup, compileok: BOOLEAN
			save_as_cmd: EB_SAVE_FILE_AS_COMMAND
			tmp_name: STRING
			wd: EV_WARNING_DIALOG
		do
				-- FIXME XR: We add a test `is_sensitive' to prevent calls from the accelerator.
				-- It would be nicer to use the `executable' feature but that's 5.1 :)
			if is_sensitive and target.file_name /= Void then
				target.perform_check_before_save
				if
					Workbench.is_compiling and then
					Workbench.last_reached_degree > 4
				then
					create wd.make_with_text (Warning_messages.w_Degree_needed (5))
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					compileok := False
				else
					compileok := True
				end
				if
					target.check_passed and then
					compileok
				then
					create new_file.make (target.file_name)
					if new_file.exists then 
						aok := True
						if --(new_file.exists) and then 
							(not new_file.is_plain)
						then
							aok := False
							create wd.make_with_text (Warning_messages.w_Not_a_plain_file (new_file.name))
							wd.show_modal_to_window (window_manager.last_focused_development_window.window)
						elseif --new_file.exists and then 
							(not new_file.is_writable)
						then
							aok := False
							create wd.make_with_text (Warning_messages.w_Not_writable (new_file.name))
							wd.show_modal_to_window (window_manager.last_focused_development_window.window)
						end
		
							-- Create a backup of the file in case there will be a problem during the savings.
						tmp_name := clone (target.file_name)
						tmp_name.append (".swp")
						create tmp_file.make (tmp_name)
						create_backup := not tmp_file.exists and then tmp_file.is_creatable
		
						if not create_backup then
							tmp_file := new_file
						end
	
						if aok then
							to_write := target.text
							tmp_file.open_write
							if not to_write.is_empty then
								to_write.prune_all ('%R')
								if text_mode_is_windows then
									to_write.replace_substring_all ("%N", "%R%N")
									tmp_file.putstring (to_write)
								else
									tmp_file.putstring (to_write)
									if to_write.item (to_write.count) /= '%N' then 
										-- Add a carriage return like `vi' if there's none at the end 
										tmp_file.new_line
									end
								end
							end
							tmp_file.close
		
							if create_backup then
									-- We need to copy the backup file to the original file and then
									-- delete the backup file
								new_file.delete
								tmp_file.change_name (target.file_name)
							end
							target.set_last_saving_date (tmp_file.date)
							target.on_text_saved
						end
					else
						if --(not new_file.exists) and then 
							(not new_file.is_creatable)
						then
							aok := False
							create wd.make_with_text (Warning_messages.w_Not_creatable (new_file.name))
							wd.show_modal_to_window (window_manager.last_focused_development_window.window)
						else
							create save_as_cmd.make (target)
							save_as_cmd.execute_with_filename (target.file_name)
						end
					end
					target.update_save_symbol
					--manager.on_text_opened
				end
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Save_new
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_save
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Save
		end

	description: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Save
		end

	name: STRING is "Save_file"
			-- Name of the command. Used to store the command in the
			-- preferences.

	on_text_edited (directly_edited: BOOLEAN) is
			-- make the command sensitive
		do
			enable_sensitive
		end


	on_text_reset is
			-- make the command insensitive
		do
			disable_sensitive
		end

	on_text_back_to_its_last_saved_state is
			-- make the command insensitive
		do
			disable_sensitive
		end

feature {NONE} -- implementation

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

end -- class EB_SAVE_FILE_COMMAND
