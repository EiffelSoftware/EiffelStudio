indexing
	description	: "Command to open a file"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
class
	EB_OPEN_FILE_COMMAND

inherit
	EB_FILEABLE_COMMAND

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			initialize
		end

	EB_CONFIRM_SAVE_CALLBACK
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_o),
				True, False, False)
			accelerator.actions.extend (~execute)
		end

feature -- Basic operation

	execute is
			-- Open a file.
		local
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if target.changed then
					-- Ask confirmation if content has changed.
				create csd.make_and_launch (target, Current)
			else
				process
			end
		end

feature -- Properties

	menu_name: STRING is
		do
			Result := Interface_names.m_Open_new
		end

	pixmap: ARRAY [EV_PIXMAP] is
		do
			Result := Pixmaps.Icon_open_file
		end

	name: STRING is "Open_file"

	description: STRING is
		do
			Result := Interface_names.e_Open_file
		end

	tooltip: STRING is
		do
			Result := description
		end

feature {NONE} -- Implementation

	process is
		local
			fod: EV_FILE_OPEN_DIALOG
		do
			create fod
			fod.set_filter ("*.e")
			fod.ok_actions.extend (~execute_callback (fod))
			fod.show_modal_to_window (window_manager.last_focused_development_window.window)
		end
	
	execute_callback (dialog: EV_FILE_OPEN_DIALOG) is
			-- Open a file.
		local
			fn: FILE_NAME
			f: PLAIN_TEXT_FILE
			bckfn: FILE_NAME
			backup_file: PLAIN_TEXT_FILE
			cd: EV_CONFIRMATION_DIALOG
			class_i: CLASS_I
			class_stone: CLASSI_STONE
			wd: EV_WARNING_DIALOG
		do
			create fn.make_from_string (dialog.file_name)
			if not fn.is_empty then
				bckfn := clone (fn)
				bckfn.add_extension ("swp")
				create backup_file.make (bckfn)
				open_backup := False
				if backup_file.exists then
					ask_whether_to_open_backup
				end
				if open_backup then
					create f.make (bckfn)
				else
					create f.make (fn)
				end
				if f.exists and then f.is_readable and then f.is_plain then
					class_i := Eiffel_universe.class_with_file_name (fn)
					if class_i = Void then
						create wd.make_with_text (Warning_messages.w_Cannot_open_any_file)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					else
						if class_i.compiled then
							create {CLASSC_STONE} class_stone.make (class_i.compiled_class)
						else
							create {CLASSI_STONE} class_stone.make (class_i)
						end
						target.set_stone (class_stone)
					end
				elseif f.exists and then not f.is_plain then
					create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
					cd.button ("OK").select_actions.extend (~execute)
					cd.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
					create cd.make_with_text (Warning_messages.w_Cannot_read_file_retry (fn))
					cd.button ("OK").select_actions.extend (~execute)
					cd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
			else
				create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
				cd.button ("OK").select_actions.extend (~execute)
				cd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	ask_whether_to_open_backup is
			-- Display a dialog asking the user whether he wants to open
			-- the original file or the backup one, and set `open_backup' accordingly.
		local
			dial: EV_DIALOG
			butbackup, butnormal: EV_BUTTON
			lab: EV_LABEL
			butcont: EV_HORIZONTAL_BOX
			maincont: EV_VERTICAL_BOX
		do
			create dial
			create butcont
			create maincont
			create butbackup.make_with_text (Interface_names.b_Open_backup)
			butbackup.select_actions.extend (~open_backup_selected)
			butbackup.select_actions.extend (dial~destroy)
			create butnormal.make_with_text (Interface_names.b_Open_original)
			butnormal.select_actions.extend (~open_normal_selected)
			butnormal.select_actions.extend (dial~destroy)
			create lab.make_with_text (Warning_messages.w_Found_backup)
			butcont.set_padding (3)
			butcont.extend (create {EV_CELL})
			butcont.extend (butbackup)
			butcont.disable_item_expand (butbackup)
			butcont.extend (butnormal)
			butcont.disable_item_expand (butnormal)
			butcont.extend (create {EV_CELL})
			maincont.set_padding (5)
			maincont.set_border_width (3)
			maincont.extend (lab)
			maincont.disable_item_expand (lab)
			maincont.extend (butcont)
			maincont.disable_item_expand (butcont)
			dial.set_title ("Backup found")
			dial.extend (maincont)
			dial.set_size (dial.minimum_width, dial.minimum_height)
			dial.disable_user_resize
			dial.set_default_push_button (butbackup)
			dial.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	open_normal_selected is
			-- The open normal button was pushed.
		do
			open_backup := False
		end

	open_backup_selected is
			-- The open backup button was pushed.
		do
			open_backup := True
		end

	open_backup: BOOLEAN
			-- If a backup file is present, indicates whether it should be opened or not.

end -- class EB_OPEN_FILE_CMD
