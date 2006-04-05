indexing
	description: "Objects that represent a cut object command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_CUT_OBJECT_COMMAND
