indexing
	description: "Objects that represent an object_editor command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			new_toolbar_item
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
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
			set_tooltip ("New object editor")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).Icon_object_editor)
			set_name ("New object editor")
			set_menu_name ("New object editor")
		end

feature -- Basic operations

		new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): GB_COMMAND_TOOL_BAR_BUTTON is
				-- Create a new toolbar item linked to `Current'. This has been redefined as each button
				-- needs to have its drop actions set.
			do
				Result := Precursor {GB_STANDARD_CMD} (display_text, use_gray_icons)
				Result.drop_actions.extend (agent update_object_editor (?, Result))
				Result.drop_actions.set_veto_pebble_function (agent do_not_allow_object_type (?))
				Result.select_actions.extend (agent show_usage_dialog)
			end

feature {NONE} -- Implementation

		do_not_allow_object_type (object_stone: GB_STANDARD_OBJECT_STONE): BOOLEAN is
				-- May `transported_object' be dropped on a toolbar button
			require
				object_stone_not_void: object_stone /= Void
				-- representation of `Current'.
			do
					-- If the object is not void, it means that
					-- we are not currently picking a type.
				if object_stone.object.object /= Void then
					Result := True
				end
			end

		update_object_editor (object_stone: GB_STANDARD_OBJECT_STONE; button: GB_COMMAND_TOOL_BAR_BUTTON) is
				-- If `button' is parented (at any level) in a GB_OBJECT_EDITOR then assign `object' to
				-- the parent object editor, otherwise create a new object_editor containing `object'.
			require
				object_stone_not_void: object_stone /= Void
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
						an_object_editor.set_object (object_stone.object)
						found := True
					end
					container ?= container.parent
				end
					-- If `button' was not parented at some level in a GB_OBJECT_EDITOR
					-- then we must generate a new object editor.
				if not found then
					components.object_editors.new_object_editor (object_stone.object)
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
				dialog.show_modal_to_window (components.tools.main_window)
			end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_OBJECT_EDITOR_COMMAND
