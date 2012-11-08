note
	description: "[
					Abstract representation of a button in a ribbon.
					The Button is a control the user can click to provide input to an application.
																								]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_BUTTON

inherit
	EV_RIBBON_ITEM

	EV_COMMAND_HANDLER_OBSERVER
		redefine
			execute,
			update_property
		end

	EV_RIBBON_TEXTABLE

	EV_RIBBON_TOOLTIPABLE

	EV_RIBBON_IMAGEABLE

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
			create select_actions
		end

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions executed just after user clicked on button.

	is_enabled: BOOLEAN
			-- If current has been checked?
		require
			ribbon_exists: attached ribbon as l_ribbon implies l_ribbon.exists
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			if is_enabled_delayed then
				Result := internal_is_enabled
			elseif attached ribbon as l_ribbon then
				create l_key.make_enabled
				create l_value.make_empty
				l_command_id := command_list.item (command_list.lower)
				check command_id_valid: l_command_id /= 0 end
				l_ribbon.get_command_property (l_command_id, l_key, l_value)
				Result := l_value.boolean_value
				l_value.destroy
			end
		end

feature -- Command

	set_enabled (a_bool: BOOLEAN)
			-- Set `is_enabled' with `a_bool'
		require
			ribbon_exists: attached ribbon as l_ribbon implies l_ribbon.exists
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
			l_result: BOOLEAN
		do
			if attached ribbon as l_ribbon then
					-- Ribbon was created. Regardless of the value of `is_enabled_delayed'
					-- we should now always go through the ribbon.
				is_enabled_delayed := False
				l_command_id := command_list.item (command_list.lower)
				check command_id_valid: l_command_id /= 0 end
				create l_key.make_enabled
				create l_value.make_empty
				l_value.set_boolean_value (a_bool)
				l_result := l_ribbon.set_command_property (l_command_id, l_key, l_value)
				l_value.destroy
			end
			if not l_result then
				is_enabled_delayed := True
				internal_is_enabled := a_bool
			end
		end

feature {EV_RIBBON} -- Command

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
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
		do
			Result := Precursor (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
				create l_key.share_from_pointer (a_property_key)
				if l_key.is_label then
					Result := update_property_for_text (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
				elseif l_key.is_tooltip_title or l_key.is_tooltip_description then
					Result := update_property_for_tooltip (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
				elseif l_key.is_small_image or l_key.is_large_image then
					Result := update_property_for_image (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
				elseif l_key.is_enabled then
					if is_enabled_delayed then
						create l_value.share_from_pointer (a_property_new_value)
						l_value.set_boolean_value (internal_is_enabled)
						is_enabled_delayed := False
					end
				end
			end
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

	is_enabled_delayed: BOOLEAN
			-- Is setting of `is_enabled' delayed?

	internal_is_enabled: BOOLEAN
			-- Before Application menu's button visible on screen, `set_enabled' will not work
			-- Setting it when showing the button for first time

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

