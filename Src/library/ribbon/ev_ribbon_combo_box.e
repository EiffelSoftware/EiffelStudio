note
	description: "[
			The Combo Box consists of a single-column list box that contains a 
			collection of mutually exclusive items or Commands combined with a static
			or edit control and a drop-down arrow. The list box portion of the control
			is displayed when the user clicks the drop-down arrow.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_COMBO_BOX

inherit
	EV_RIBBON_BUTTON
		redefine
			execute,
			update_property,
			create_interface_objects
		end

feature {NONE} -- Initialziation

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create item_source.make (10)
		end

feature -- Query

	string_value
			-- Query the value in the Combo Box control.
		do
			check not_implemented: False end
		end

	selected_item: NATURAL
			-- Current selected item index (base is 0)
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_selected_item
				create l_value.make_empty
				l_ribbon.get_command_property (l_command_id, l_key, l_value)
				Result := l_value.uint32_value
				l_value.destroy
			end
		end

	item_source: ARRAYED_LIST [EV_RIBBON_COMBO_BOX_ITEM]
			-- Query the collection of items in Current

feature -- Command

	set_string_value
			-- Set the value in the Combo Box control.
		do
			check not_implemented: False end
		end

	set_selected_item (a_index: NATURAL)
			-- Set selected item index
		require
			valid: a_index >= 0 and then item_source.count.as_natural_32 > a_index
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_selected_item
				create l_value.make_empty
				l_value.set_uint32 (a_index)
				l_ribbon.set_command_property (l_command_id, l_key, l_value).do_nothing
				l_value.destroy
			end
		end

	set_item_source (a_item_source: like item_source)
			-- Set `item_source' with `a_item_source'
		require
			not_void: a_item_source /= Void
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			item_source := a_item_source

			if attached ribbon as l_ribbon then
				l_command_id := command_list.item (command_list.lower)
				check command_id_valid: l_command_id /= 0 end

				create l_key.make_items_source
				create l_enum
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
			end
		end

feature {NONE} -- Implementation

	add_items_to_ui_collection (a_collection: EV_RIBBON_COLLECTION)
			-- Add items to `a_collection'
		require
			not_void: a_collection /= Void
		local
			l_property_set: EV_SIMPLE_PROPERTY_SET
		do
			from
				item_source.start
			until
				item_source.after
			loop
				if attached item_source.item.label as l_label then
					create l_property_set.make
					l_property_set.set_string (l_label)
					a_collection.add (l_property_set)
				end

				item_source.forth
			end
		end

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		local
			l_selected: NATURAL_32
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				l_selected := selected_item
				if
					item_source.valid_index (l_selected.as_integer_32 + 1) and then
					a_execution_verb = {EV_EXECUTION_VERB}.execute and then
					attached item_source [l_selected.as_integer_32 + 1].select_actions_cache as l_select_action
				then
					l_select_action.call
				end
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		local
			l_collection: EV_RIBBON_COLLECTION
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
		do
			Result := Precursor (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			if command_list.has (a_command_id) then
				create l_key.share_from_pointer (a_property_key)
				if l_key.is_items_source then
					create l_value.share_from_pointer (a_property_current_value)
					create l_collection.make_with_prop_variant (l_value)
					l_collection.clear
					add_items_to_ui_collection (l_collection)
					l_collection.release -- Release COM object here
				elseif l_key.is_categories then
					Result := 1 -- FIXME: tempoary S_FALSE
				elseif l_key.is_selected_item then
					create l_value.share_from_pointer (a_property_new_value)
					l_value.set_uint32 (0)
				elseif l_key.is_representative_string then
					-- Initialize combo box width with maximum width string
					if attached maximum_width_string as l_string then
						create l_value.share_from_pointer (a_property_new_value)
						l_value.set_string_value (l_string)
					end
				end

			end
		end

	maximum_width_string: detachable READABLE_STRING_32
			-- Maximum width string from items source
		local
			l_item: EV_RIBBON_COMBO_BOX_ITEM
			l_font: EV_FONT
			l_max_width, l_width: INTEGER
		do
			from
				create l_font
				item_source.start
			until
				item_source.after
			loop
				l_item := item_source.item
				if attached l_item.label as l_label then
					l_width := l_font.string_width (l_label)
					if l_width > l_max_width then
						l_max_width := l_width
						Result := l_label
					end
				end
				item_source.forth
			end
		end
note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
