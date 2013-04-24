note
	description: "Wrapper for NSComboBox."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMBO_BOX

inherit
	NS_TEXT_FIELD
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_COMBO_BOX_API}.new)
			init_delegate
		end

feature

	has_vertical_scroller: BOOLEAN
		do
			Result := {NS_COMBO_BOX_API}.has_vertical_scroller (item)
		end

	set_has_vertical_scroller (a_flag: BOOLEAN)
		do
			{NS_COMBO_BOX_API}.set_has_vertical_scroller (item, a_flag)
		end

	intercell_spacing: NS_SIZE
		do
			create Result.make
			{NS_COMBO_BOX_API}.intercell_spacing (item, Result.item)
		end

	set_intercell_spacing (a_size: NS_SIZE)
		do
			{NS_COMBO_BOX_API}.set_intercell_spacing (item, a_size.item)
		end

	item_height: REAL
		do
			Result := {NS_COMBO_BOX_API}.item_height (item)
		end

	set_item_height (a_item_height: REAL)
		do
			{NS_COMBO_BOX_API}.set_item_height (item, a_item_height)
		end

	number_of_visible_items: INTEGER
		do
			Result := {NS_COMBO_BOX_API}.number_of_visible_items (item)
		end

	set_number_of_visible_items (a_visible_items: INTEGER)
		do
			{NS_COMBO_BOX_API}.set_number_of_visible_items (item, a_visible_items)
		end

	set_button_bordered (a_flag: BOOLEAN)
		do
			{NS_COMBO_BOX_API}.set_button_bordered (item, a_flag)
		end

	is_button_bordered: BOOLEAN
		do
			Result := {NS_COMBO_BOX_API}.is_button_bordered (item)
		end

	reload_data
		do
			{NS_COMBO_BOX_API}.reload_data (item)
		end

	note_number_of_items_changed
		do
			{NS_COMBO_BOX_API}.note_number_of_items_changed (item)
		end

	set_uses_data_source (a_flag: BOOLEAN)
		do
			{NS_COMBO_BOX_API}.set_uses_data_source (item, a_flag)
		end

	uses_data_source: BOOLEAN
		do
			Result := {NS_COMBO_BOX_API}.uses_data_source (item)
		end

	scroll_item_at_index_to_top (a_index: INTEGER)
		do
			{NS_COMBO_BOX_API}.scroll_item_at_index_to_top (item, a_index)
		end

	scroll_item_at_index_to_visible (a_index: INTEGER)
		do
			{NS_COMBO_BOX_API}.scroll_item_at_index_to_visible (item, a_index)
		end

	select_item_at_index (a_index: INTEGER)
		do
			{NS_COMBO_BOX_API}.select_item_at_index (item, a_index)
		end

	deselect_item_at_index (a_index: INTEGER)
		do
			{NS_COMBO_BOX_API}.deselect_item_at_index (item, a_index)
		end

	index_of_selected_item: INTEGER
		do
			Result := {NS_COMBO_BOX_API}.index_of_selected_item (item)
		end

	number_of_items: INTEGER
		do
			Result := {NS_COMBO_BOX_API}.number_of_items (item)
		end

	completes: BOOLEAN
		do
			Result := {NS_COMBO_BOX_API}.completes (item)
		end

	set_completes (a_completes: BOOLEAN)
		do
			{NS_COMBO_BOX_API}.set_completes (item, a_completes)
		end

	data_source: NS_OBJECT
		do
			Result := create {NS_OBJECT}.share_from_pointer ({NS_COMBO_BOX_API}.data_source (item))
		end

	set_data_source (a_a_source: NS_OBJECT)
		do
			{NS_COMBO_BOX_API}.set_data_source (item, a_a_source.item)
		end

	add_item_with_object_value (a_object: NS_OBJECT)
		do
			{NS_COMBO_BOX_API}.add_item_with_object_value (item, a_object.item)
		end

	add_items_with_object_values (a_objects: NS_ARRAY[NS_OBJECT])
		do
			{NS_COMBO_BOX_API}.add_items_with_object_values (item, a_objects.object_item)
		end

	insert_item_with_object_value_at_index (a_object: NS_OBJECT; a_index: INTEGER)
			-- Cocoa accepts an (id) type, but what does it actually display?
		do
			{NS_COMBO_BOX_API}.insert_item_with_object_value_at_index (item, a_object.item, a_index)
		end

	remove_item_with_object_value (a_object: NS_OBJECT)
		do
			{NS_COMBO_BOX_API}.remove_item_with_object_value (item, a_object.item)
		end

	remove_item_at_index (a_index: INTEGER)
		do
			{NS_COMBO_BOX_API}.remove_item_at_index (item, a_index)
		end

	remove_all_items
		do
			{NS_COMBO_BOX_API}.remove_all_items (item)
		end

	select_item_with_object_value (a_object: NS_OBJECT)
		do
			{NS_COMBO_BOX_API}.select_item_with_object_value (item, a_object.item)
		end

	item_object_value_at_index (a_index: INTEGER): NS_OBJECT
		do
			Result := create {NS_OBJECT}.share_from_pointer ({NS_COMBO_BOX_API}.item_object_value_at_index (item, a_index))
		end

	object_value_of_selected_item: NS_OBJECT
		do
			Result := create {NS_OBJECT}.share_from_pointer ({NS_COMBO_BOX_API}.object_value_of_selected_item (item))
		end

	index_of_item_with_object_value (a_object: NS_OBJECT): INTEGER
		do
			Result := {NS_COMBO_BOX_API}.index_of_item_with_object_value (item, a_object.item)
		end

	object_values: NS_ARRAY [NS_OBJECT]
		do
			create Result.share_from_pointer ({NS_COMBO_BOX_API}.object_values (item))
		end

end
