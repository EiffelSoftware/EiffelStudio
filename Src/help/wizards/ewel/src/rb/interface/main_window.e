indexing
	description: "Main window of Resource Bench"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			class_icon,
			closeable,
			on_paint,
			on_size,
			on_menu_command,
			on_menu_select,
			on_accelerator_command,
			on_control_id_command ,
			on_notify,
			on_set_cursor
		end

	TABLE_OF_SYMBOLS

	ERROR_HANDLING

	INTERFACE_MANAGER

	EXECUTION_ENVIRONMENT

	TDS_DEFINE_TABLE

	RB_DATA

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_HT_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

    	WEL_TB_STYLE_CONSTANTS						       
    		export
    			{NONE} all
    		end
    
    	WEL_TB_STATE_CONSTANTS
    		export
    			{NONE} all
    		end

	WEL_SIZE_CONSTANTS
    		export
    			{NONE} all
    		end

	WEL_TTF_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_IDB_CONSTANTS
		export
			{NONE} all
		end

	WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS
		export
			{NONE} all
		end

	WEL_TTN_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVN_CONSTANTS
		export
			{NONE} all
		end

	WEL_HELP_CONSTANTS
		export
			{NONE} all
		end

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create the main window of resource bench.
		do
			make_top (Title)
			interface.set_dialog_parent (Current)

				-- Create a toolbar.
			!! tool_bar.make (Current, Idr_toolbar)
			tool_bar.add_bitmaps (standard_toolbar_bitmaps, 6)
			standard_index := tool_bar.last_bitmap_index

			tool_bar.add_bitmaps (toolbar_bitmaps, 1)
			rb_index := tool_bar.last_bitmap_index

			tool_bar.add_buttons (toolbar_buttons)
			tool_bar.disable_button (Cmd_file_save_project)
			tool_bar.disable_button (Cmd_build_wel_code)

				-- Create Status.
			!! status_window.make (Current, status_window_id)
			status_window.set_parts (<<-1>>)

				-- Create client.
--			!! client_window.make (Current, "Client Window")
	
				-- Create the menu bar.
			set_menu (main_menu)
			main_menu.disable_item (Cmd_file_new)
			main_menu.disable_item (Cmd_file_close)
			main_menu.disable_item (Cmd_file_save_project)
			main_menu.disable_item (Cmd_build_wel_code)
			main_menu.disable_item (Cmd_build_resource_file)

			!! cursor.make_by_predefined_id (Idc_arrow)
			cursor.set
			
			set_application_directory (current_working_directory)

			show
			create_analyzer (Current)
		end


feature -- Access

	status_window_id: INTEGER is 128
			-- The status window id.

	main_menu: WEL_MENU is
			-- The `main_menu' of the Resource Bench application.
		once
			!! Result.make_by_id (Idr_menu)
		ensure
			result_not_void: Result /= Void
		end

        client_window: CLIENT_WINDOW
			-- Window inside client area
			-- minus toolbar and status window.

        status_window: WEL_STATUS_WINDOW
			-- Status window of main window.

	tree_view: WEL_TREE_VIEW
			-- Tree view control.

	properties_window: RESOURCE_PROPERTIES_WINDOW
			-- Properties Window.

	analyzer: PROCESS
			-- Resource analyser.

	cursor: WEL_CURSOR
			-- Current cursor.

	tool_bar: WEL_TOOL_BAR
			-- Tool bar of main window.

	standard_index, rb_index: INTEGER
			-- indexes for toolbars.

	standard_toolbar_bitmaps: WEL_TOOL_BAR_BITMAP is
			-- Bitmap containing the small standard bitmaps
    			-- for the toolbar.
		once
			!! Result.make_by_predefined_id (Idb_std_small_color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

   	toolbar_bitmaps: WEL_TOOL_BAR_BITMAP is
			-- Bitmap containing the small bitmaps
    			-- for the toolbar.
    		once
    			!! Result.make (Idr_toolbar)
    		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

    	toolbar_buttons: ARRAY [WEL_TOOL_BAR_BUTTON] is
    			-- Create the buttons for the toolbar
    		local
    			button: WEL_TOOL_BAR_BUTTON
    		once    
    			!! Result.make (0, 5)

    			!! button.make_separator
    			Result.force (button, 0)

    			!! button.make_button (standard_index + Std_filenew, Cmd_file_new)
			button.set_state (Tbstate_indeterminate)
    			Result.force (button, 1)

    			!! button.make_button (standard_index + Std_fileopen, Cmd_file_open)
    			Result.force (button, 2)

   			!! button.make_button (standard_index + Std_filesave, Cmd_file_save_project)
    			Result.force (button, 3)

    			!! button.make_separator
    			Result.force (button, 4)

  			!! button.make_button (rb_index, Cmd_build_wel_code)
    			Result.force (button, 5)
    		ensure
			result_not_void: Result /= Void
		end


feature -- Behavior

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR) is
		local
			tt1: WEL_TOOLTIP_TEXT 
		do
			if info.code = Ttn_needtext then
					-- Set resource string id.
				!! tt1.make_by_nmhdr (info)
				tt1.set_text_id (tt1.hdr.id_from)
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		do
--			if (properties_window = Void) or (properties_window /= Void and not properties_window.exists) then
--				paint_dc.rectangle (1, tool_bar.height + 1, client_rect.width, client_rect.height)
--			end
		end

    	on_size (a_size_type, a_width, a_height: INTEGER) is
    			-- Reposition windows in the main window.
    		do
--    			if (a_size_type /= Size_minimized) then
--				if (status_window /= Void) then
--					status_window.reposition
--				end
--
--				if tool_bar /= Void then
--  					tool_bar.reposition
--  			end
--
--				if client_window /= Void then
--					client_window.move_and_resize (0, tool_bar.height,
--						client_rect.width, client_rect.height -
--						tool_bar.height - status_window.height, True)
--				end
--		
--				if (tree_view /= Void) then
--					tree_view.move_and_resize (-1, -1,
--						250,
--						client_window.height - 2, True)
--				end
--
--				if (properties_window /= Void) then
--					properties_window.move_and_resize (tree_view.width -1, -2,
--						client_window.width - tree_view.width,
--						client_window.height, False)
--				end
--			end
		end

	on_menu_command (a_menu_id: INTEGER) is
			-- Execute the command correpsonding to `menu_id'.
		local
			exit: BOOLEAN
			file_extension: STRING
			message: STRING
		do
			inspect
				a_menu_id

			when Cmd_file_new then
                        
			when Cmd_file_open then
				open_file_dialog.activate (Current)
				if open_file_dialog.selected then
					file_extension := clone (open_file_dialog.file_name)
					file_extension.tail (file_extension.count - open_file_dialog.file_extension_offset + 1)

					if file_extension.is_equal ("rc") or file_extension.is_equal ("RC")then
						do_analyze (Current, open_file_dialog)
						main_menu.enable_item (Cmd_file_close)
						main_menu.enable_item (Cmd_file_save_project)
						main_menu.enable_item (Cmd_build_wel_code)
						main_menu.enable_item (Cmd_build_resource_file)
						tool_bar.enable_button (Cmd_file_save_project)
						tool_bar.enable_button (Cmd_build_wel_code)
					elseif file_extension.is_equal ("prb") or  file_extension.is_equal ("PRB")  then
						do_open_project (Current, open_file_dialog)
						main_menu.enable_item (Cmd_file_close)
						main_menu.enable_item (Cmd_file_save_project)
						main_menu.enable_item (Cmd_build_wel_code)
						main_menu.enable_item (Cmd_build_resource_file)
						tool_bar.enable_button (Cmd_file_save_project)
						tool_bar.enable_button (Cmd_build_wel_code)
					else
						!! message.make (30)
						message.append ("Resource Bench couldn't open the file:%N")
						message.append (open_file_dialog.file_name)
						interface.display_text (std_error, message)
					end
				end

			when Cmd_file_close then
				if tds /= Void then
--					tree_view.destroy
--					tree_view := Void
--					properties_window.destroy
--					properties_window := Void
--					invalidate
--
--					client_window.set_current_resource (Void)
--					erase_tds
--					main_menu.disable_item (Cmd_file_close)
--					main_menu.disable_item (Cmd_file_save_project)
--					main_menu.disable_item (Cmd_build_wel_code)
--					main_menu.disable_item (Cmd_build_resource_file)
--					tool_bar.disable_button (Cmd_file_save_project)
--					tool_bar.disable_button (Cmd_build_wel_code)
				else
					interface.display_text (std_error, "No current project.")
				end		

			when Cmd_file_save_project then
				if tds /= Void then
--					client_window.set_last_change
--					save_project_file_dialog.activate (Current)
--					if save_project_file_dialog.selected then
--						do_save_project (save_project_file_dialog.file_name)
--					end
				else
					interface.display_text (std_error, "No current project.")
				end
				
			when Cmd_file_exit then
				exit := closeable

			when Cmd_build_wel_code then
				if tds /= Void then
					client_window.set_last_change
					do_wel_code
				else
					interface.display_text (std_error, "No current project.")
				end

			when Cmd_build_resource_file then
				if tds /= Void then
					client_window.set_last_change
					save_resource_file_dialog.activate (Current)
					if save_resource_file_dialog.selected then
						do_resource_file (save_resource_file_dialog.file_name)
					end
				else
					interface.display_text (std_error, "No current project.")
				end

			when Cmd_help_content then
				set_working_directory (current_working_directory)
				change_working_directory (application_directory)
				win_help (Help_file, Help_contents, 0)
				change_working_directory (working_directory)

			when Cmd_help_about_rb then
				do_about				

			else
			
	
			end
		end

	on_menu_select (menu_item: INTEGER; flags: INTEGER; a_menu: WEL_MENU) is
			-- Display a message in the status window corresponding
			-- to the selected menu_item.
		do
			status_window.set_text_part (0, resource_string_id (menu_item))
		end

	on_accelerator_command (a_accelerator_id: INTEGER) is
			-- Perform the corresponding menu command with id `a_accelerator_id'.
		do
			on_menu_command (a_accelerator_id)
		end

	on_control_id_command (a_control_id: INTEGER) is
			-- Perform the corresponding menu command with id `a_control_id'.
		do
			on_menu_command (a_control_id)
		end

	on_set_cursor (a_hit_test: INTEGER) is
			-- Set the cursor only in the client area.
		do
			if (cursor /= Void) then
				if a_hit_test = Htclient then
					cursor.set
				end
			end
		end

feature {NONE} -- Implementation

	open_file_dialog: WEL_OPEN_FILE_DIALOG is
			-- Display the standard open file dialog.
		local
			ofn: WEL_OFN_CONSTANTS
		once
			!! ofn
			!! Result.make
			Result.set_filter (<<"Resource file (*.rc)", "Project file (*.prb)", "All file (*.*)">>, <<"*.rc", "*.prb", "*.*">>)
			Result.add_flag (ofn.Ofn_filemustexist)
		ensure
			result_not_void: Result /= Void
		end

	save_resource_file_dialog: WEL_SAVE_FILE_DIALOG is
			-- Display the standard save file dialog.
		once
			!! Result.make
			Result.set_filter (<<"Resource file (*.rc)", "All file (*.*)">>, <<"*.rc", "*.*">>)
		ensure
			result_not_void: Result /= Void
		end

	save_project_file_dialog: WEL_SAVE_FILE_DIALOG is
			-- Display the standard save file dialog.
		once
			!! Result.make
			Result.set_filter (<<"Project file (*.prb)", "All file (*.*)">>, <<"*.PRB", "*.*">>)
		ensure
			result_not_void: Result /= Void
		end

	closeable: BOOLEAN is
			-- Show the standard dialog box.
		local
			msg_box: WEL_MSG_BOX
		do
			!! msg_box.make
			msg_box.question_message_box (Current, "Do you want to exit?", "Exit")

			if msg_box.message_box_result = Idyes then
 				do_exit
			end
		end

	class_icon: WEL_ICON is
			-- Window's icon.
		once
			!! Result.make_by_id (1)
		end

	class_background: WEL_NULL_BRUSH is
		once
			!! Result.make
		end

	do_analyze (a_parent: WEL_COMPOSITE_WINDOW; a_open_file: WEL_OPEN_FILE_DIALOG) is
			-- Analyze a resource script `a_filename'.
		require
			a_open_file_exists: a_open_file /= Void
		local
			temp_file: PLAIN_TEXT_FILE
			temp_filename: STRING
			folder: DIRECTORY 
			preprocessor: PREPROCESSOR
			filename: STRING
			directory_name: STRING
		do
			!! cursor.make_by_predefined_id (Idc_wait)
			cursor.set

			!! folder.make (Tmp_directory)
			If (not folder.exists) then
				folder.create_dir
			end

			filename := clone (a_open_file.file_name)

				-- Prepare saving of current working directory
				-- and change to directory where file is opened from
			create directory_name.make (a_open_file.file_name_offset)
			directory_name.fill_blank
			directory_name.subcopy (filename, 1, a_open_file.file_name_offset - 3, 1)
			set_working_directory (directory_name)

			temp_filename := clone (Tmp_directory)
			temp_filename.append ("Temp_file.rc")
			!! temp_file.make_open_write (temp_filename)

			!! preprocessor.make (temp_file)
			preprocessor.convert (filename)
			temp_file.close

			set_define_table (preprocessor.define_table)
			set_has_error (false)

			analyzer.regenerate
			analyzer.parsing (temp_filename)

			if (properties_window /= Void) and then (properties_window.exists) then
				properties_window.destroy
			end

			if not has_error then
				filename.tail (filename.count - a_open_file.file_name_offset + 1)

				create_tree_view_control (client_window, filename)

--				!! properties_window.make_with_coordinates (client_window, "Properties Window",
--						tree_view.width -1, -2,
--						client_window.width - tree_view.width,
--						client_window.height)
--				client_window.set_properties_window (properties_window)
--				client_window.set_current_resource (Void)
			end		

			interface.hide_all
	
			!! cursor.make_by_predefined_id (Idc_arrow)
			cursor.set
		end

	do_open_project (a_parent: WEL_COMPOSITE_WINDOW; a_open_file: WEL_OPEN_FILE_DIALOG) is
		require
			a_open_file_exists: a_open_file /= Void
		local
			the_tds: TABLE_OF_SYMBOLS_STRUCTURE
			file: RAW_FILE
			filename: STRING
		do
			filename := clone (a_open_file.file_name)

			!! file.make_open_read (filename)
			!! the_tds.retrieve_tds (file)

			set_tds (the_tds)

			filename.tail (filename.count - a_open_file.file_name_offset + 1)
			create_tree_view_control (client_window, filename)

			if (properties_window /= Void) and then (properties_window.exists) then
				properties_window.destroy
			end
--			!! properties_window.make_with_coordinates (client_window, "Properties Window",
--					tree_view.width -1, -2,
--					client_window.width - tree_view.width,
--					client_window.height)
--			client_window.set_properties_window (properties_window)
--			client_window.set_current_resource (Void)

			interface.hide_all
		end

	do_save_project (a_filename: STRING) is
		require
			a_filename_exists: a_filename /= Void and then a_filename.count > 0
		local
			file: RAW_FILE
		do
			!! file.make_open_write (a_filename)
			tds.store_tds (file)
		end

	do_exit is
			-- Exit to application.
		do
			destroy		
		end

	create_analyzer (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create the resource analyzer.
		require
			analyzer_void: analyzer = Void
		local
			file: RAW_FILE
		do
			set_working_directory (current_working_directory)
			change_working_directory (application_directory)

			!! file.make (Grammar_name)

			if (file.exists) then
				!! file.make_open_read (Grammar_name)
				!! analyzer.retrieve_grammar (file)
			else
				!! analyzer.make
				!! file.make_open_write (Grammar_name)
				analyzer.store_grammar (file)
			end

			file.close

			interface.hide_all
			change_working_directory (working_directory)
		ensure
			analyzer_not_void: analyzer /= Void
		end

	create_tree_view_control (a_parent: WEL_COMPOSITE_WINDOW; a_filename: STRING) is
			-- Create the tree view control corresponding to the analyzed resource script `filename'.
		require
			a_filename_exists: a_filename /= Void and then a_filename.count > 0
		local
			tvis: WEL_TREE_VIEW_INSERT_STRUCT
			tv_item: WEL_TREE_VIEW_ITEM
		do
			interface.display_text (std_out, "Creating the tree view control...")

			if (tree_view /= Void) and then (tree_view.exists) then
				tree_view.destroy
			end

			!! tree_view.make (a_parent, -1, -1, 250, a_parent.height - 2, -1)

			!! tvis.make
			tvis.set_root
			!! tv_item.make
			tv_item.set_text (a_filename)
			tvis.set_tree_view_item (tv_item)
			tree_view.insert_item (tvis)

--			tds.generate_tree_view (tree_view)
 		ensure
			tree_view_exists: tree_view.exists
		end

	do_resource_file (a_filename: STRING) is
			-- Generate a resource file.
		require
			a_filename_exists: a_filename /= Void and then a_filename.count > 0
		local
			file: PLAIN_TEXT_FILE
		do
			!! file.make_open_write (a_filename)
			tds.generate_resource_file (file)	
			file.close		
		end

	do_about is
			-- Display the about dialog.
		local
			about: DIALOG_ABOUT
		do
			!! about.make (Current)
		end

	do_wel_code is
			-- Generate the wel code.
		local
			browse: DIALOG_BROWSE
		do
			!! browse.make (Current)
		end

end -- class MAIN_WINDOW
