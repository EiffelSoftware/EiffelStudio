indexing
	description: "Objects that represent a clipboard command."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLIPBOARD_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_SHARED_TOOLS
		export
			{ANY} layout_constructor
			{NONE} all
		end
		
	GB_SHARED_CLIPBOAD
		export
			{NONE} all
		end
		
	GB_XML_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Clipboard")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_clipboard)
			set_name ("Clipboard")
			set_menu_name ("Clipboard")
			disable_sensitive
			add_agent (agent execute)
			drop_agent := agent drop_object
			pebble_function := agent pick_object
			
				-- Set properties of `clipboard_dialog'.
			clipboard_dialog.set_title ("Clipboard Contents")
			clipboard_dialog.set_icon_pixmap (icon_clipboard @ 1)
			fake_cancel_button (clipboard_dialog, agent close_dialog)
			
				-- Register for notification when contents of clipboard change.
			clipboard.content_change_actions.extend (agent contents_changed)
		end
		
feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		local
			object_stone: GB_OBJECT_STONE
		do
			object_stone ?= system_status.pick_and_drop_pebble
			Result := (not clipboard.is_empty) or (object_stone /= Void)
		end

feature -- Basic operations

	clipboard_dialog_up_to_date: BOOLEAN
		-- Are the contents of `clipboard_dialog' up to date with the clipboard?
		-- If not, then they must be rebuilt.

	contents_changed is
			-- Respond to the changing of the clipboard contents.
		do
			clipboard_dialog_up_to_date := False
			if clipboard_dialog.is_show_requested then
					-- Only rebuild contents of `clipboard_dialog' if it is shown,
					-- otherwise wait until it is displayed.
				update_clipboard_dialog
			end
		end

	update_clipboard_dialog is
			-- Update `clipboard_dialog' with a representation of
			-- the clipboard contents.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
			widget: EV_WIDGET
			menu_bar: EV_MENU_BAR
			all_children: ARRAYED_LIST [GB_OBJECT]
		do
			(create {GB_GLOBAL_STATUS}).block
			if last_clipboard_object /= Void then
					-- Destroy the previous clipboard objects if any.
				create all_children.make (20)
				last_clipboard_object.all_children_recursive (all_children)
				all_children.extend (last_clipboard_object)
				from
					all_children.start
				until
					all_children.off
				loop
					all_children.item.destroy
					all_children.forth
				end
			end
		
				-- Store the new object into `last_clipboard_object' for future deletion.
			last_clipboard_object := clipboard.internal_object
			window_object ?= last_clipboard_object
			if window_object /= Void then
				widget := window_object.object.item
				window_object.object.wipe_out
				insert_into_window (widget, clipboard_dialog)
				menu_bar := window_object.object.menu_bar
				if menu_bar /= Void then
					window_object.object.remove_menu_bar
					insert_into_window (menu_bar, clipboard_dialog)
				end
			else
				insert_into_window (last_clipboard_object.object, clipboard_dialog)
			end
			
				-- Flag `clipboard_dialog' as up to date.
			clipboard_dialog_up_to_date := True
			(create {GB_GLOBAL_STATUS}).resume
		end	
	
	execute is
			-- Execute `Current'.
		do
			if not clipboard_dialog.is_show_requested then
				if not clipboard_dialog_up_to_date then
					update_clipboard_dialog
				end
				clipboard_dialog.set_size (clipboard_dialog.minimum_width, clipboard_dialog.minimum_height)
				clipboard_dialog.show_relative_to_window (main_window)
			end
			
			if system_status.is_in_debug_mode then
				show_element (clipboard.contents_cell.item, main_window)
			end
		end
			
	close_dialog is
			-- hide `clipboard_dialog'.
		do
			clipboard_dialog.hide
		ensure
			dialog_not_shown: not clipboard_dialog.is_displayed
		end

	drop_object (object_stone: GB_OBJECT_STONE) is
			-- Place representation of `an_object' within clipboard.
		require
			object_stone_not_void: object_stone /= Void
		local
			global_status: GB_GLOBAL_STATUS
		do
			create global_status
			global_status.block
			clipboard.set_object (object_stone.object)
			global_status.resume
		end
		
	pick_object: GB_CLIPBOARD_OBJECT_STONE is
				-- Execute `Current'.
			local
				contents: XM_ELEMENT
				element_info: ELEMENT_INFORMATION
				full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			do
				check
					clipboard_not_empty: clipboard.contents_cell.item /= Void
				end
				create Result
				
					-- Now determine if the top level object is an instance of another
					-- object and if so, set the associated object for `Result'.
				contents ?= clipboard.contents_cell.item.first
				contents ?= child_element_by_name (contents, internal_properties_string)
				full_information := get_unique_full_info (contents)
				element_info := full_information @ (reference_id_string)
				if element_info /= Void then
					Result.set_associated_top_level_object (element_info.data.to_integer)
				end
			end
			
	last_clipboard_object: GB_OBJECT
		-- Last clipboard object built into the `clipboard_dialog'.

end -- class GB_CLIPBOARD_COMMAND
