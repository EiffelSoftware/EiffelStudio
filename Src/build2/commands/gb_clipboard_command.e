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
		end
		
feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		local
			object: GB_OBJECT
			component: GB_COMPONENT
		do
			object ?= system_status.pick_and_drop_pebble
			component ?= system_status.pick_and_drop_pebble
			Result := (not clipboard.is_empty) or (object /= Void) or (component /= Void)
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			local
				dialog: EV_DIALOG
				vertical_box: EV_VERTICAL_BOX
				text: EV_TEXT
				cancel_button: EV_BUTTON
				namespace: XM_NAMESPACE
				document: XM_DOCUMENT
				formater: XM_FORMATTER
				last_string: KL_STRING_OUTPUT_STREAM
				string: STRING
				window_object: GB_TITLED_WINDOW_OBJECT
				widget: EV_WIDGET
			do
				new_clipboard_object := clipboard.internal_object
				window_object ?= new_clipboard_object
				if window_object /= Void then
					widget ?= window_object.object.item
					window_object.object.wipe_out
					insert_into_window (widget, clipboard_dialog)	
				else
					insert_into_window (new_clipboard_object.object, clipboard_dialog)
				end
				clipboard_dialog.show_modal_to_window (main_window)
				
				if system_status.is_in_debug_mode then
					create namespace.make_default
					create document.make
					document.set_root_element (clipboard.contents_cell.item)
					create last_string.make ("")
					create formater.make
					formater.set_output (last_string)
					formater.process_document (document)

					create dialog
					dialog.set_minimum_size (400, 600)
					create vertical_box
					dialog.extend (vertical_box)
					create text
					vertical_box.extend (text)
					create cancel_button.make_with_text ("Cancel")
					vertical_box.extend (cancel_button)
					vertical_box.disable_item_expand (cancel_button)
					cancel_button.select_actions.extend (agent dialog.destroy)
					dialog.set_default_cancel_button (cancel_button)
					string := last_string.string
					process_xml_string (string)
					text.set_text (string)
					dialog.show_relative_to_window (main_window)
				end
			end
			
	close_dialog is
			-- Destroy `a_dialog' and 
		local
			all_children: ARRAYED_LIST [GB_OBJECT]
		do
			clipboard_dialog.hide
			create all_children.make (20)
			new_clipboard_object.all_children_recursive (all_children)
			all_children.extend (new_clipboard_object)
			from
				all_children.start
			until
				all_children.off
			loop
				all_children.item.destroy
				all_children.forth
			end
		end

	drop_object (an_object: GB_OBJECT) is
			-- Place representation of `an_object' within clipboard.
		require
			an_object_not_void: an_object /= Void
		local
			global_status: GB_GLOBAL_STATUS
		do
			create global_status
			global_status.block
			clipboard.set_object (an_object)
			global_status.resume
		end
		
	pick_object: GB_OBJECT is
				-- Execute `Current'.
			do
				Result := clipboard.object
			end
			
	new_clipboard_object: GB_OBJECT
			
	clipboard_dialog: EV_DIALOG is
			-- Dialog to display contents of `clipboard'.
		once
			create Result
			Result.set_title ("Clipboard Contents")
			Result.set_icon_pixmap (icon_clipboard @ 1)
			fake_cancel_button (Result, agent close_dialog)
		end
		

end -- class GB_CLIPBOARD_COMMAND
