indexing
	description: "Objects that represent an object_editor command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make,
			new_toolbar_item
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_PIXMAPS
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
			set_tooltip ("New object editor")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).Icon_object_editor)
			set_name ("New object editor")
			set_menu_name ("New object editor")
		end
		
feature -- Basic operations

		new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
				-- Create a new toolbar item linked to `Current'. This has been redefined as each button
				-- needs to have its drop actions set.
			do
				Result := Precursor {EB_STANDARD_CMD} (display_text, use_gray_icons)
				Result.drop_actions.extend (agent update_object_editor (?, Result))
				Result.drop_actions.set_veto_pebble_function (agent do_not_allow_object_type (?))
				Result.select_actions.extend (agent show_usage_dialog)
			end
			
feature {NONE} -- Implementation

		do_not_allow_object_type (transported_object: GB_OBJECT): BOOLEAN is
				-- May `transported_object' be dropped on a toolbar button
				-- representation of `Current'.
			do
					-- If the object is not void, it means that
					-- we are not currently picking a type.
				if transported_object.object /= Void then
					Result := True
				end
			end
			
		update_object_editor (an_object: GB_OBJECT; button: EB_COMMAND_TOOL_BAR_BUTTON) is
				-- If `button' is parented (at any level) in a GB_OBJECT_EDITOR then assign `object' to
				-- the parent object editor, otherwise create a new object_editor containing `object'.
			require
				an_object_not_void: an_object /= Void
				button_not_void: button /= Void
				button_parented: button.parent /= Void
				button_tool_bar_parented: button.parent.parent /= Void
			local
				container: EV_CONTAINER
				an_object_editor: GB_OBJECT_EDITOR
				tool_bar: EV_TOOL_BAR
				found: BOOLEAN
			do
				tool_bar := button.parent
				from
					container ?= tool_bar.parent
				until
					container = Void or found
				loop
					an_object_editor ?= container
					if an_object_editor /= Void then
						an_object_editor.set_object (an_object)
						found := True
					end
					container ?= container.parent
				end
					-- If `button' was not parented at some level in a GB_OBJECT_EDITOR
					-- then we must generate a new object editor.
				if not found then
					new_object_editor (an_object)
				end
			end
			
		show_usage_dialog is
				-- Show an information dialog explaining usagre
				-- of the button.
			local
				dialog: EV_INFORMATION_DIALOG
			do
				create dialog.make_with_text (Object_editor_button_warning)
				dialog.set_icon_pixmap (Icon_build_window @ 1)
				dialog.show_modal_to_window (main_window)
			end

end -- class GB_OBJECT_EDITOR_COMMAND
