note
	description: "[
					The Recent Items list is a pane in the Application Menu that displays the most recently 
					used (MRU) items for an application.
																												]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS

inherit
	EV_COMMAND_HANDLER_OBSERVER
		redefine
			execute,
			update_property
		end
create
	make_with_command_list

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list

			create_interface_objects
			register_observer
		ensure
			set: command_list = a_list
		end

	create_interface_objects
			-- Create objects
		do
			create recent_items.make (0)
		end

feature -- Command

	set_recent_items (a_list: ARRAYED_LIST [EV_RIBBON_APPLICATION_MENU_RECENT_ITEM])
			--
		require
			not_void: a_list /= Void
		local
			l_key: EV_PROPERTY_KEY
		do
			recent_items := a_list
			if attached ribbon as l_ribbon then
				check valid: command_list.count = 1 end
				create l_key.make_recent_items
				l_ribbon.invalidate (command_list.item (command_list.lower), {EV_UI_INVALIDATIONS_ENUM}.ui_invalidations_property, l_key)
			end
		ensure
			set: recent_items = a_list
		end

feature -- Query

	recent_items: ARRAYED_LIST [EV_RIBBON_APPLICATION_MENU_RECENT_ITEM]
			-- Recent items in application menu right pane

feature {EV_RIBBON} -- Command

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_selected: NATURAL_32
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
				if a_execution_verb = {EV_EXECUTION_VERB}.execute then
					create l_key.share_from_pointer (a_property_key)
					if l_key.is_selected_item then
						create l_value.share_from_pointer (a_property_value)
						l_selected := l_value.uint32_value
						if recent_items.valid_index (l_selected.as_integer_32 + 1) and then
							attached recent_items.i_th (l_selected.as_integer_32 + 1).select_actions_cache as l_selected_actions then
							l_selected_actions.call (void)
						end
					end
				elseif a_execution_verb = {EV_EXECUTION_VERB}.preview then

				elseif a_execution_verb = {EV_EXECUTION_VERB}.cancel_preview then

				end
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_property_set: EV_SIMPLE_PROPERTY_SET
			l_list: ARRAYED_LIST [EV_SIMPLE_PROPERTY_SET]
		do
			Result := Precursor (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
				create l_key.share_from_pointer (a_property_key)
				if l_key.is_recent_items then
					create l_value.share_from_pointer (a_property_new_value)
					from
						create l_list.make (recent_items.count)
						recent_items.start
					until
						recent_items.after
					loop
						create l_property_set.make
						if attached recent_items.item.label as l_label then
							l_property_set.set_string (l_label)
						end
						l_list.extend (l_property_set)

						recent_items.forth
					end

					l_value.set_safe_array (l_list)
				else
				end

			end
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

;note
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
