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

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
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
		do
			Result := not clipboard.is_empty
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			local
				layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				cut_object: GB_OBJECT
				global_status: GB_GLOBAL_STATUS
				dialog: EV_DIALOG
				vertical_box: EV_VERTICAL_BOX
				text: EV_TEXT
				cancel_button: EV_BUTTON
				application_element, window_element,
				new_type_element: XM_ELEMENT
				namespace: XM_NAMESPACE
				constants_list: HASH_TABLE [GB_CONSTANT, STRING]
				document: XM_DOCUMENT
				formater: XM_FORMATTER
				last_string: KL_STRING_OUTPUT_STREAM
				string: STRING
			do
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
				dialog.show_modal_to_window (main_window)
			end
			
	drop_object (an_object: GB_OBJECT) is
			-- Place representation of `an_object' within clipboard.
		require
			an_object_not_void: an_object /= Void
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			cut_object: GB_OBJECT
			global_status: GB_GLOBAL_STATUS
		do
			create global_status
			global_status.block
			clipboard.set_object (an_object)
			global_status.resume
		end
		
	pick_object: GB_OBJECT is
				-- Execute `Current'.
			local
				layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				cut_object: GB_OBJECT
				global_status: GB_GLOBAL_STATUS
				layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				command_add: GB_COMMAND_ADD_OBJECT
				parent_object: GB_PARENT_OBJECT
			do
				Result := clipboard.object
			end

end -- class GB_CLIPBOARD_COMMAND
