note
	description: "Summary description for {EV_RIBBON_COMBO_BOX}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_COMBO_BOX

inherit
	EV_RIBBON_BUTTON
		redefine
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
			--
		do
			check not_implemented: False end
		end

	selected_item
			--
		do
			check not_implemented: False end
		end

	item_source: ARRAYED_LIST [EV_RIBBON_COMBO_BOX_ITEM]
			--

feature -- Command

	set_string_value
			--
		do
			check not_implemented: False end
		end

	set_selected_item
			--
		do
			check not_implemented: False end
		end

	set_item_source (a_item_source: like item_source)
			--
		require
			not_void: a_item_source /= Void
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			item_source := a_item_source

			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_items_source
				create l_enum
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
			end
		end

feature {NONE} -- Implementation

	add_items_to_ui_collection (a_collection: EV_RIBBON_COLLECTION)
			--
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
					add_items_to_ui_collection (l_collection)
					l_collection.release -- Release COM object here
				elseif l_key.is_categories then
					Result := 1 -- FIXME: tempoary S_FALSE
				elseif l_key.is_selected_item then
					create l_value.share_from_pointer (a_property_new_value)
					l_value.set_uint32 (0)
				end

			end
		end
end
