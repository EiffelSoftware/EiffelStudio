indexing
	description: "Builds an attribute editor for modification of objects of type EV_NOTEBOOK."
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
			name_field: EV_TEXT_FIELD
		do
			create Result
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
			from
				first.start
			until
				first.off
			loop
				create name_field.make_with_text (first.item_text (first.item))
				name_field.change_actions.extend (agent change_item_text (name_field, first.index))
				Result.extend (name_field)
				first.forth
			end

			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
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
		end

feature {NONE} -- Implementation

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			for_all_objects (agent {EV_NOTEBOOK}.set_tab_position (position_from_text (combo_box.selected_item.text)))
		end

	change_item_text (text_field: EV_TEXT_FIELD; index: INTEGER) is
			-- Modify representations of EV_NOTEBOOK to reflect a text change
			-- on layout item `index'. We cannot use `for_all_objects' as
			-- we need to get access to the real widget in each representation
			-- so doing it this way is easier.
		do
			first.set_item_text (first.i_th (index), text_field.text)
			(objects @ 2).set_item_text ((objects @ 2).i_th (index), text_field.text)
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

	combo_box: EV_COMBO_BOX
		-- Holds possible tab positions.
		
	Ev_tab_left_string: STRING is "Left"
	Ev_tab_right_string: STRING is "Right"
	Ev_tab_top_string: STRING is "Top"
	Ev_tab_bottom_string: STRING is "Bottom"
		-- String constants used for different tab_positions
	
	Tab_position_string: STRING is "Tab_position"
		-- String used to represent the tab position in the XML.
	Item_text_string: STRING is "Item_text"
		-- String used to represent the texts of the tabs in the XML.
	
	separator_char: CHARACTER is '^'
	
	top_item, bottom_item, left_item, right_item: EV_LIST_ITEM
		-- Selctions for combo box.

end -- class GB_EV_NOTEBOOK_EDITOR_CONSTRUCTOR
