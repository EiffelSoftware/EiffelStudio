note
	description: "[
					The Drop-Down Gallery consists of a button that when clicked displays a drop-down 
					list containing a collection of mutually exclusive items or Commands.
																										]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_DROP_DOWN_GALLERY

inherit
	EV_RIBBON_BUTTON
		redefine
			update_property,
			execute,
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

	item_source: ARRAYED_LIST [EV_RIBBON_DROP_DOWN_GALLERY_ITEM]
			-- Query the collection of items in Current

feature -- Command

	set_selected_item
			-- Set selected item
		do
			check not_implemented: False end
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
				create l_property_set.make
				if attached item_source.item.image as l_image then
					l_property_set.set_item_image (l_image)
				end
				if attached item_source.item.label as l_label then
					l_property_set.set_string (l_label)
				end
				a_collection.add (l_property_set)
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

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		local
			l_selected: NATURAL_32
			l_item: EV_RIBBON_DROP_DOWN_GALLERY_ITEM
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				l_selected := selected_item
				if item_source.valid_index (l_selected.as_integer_32 + 1) then
					l_item := item_source.i_th (l_selected.as_integer_32 + 1)
					if a_execution_verb = {EV_EXECUTION_VERB}.execute then
						if attached l_item.select_actions_cache as l_select_action then
							l_select_action.call (void)
						end
					elseif a_execution_verb = {EV_EXECUTION_VERB}.preview then
						if attached l_item.preview_actions_cache as l_preview_action then
							l_preview_action.call (void)
						end
					elseif a_execution_verb = {EV_EXECUTION_VERB}.cancel_preview then
						if attached l_item.cancel_preview_actions_cache as l_cancel_preview_action then
							l_cancel_preview_action.call (void)
						end
					end

				end
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
