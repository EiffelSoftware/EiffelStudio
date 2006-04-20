indexing
	description: "Builds an attribute editor for modification of objects of type EV_NOTEBOOK."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_NOTEBOOK_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_NOTEBOOK
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_NOTEBOOK"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_notebook_tab_position)
			label.set_tooltip (gb_ev_notebook_tab_position_tooltip)
			Result.extend (label)
			create combo_box
			combo_box.set_tooltip (gb_ev_notebook_tab_position_tooltip)
			Result.extend (combo_box)
			combo_box.disable_edit
			create top_item.make_with_text (Ev_tab_top_string)
			combo_box.extend (top_item)
			create bottom_item.make_with_text (Ev_tab_bottom_string)
			combo_box.extend (bottom_item)
			create right_item.make_with_text (Ev_tab_right_string)
			combo_box.extend (right_item)
			create left_item.make_with_text (Ev_tab_left_string)
			combo_box.extend (left_item)
			combo_box.select_actions.extend (agent selection_changed)
			combo_box.select_actions.extend (agent update_editors)
			
			if not first.is_empty then
				create label.make_with_text ("Item texts:")
				Result.extend (label)
			end
			create text_entries.make (4)
			from
				first.start
			until
				first.off
			loop
				create text_entry.make (Current, Result, item_text_string + first.index.out, Gb_ev_textable_text + first.index.out, Gb_ev_textable_text_tooltip,
				agent set_text (?, first.index), agent validate_true (?), single_line_entry, components)
				text_entry.hide_label
				text_entries.extend (text_entry)
				first.forth
			end
			if not first.is_empty then
				create label.make_with_text ("Item pixmaps:")
				Result.extend (label)
			end
			create pixmap_entries.make (4)
			from
				first.start
			until
				first.off
			loop
				create pixmap_entry.make (Current, Result, Item_pixmap_string + first.index.out, "", "Pixmap", agent set_pixmap (?, ?, first.index), agent validate (?, ?), agent return_pixmap (first.index), agent return_pixmap_path (first.index), components)
				pixmap_entries.extend (pixmap_entry)
				first.forth
			end
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		local
			notebook_tab: EV_NOTEBOOK_TAB
		do
			combo_box.select_actions.block
			if first.tab_position = first.tab_top then
				top_item.enable_select
			elseif first.tab_position = first.tab_bottom then
				bottom_item.enable_select
			elseif first.tab_position = first.tab_right then
				right_item.enable_select
			elseif first.tab_position = first.tab_left then
				left_item.enable_select
			end
			combo_box.select_actions.resume
			from
				text_entries.start
			until
				text_entries.off
			loop
				text_entries.item.update_constant_display (first.item_text (first.i_th (text_entries.index)))
				text_entries.forth
			end
			from
				pixmap_entries.start
			until
				pixmap_entries.off
			loop
				notebook_tab := first.item_tab (first.i_th (pixmap_entries.index))
				pixmap_entries.item.update_constant_display (notebook_tab.pixmap)
				pixmap_entries.forth
			end
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		local
			counter: INTEGER
		do
				-- When using constants for notebook items, the validation agents need to be dynamic.
				-- Unfortunately, the mechanism is not currently set up in this fashion.
				-- Therefore we add 32 agents, to cover handling of notebooks with up to 32 items.
				-- If more items are contained, and a user changes a constant value used as
				-- a notebook item text for an index greater than 32, EiffelBuild will crash.
				-- This is extremely unlikely although a better solution needs to be found.
			from
				counter := 1
			until
				counter > 32
			loop
				validate_agents.put (agent validate_true (?), item_text_string + counter.out)
				execution_agents.put (agent set_text (?, counter), item_text_string + counter.out)
				execution_agents.put (agent set_pixmap (?, ?,  counter), Item_pixmap_string + counter.out)
				counter := counter + 1
			end
		end
		
	validate (a_pixmap: EV_PIXMAP; pixmap_path: STRING): BOOLEAN is
			-- Validate pixmap `a_pixmap' with path `pixmap_path'.
		do
			--| No validation is currently performed on pixmaps, so return True
			Result := True
		end
		
	return_pixmap (index: INTEGER): EV_PIXMAP is
			-- `Result' is pixmap used for `Current'.
		require
			index_valid: index <= objects.first.count
		local
			notebook_tab: EV_NOTEBOOK_TAB
		do
			notebook_tab := objects.first.item_tab (objects.first.i_th (index))
			Result := notebook_tab.pixmap
		end
		
	return_pixmap_path (index: INTEGER): STRING is
			-- `Result' is path used to retrieve pixmap.
		do
			Result := objects.first.pixmap_paths.item (index)
		end

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			for_all_objects (agent {EV_NOTEBOOK}.set_tab_position (position_from_text (combo_box.selected_item.text)))
		end

	set_text (a_string: STRING; index: INTEGER) is
			-- Set `a_string' as item text of notebook item indexed by `index'.
		do
			actual_set_text (object, a_string, index)
			for_all_instance_referers (object, agent actual_set_text (?, a_string, index))
			enable_project_modified
		end
		
	actual_set_text (an_object: GB_OBJECT; a_string: STRING; index: INTEGER) is
			-- Perform setting of `a_string' to notebook tab `index' for all
			-- representations of `an_object'.
		require
			object_not_void: an_object /= Void
			string_not_void: a_string /= Void
			index_valid: an_object.children /= Void implies index >= 1 and index <= an_object.children.count
		local
			notebook: EV_NOTEBOOK
		do
			notebook ?= an_object.object
			check
				object_was_notebook: notebook /= Void
			end
			notebook.set_item_text (notebook.i_th (index), a_string)
			notebook ?= an_object.real_display_object
			if notebook /= Void then
				check
					object_was_notebook: notebook /= Void
				end
				notebook.set_item_text (notebook.i_th (index), a_string)
			end
		end	

	set_pixmap (a_pixmap: EV_PIXMAP; path: STRING; index: INTEGER) is
			-- Set `a_pixmap' to notebook tab of item indexed by `index' within notebook.
			-- If `a_pixmap' is Void, remove the pixmap.
		do
			actual_set_pixmap (object, a_pixmap, path, index)
			for_all_instance_referers (object, agent actual_set_pixmap (?, a_pixmap, path, index))
			enable_project_modified
		end
		
	actual_set_pixmap (an_object: GB_OBJECT; a_pixmap: EV_PIXMAP; path: STRING; index: INTEGER) is
			-- Set `a_pixmap' to notebook tab for `an_object' of item indexed by `index' within notebook.
			-- If `a_pixmap' is Void, remove the pixmap.
		require
			an_object_not_void: an_object /= Void
			index_valid: an_object.children /= Void implies index >= 1 and index <= an_object.children.count
		local
			notebook_tab: EV_NOTEBOOK_TAB
			notebook: EV_NOTEBOOK
		do
			notebook ?= an_object.object
			check
				object_was_notebook: 
			end
			notebook_tab := notebook.item_tab (notebook.i_th (index))
			if path /= Void then
				notebook.pixmap_paths.put (path, index)
			else
				notebook.pixmap_paths.remove (index)
			end
			if a_pixmap /= Void then
				notebook_tab.set_pixmap (a_pixmap)
			else
				notebook_tab.remove_pixmap
			end
			notebook ?= an_object.real_display_object
			if notebook /= Void then
				check
					object_was_notebook: notebook /= Void
				end
				notebook_tab := notebook.item_tab (notebook.i_th (index))
				if path /= Void then
					notebook.pixmap_paths.put (path, index)
				else
					notebook.pixmap_paths.remove (index)
				end
				if a_pixmap /= Void then
					notebook_tab.set_pixmap (a_pixmap)
				else
					notebook_tab.remove_pixmap
				end
			end
			enable_project_modified
		end
		
		
	names_from_string (a_string: STRING): ARRAYED_LIST [STRING] is
			-- `Result' is all tab names encoded in `a_string'.
			-- each is separated by `separator_char'.
		local
			pos, last_pos: INTEGER
			item_position: INTEGER
			looped_already: BOOLEAN
		do
			create Result.make (0)
			from
				pos := 1
				item_position := 1
			until
				pos = a_string.count + 1
			loop
				if looped_already then
					last_pos := pos + 1
				else
					last_pos := 1
				end
			
				pos := a_string.index_of (separator_char, last_pos)
					-- This handles the last case.
				if pos = 0  then
					pos := a_string.count + 1
				end
				Result.extend (a_string.substring (last_pos, pos - 1))
				item_position := item_position + 1
				looped_already := True
			end
		end

	position_from_text (text: STRING): INTEGER is
			-- `Result' is integer value corresponding
			-- to `text' tab style. i.e. "Ev_tab_left_string".
		do
			if text.is_equal (Ev_tab_top_string) then
				Result := first.Tab_top
			elseif text.is_equal (Ev_tab_bottom_string) then
				Result := first.Tab_bottom
			elseif text.is_equal (Ev_tab_right_string) then
				Result := first.Tab_right
			elseif text.is_equal (Ev_tab_left_string) then
				Result := first.Tab_left
			else
				check
					False
				end
			end
		end
		
	text_entries: ARRAYED_LIST [GB_STRING_INPUT_FIELD]
		-- All text entries created to permit entry of item texts.
		
	pixmap_entries: ARRAYED_LIST [GB_PIXMAP_INPUT_FIELD]
		-- All pixmap entries created to permit entry of item texts.
		
	combo_box: EV_COMBO_BOX
		-- Holds possible tab positions.
		
	Ev_tab_left_string: STRING is "Left"
	Ev_tab_right_string: STRING is "Right"
	Ev_tab_top_string: STRING is "Top"
	Ev_tab_bottom_string: STRING is "Bottom"
		-- String constants used for different tab_positions
	
	Tab_position_string: STRING is "Tab_position"
		-- String used to represent the tab position in the XML.
		
	Item_text_string_new: STRING is "Item_texts"
		-- String used to represent the parent node for the texts in the XML.
		-- This has been added to permit the item texts of notebooks to
		-- support constants.
		
	Item_pixmap_string_new: STRING is "Item_pixmaps"
		-- String used to represent the parent node for the pixmaps in the XML.
		-- This has been added to permit the tab pixmaps of notebooks to
		-- support constants.
	
	separator_char: CHARACTER is '^'
	
	top_item, bottom_item, left_item, right_item: EV_LIST_ITEM
		-- Selctions for combo box.
		
	text_entry: GB_STRING_INPUT_FIELD
		-- Input field for text.
		
	pixmap_entry: GB_PIXMAP_INPUT_FIELD;
		-- Input field for pixmap.

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


end -- class GB_EV_NOTEBOOK_EDITOR_CONSTRUCTOR
