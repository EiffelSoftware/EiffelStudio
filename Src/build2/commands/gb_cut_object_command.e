indexing
	description: "Objects that represent a cut object command."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CUT_OBJECT_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `a_components'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			components := a_components
			make
			set_tooltip ("Cut")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_cut)
			set_name ("Cut")
			set_menu_name ("Cut")
			disable_sensitive
			add_agent (agent execute)
			drop_agent := agent execute_with_object

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_x)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end

feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := (components.tools.layout_constructor.has_focus and components.tools.layout_constructor.selected_item /= Void) or
				(components.tools.widget_selector.has_focus and components.tools.widget_selector.selected_window /= Void)
		end

feature -- Basic operations

		execute is
				-- Execute `Current'.
			local
				command_delete: GB_DELETE_OBJECT_COMMAND
				layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				cut_object: GB_OBJECT
				selector_item: GB_WIDGET_SELECTOR_ITEM
			do
				if components.tools.layout_constructor.has_focus then
					layout_item ?= components.tools.layout_constructor.selected_item
					cut_object := layout_item.object
				else
					selector_item ?= components.tools.widget_selector.selected_window
					check
						selected_item_was_object: selector_item /= Void
					end
					cut_object := selector_item.object
				end
				components.clipboard.set_object (cut_object)

				create command_delete.make_with_components (components)
				command_delete.delete_object (cut_object)

				components.commands.update
			end

		execute_with_object (object_stone: GB_STANDARD_OBJECT_STONE) is
				-- Execute `Current' directly with object `object_stone'.
			require
				object_stone_not_void: object_stone /= Void
			local
				command_delete: GB_DELETE_OBJECT_COMMAND
			do
				components.clipboard.set_object (object_stone.object)

				create command_delete.make_with_components (components)
				command_delete.delete_object (object_stone.object)

				components.commands.update
			end

end -- class GB_CUT_OBJECT_COMMAND
