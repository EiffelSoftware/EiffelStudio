indexing
	description: "Objects that provide access to a GB_OBJECT_EDITOR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITORS

inherit

	GB_CONSTANTS
		export {NONE}
			all
		end

	GB_WIDGET_UTILITIES
		undefine
			copy, is_equal, default_create
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create docked_object_editor.make_with_components (components)
			create floating_object_editors.make (0)
		ensure
			docked_object_editors_not_void: docked_object_editor /= Void
			floating_object_editors_not_void: floating_object_editors /= Void
			components_set: components = a_components
		end

feature -- Implementation

	docked_object_editor: GB_OBJECT_EDITOR
			-- Tool for editing properties of widgets.
			-- Only one in system. This is contained in the main window.
			-- and is considered to be "docked".

	floating_object_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			-- Linked list of tools for editing properties of widgets.
			-- These are floating, and there is no limit on their number.
			-- These are considered to be "floating"

	all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR] is
			-- All object editors in system, floating and docked.
		do
			Result := floating_object_editors.twin
			Result.force (docked_object_editor)
		end

	update_editors_for_property_change (vision2_object: EV_ANY; property_type: STRING; calling_object_editor: GB_OBJECT_EDITOR) is
			-- For all editors referencing `vision2_object', update `property_type' attribute_editor.
			-- `property_type' is "GB_EV_SENSITIVE", "GB_EV_BUTTON" etc etc.
			-- Note that `vision2_object' is the first of GB_EV_ANY `Objects' which should correspond
			-- to the `object' of a GB_OBJECT. Editors do not know about the GB_OBJECT, just the
			-- real vision2 objects they must manipulate.
		local
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			local_item: GB_OBJECT_EDITOR
			cursor: CURSOR
		do
			local_all_editors := all_editors
			cursor := local_all_editors.cursor
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				local_item := local_all_editors.item
					-- We must only update the other editors referencing `vision2_object', not `calling_object_editor'.
					-- If `local_item' `object' is `Void' then the editor is empty, so there is nothing to do.
				if local_item /= calling_object_editor and then local_item.object /= Void and then local_item.object.object = vision2_object and not
					property_type.is_equal (Ev_widget_string) then
						-- We ignore when `Ev_widget_string' as we update them all below.
					local_item.replace_object_editor_item (property_type)
				end
					-- We must now update the minimum size displayed in all object editors, as a change to any properties
					-- may have adjusted the minimum size of an object. We perform this on all object editors, as if one holds
					-- a container, then its minimum size will be affected by its children. We are not smart enough to determine
					-- exactly which ones must be updated, and it is also a quick process.
				local_item.replace_object_editor_item (Ev_widget_string)

				local_all_editors.forth
			end
			local_all_editors.go_to (cursor)
		end

	update_editors_by_calling_feature (vision2_object: EV_ANY; calling_object_editor: GB_OBJECT_EDITOR; p: PROCEDURE [EV_ANY, TUPLE]) is
			-- For all editors referencing `vision2_object', update by calling `p' on the editor.
		local
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			local_item: GB_OBJECT_EDITOR
			cursor: CURSOR
		do
			local_all_editors := all_editors
			cursor := local_all_editors.cursor
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				local_item := local_all_editors.item
					-- We must only update the other editors referencing `vision2_object', not `calling_object_editor'.
					-- If `local_item' `object' is `Void' then the editor is empty, so there is nothing to do.
				if local_item /= calling_object_editor and then local_item.object /= Void and then local_item.object.object = vision2_object then
					--local_all_editors.item.update_event_selection_button_text
					p.call ([local_all_editors.item])
				end
				local_all_editors.forth
			end
			local_all_editors.go_to (cursor)
		end

	update_all_editors_by_calling_feature (vision2_object: EV_ANY; calling_object_editor: GB_OBJECT_EDITOR; p: PROCEDURE [EV_ANY, TUPLE]) is
			-- For all editors, update by calling `p' on the editor.
		local
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			local_item: GB_OBJECT_EDITOR
			cursor: CURSOR
		do
			local_all_editors := all_editors
			cursor := local_all_editors.cursor
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				local_item := local_all_editors.item
					-- We must only update the other editors referencing `vision2_object', not `calling_object_editor'.
					-- If `local_item' `object' is `Void' then the editor is empty, so there is nothing to do.
				if local_item /= calling_object_editor and then local_item.object /= Void then
					--local_all_editors.item.update_event_selection_button_text
					p.call ([local_all_editors.item])
				end
				local_all_editors.forth
			end
			local_all_editors.go_to (cursor)
		end

	rebuild_associated_editors (object_id: INTEGER) is
			-- For all editors referencing an object with id `object_id', rebuild any associated object editors.
		local
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			local_item: GB_OBJECT_EDITOR
			an_object: GB_OBJECT
			locked_in_here: BOOLEAN
			current_parent_window: EV_WINDOW
			cursor: CURSOR
		do
			local_all_editors := all_editors
			cursor := local_all_editors.cursor
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				local_item := local_all_editors.item
					-- We must only update the other editors referencing `vision2_object', not `calling_object_editor'.
					-- If `local_item' `object' is `Void' then the editor is empty, so there is nothing to do.
				if local_item.object /= Void and then local_item.object.id = object_id then
					an_object ?= local_all_editors.item.object
					current_parent_window := local_all_editors.item.parent_window (local_all_editors.item)
					if current_parent_window /= Void and (application.locked_window = Void) then
						locked_in_here := True
						current_parent_window.lock_update
					end
					local_all_editors.item.make_empty
					local_all_editors.item.set_object (an_object)
					if current_parent_window /= Void and locked_in_here then
						current_parent_window.unlock_update
					end
				end
				local_all_editors.forth
			end
			local_all_editors.go_to (cursor)
		end

	destroy_floating_editors is
			-- For evey item in `floating_object_editors',
			-- remove and destroy.
		local
			a_window_parent: EV_WINDOW
		do
			from
				floating_object_editors.start
			until
				floating_object_editors.off
			loop
				a_window_parent := floating_object_editors.item.parent_window (floating_object_editors.item)
				check
					a_window_parent_not_void: a_window_parent /= Void
				end
				floating_object_editors.item.destroy
				a_window_parent.destroy
				floating_object_editors.remove
			end
		ensure
			no_floating_editors: floating_object_editors.is_empty
		end

	flush_all is
			-- For every item in `floating_object_editors', flush their
			-- contents so that any objects that have been deleted are
			-- no longer targeted.
		local
			current_editor: GB_OBJECT_EDITOR
		do
			docked_object_editor.flush
			from
				floating_object_editors.start
			until
				floating_object_editors.off
			loop
				current_editor := floating_object_editors.item
				current_editor.flush
				if current_editor.object = Void then
					remove_floating_object_editor (parent_window (current_editor))
					parent_window (current_editor).destroy
				else
						-- Only step through the iteration if we have not just removed
						-- the item.
					floating_object_editors.forth
				end
			end
		end

	force_name_change_completion_on_all_editors is
			-- Force all object editors that are editing an object
			-- to update their object to use either the newly enterd name
			-- if valid, or to revert to their old name if not valid.
			-- We need this, so that when save is clicked, during an
			-- renaming, we can take into account the current name.
		local
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			cursor: CURSOR
		do
			local_all_editors := all_editors
			cursor := local_all_editors.cursor
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				if local_all_editors.item.has_object then
					local_all_editors.item.end_name_change_on_object
				end
				local_all_editors.forth
			end
			local_all_editors.go_to (cursor)
		end

	new_object_editor_empty is
			-- Generate a new empty object editor.
		local
			window: EV_TITLED_WINDOW
			editor: GB_OBJECT_EDITOR
		do
			create window
			window.close_request_actions.extend (agent remove_floating_object_editor (window))
			window.close_request_actions.extend (agent window.destroy)
			create editor.make_with_components (components)
			window.extend (editor)
			floating_object_editors.extend (editor)
			window.show
		end

	new_object_editor (object: GB_OBJECT) is
			-- Generate a new object editor containing `object'.
		local
			object_editor_window: GB_FLOATING_OBJECT_EDITOR_WINDOW
			editor: GB_OBJECT_EDITOR
			button: EV_BUTTON
		do
			create object_editor_window.make_with_components (components)
				-- We must now temporarily create a new button, and add it to `Current'
				-- as the default cancel button. We then remove it. This is necessary so
				-- that we have access to the minimize, maximize and close buttons.
				-- Note that we have custom implementations of EV_DIALOG_IMP, in order to
				-- fire these actions when the button is not visible.
			create button
			object_editor_window.extend (button)
			button.select_actions.extend (agent remove_floating_object_editor (object_editor_window))
			button.select_actions.extend (agent object_editor_window.destroy)

			object_editor_window.set_default_cancel_button (button)
			object_editor_window.prune_all (button)

			object_editor_window.set_height (Default_floating_object_editor_height)
			create editor.make_with_components (components)
			object_editor_window.extend (editor)
			floating_object_editors.extend (editor)
			editor.set_object (object)
			if components.system_status.tools_always_on_top then
				object_editor_window.show_relative_to_window (components.tools.main_window)
				object_editor_window.set_default_icon
			else
				object_editor_window.show
				object_editor_window.restore_icon
			end
		end

feature {NONE} -- Implementation

	remove_floating_object_editor (a_window: EV_WINDOW) is
			-- Remove object editor contained in `a_window'
			-- from `floating_object_editors'.
		require
			a_window_not_void: a_window /= Void
			-- Object editor is in floating object editors.

		local
			editor: GB_OBJECT_EDITOR
			cursor: CURSOR
		do
			editor ?= a_window.item
			check
				editor /= Void
			end
			cursor := floating_object_editors.cursor
			floating_object_editors.prune_all (editor)
			floating_object_editors.go_to (cursor)
		ensure
			-- Object editor is not in floating object editors.
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


end -- class GB_ACCESSIBLE_OBJECT_EDITOR
