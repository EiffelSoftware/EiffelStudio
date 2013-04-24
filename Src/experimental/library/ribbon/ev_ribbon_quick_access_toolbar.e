note
	description: "[
					The Quick Access Toolbar (QAT) is a small, customizable toolbar
					that exposes a set of Commands that are specified by the application
					or selected by the user.
																							 ]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_QUICK_ACCESS_TOOLBAR

inherit
	EV_COMMAND_HANDLER_OBSERVER
		redefine
			execute,
			update_property
		end

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list
			create default_buttons.make (10)
			create items_source.make (10)

			create_interface_objects
			register_observer
		ensure
			set: command_list = a_list
		end

	create_interface_objects
			-- Create objects
		deferred
		end

feature -- Command

	set_items_source (a_items_source: like items_source)
			-- Set `item_source' with `a_items_source'
		require
			not_void: a_items_source /= Void
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			items_source := a_items_source
			if attached ribbon as l_ribbon then
				l_command_id := command_list.item (command_list.lower)
				check command_id_valid: l_command_id /= 0 end

				create l_key.make_items_source
				create l_enum
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
			end
		end

feature -- Query

	default_buttons: ARRAYED_LIST [EV_RIBBON_ITEM]
			-- Default buttons (in "Customize Quick Access Toolbar" context menu)

	items_source: ARRAYED_LIST [EV_RIBBON_ITEM]
			-- Buttons showing on QAT

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions executed just after user clicked on button.

feature {NONE}	-- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

feature {NONE} -- Command handler

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
				if a_execution_verb = {EV_EXECUTION_VERB}.execute then
					select_actions.call (Void)
				elseif a_execution_verb = {EV_EXECUTION_VERB}.preview then

				elseif a_execution_verb = {EV_EXECUTION_VERB}.cancel_preview then

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
				Result := {WEL_COM_HRESULT}.s_ok
				create l_key.share_from_pointer (a_property_key)
				if l_key.is_items_source then
					create l_value.share_from_pointer (a_property_current_value)
					create l_collection.make_with_prop_variant (l_value)

					l_collection.clear

					add_items_to_ui_collection (l_collection) -- FIXME: similiar to EV_RIBBON_COMBO_BOX's, merge?
					l_collection.release -- Release COM object here
				end

			end
		end

	add_items_to_ui_collection (a_collection: EV_RIBBON_COLLECTION)
			-- FIXME: same as EV_RIBBON_COMBO_BOX's, merge?
		require
			not_void: a_collection /= Void
		local
			l_property_set: EV_SIMPLE_PROPERTY_SET
			l_command_id: NATURAL_32
			l_item: EV_RIBBON_ITEM
		do
			from
				items_source.start
			until
				items_source.after
			loop
				l_item := items_source.item
				if l_item.command_list.count > 0 then
					l_command_id := l_item.command_list.item (l_item.command_list.lower)

					create l_property_set.make
					l_property_set.set_command_id (l_command_id)
					a_collection.add (l_property_set)
				end

				items_source.forth
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
