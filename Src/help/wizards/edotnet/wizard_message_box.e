indexing
	description: "Message box displayed while importing local assemblies"

class
	WIZARD_MESSAGE_BOX

inherit
	WIZARD_PROJECT_SHARED
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make (a_title: like message_dialog_title; a_window: like parent_window) is
			-- Set `message_dialog_title' with `a_title'.
			-- Set `parent_window' with `a_window'.
			-- Display the message box.
		require	
			non_void_message_dialog_title: a_title /= Void 
			not_empty_message_dialog_title: not a_title.is_empty
			non_void_parent_window: a_window /= Void
		do
			message_dialog_title := a_title
			parent_window := a_window
			display
		ensure
			message_dialog_title_set: message_dialog_title.is_equal (a_title)
			parent_window_set: parent_window = a_window
		end
	
	display is
			-- Display the message box.
		do
			build
		end

feature -- Access

	message_dialog: EV_DIALOG
			-- Message dialog displayed while importing the selected local assembly
	
	message_dialog_title: STRING
			-- `message_dialog' title
		
	parent_window: EV_WINDOW
			-- Message box parent window
			
	Launching_message: STRING is "This may take a few seconds. Please be patient..."
			-- Message displayed while importing the selected local assembly
			
feature {NONE} -- Implementation

	build is
			-- Build the message box and display a message while importing the selected local assembly.
		local
			vbox: EV_VERTICAL_BOX
			pixmap_cell, space: EV_CELL
			text_box, progress_box: EV_HORIZONTAL_BOX
			label: EV_LABEL			
			dotnet_wizard_pixmap: EV_PIXMAP
			progress_pixmap: EV_PIXMAP
			close_button: EV_BUTTON
			cursor_pixmap: EV_STOCK_PIXMAPS
		do		
			create message_dialog
			message_dialog.set_title (message_dialog_title)
			message_dialog.disable_user_resize
			create dotnet_wizard_pixmap
			dotnet_wizard_pixmap.set_with_named_file (Pixmap_icon_location)
			message_dialog.set_icon_pixmap (dotnet_wizard_pixmap)

				-- Create the progress pixmap.			
			create pixmap_cell
			pixmap_cell.set_minimum_width (Cell_width)
			create progress_pixmap
			progress_pixmap.set_with_named_file (Watch_pixmap_location)
			pixmap_cell.extend (progress_pixmap)

				-- Create the label.
			create label
			label.align_text_left
			label.set_text (Launching_message)
			create space
			space.set_minimum_width (Small_cell_width)

			create text_box
			text_box.set_border_width (Border_width)
			text_box.set_padding (Padding)
			text_box.set_minimum_height (progress_pixmap.height + Label_height)
			text_box.extend (label)
			text_box.extend (space)
			text_box.extend (pixmap_cell)
			text_box.disable_item_expand (label)
			text_box.disable_item_expand (space)
			text_box.disable_item_expand (pixmap_cell)

				-- Progress bar & button.
			create progress_box
			progress_box.set_border_width (Border_width)
			progress_box.set_padding (Padding)
			create close_button.make_with_text (interface_names.b_Close)
			close_button.set_minimum_width (Button_width)
			close_button.select_actions.extend (~on_close)
			progress_box.extend (create {EV_CELL})
			progress_box.extend (close_button)
			progress_box.disable_item_expand (close_button)
			progress_box.extend (create {EV_CELL})

				-- Set up dialog
			create vbox
			vbox.extend (text_box)
			vbox.extend (progress_box)
			message_dialog.extend (vbox)

				-- Set Push & Close button.
			message_dialog.set_default_push_button (close_button)
			message_dialog.set_default_cancel_button (close_button)
			
		--	message_dialog.close_request_actions.extend (~on_close)
	--		message_dialog.show_modal_to_window (parent_window)			
			message_dialog.show
			create cursor_pixmap
			message_dialog.set_pointer_style (cursor_pixmap.Standard_cursor)
		end

	Pixmap_icon_location: STRING is 
			-- Location of ISE Assembly Manager icon
		once
			Result := clone (Eiffel_installation_dir_name)
			Result.append (Pixmap_icon_location_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: not Result.is_empty
		end
	
	Pixmap_icon_location_relative_filename: STRING is "\bench\wizards\new_projects\dotnet\pixmaps\wizard.png"
			-- Location of .NET Wizard icon (relatively to Eiffel delivery)
	
	Watch_pixmap_location: STRING is 
			-- Location of wait pixmap
		once
			Result := clone (Eiffel_installation_dir_name)
			Result.append (Pixmap_location_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: not Result.is_empty
		end
	
	Pixmap_location_relative_filename: STRING is "\bench\wizards\new_projects\dotnet\pixmaps\icon_watch_color.ico"
			-- Location of ISE Assembly Manager icon (relatively to Eiffel delivery)

	on_close is
			-- Closes `message_dialog'.
		require
			non_void_message_dialog: message_dialog /= Void
		do
			message_dialog.destroy
		ensure
			dialog_destroyed: message_dialog.is_destroyed
		end
		
	Cell_width: INTEGER is 34
			-- Width of cell containing the watch pixmap
	
	Border_width: INTEGER is 7
			-- Box border width
	
	Padding: INTEGER is 7
			-- Padding
	
	Button_width: INTEGER is 65
			-- Close button width
	
	Small_cell_width: INTEGER is 7
			-- Width of small cell
	
	Label_height: INTEGER is 15
			-- Label height

end -- class WIZARD_MESSAGE_BOX