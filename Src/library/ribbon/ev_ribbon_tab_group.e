note
	description: "[
					A Tab Group is a contextual control that is hidden or displayed at run time, 
					based on a document or workspace state. The Tab Group contains a set of 
					context-related Tab controls.
																									]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_TAB_GROUP

inherit
	EV_COMMAND_HANDLER_OBSERVER
		redefine
			execute,
			update_property
		end

	EV_RIBBON_TEXTABLE

	EV_RIBBON_TOOLTIPABLE

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
		deferred
		end

feature -- Query

	tabs: ARRAYED_LIST [EV_RIBBON_TAB]
			-- All groups in current tab

	text: STRING = "Tab Group"
			-- Text of tab

feature -- Command

	active
			-- Display current tab group on screen
		local
			l_key: EV_PROPERTY_KEY
			l_valie: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
			l_result: BOOLEAN
		do
			if not command_list.is_empty then
				l_command_id := command_list.item (command_list.lower)
				create l_key.make_context_avaiable
				create l_valie.make_empty
				l_valie.set_uint32 ({EV_UI_CONTEXT_AVAILABILITY_ENUM}.active)

				if attached ribbon as l_ribbon then
					l_result := l_ribbon.set_command_property (l_command_id, l_key, l_valie)
				end
			end
		end

	hide
			-- Hide current tab group on screen
		local
			l_key: EV_PROPERTY_KEY
			l_valie: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
			l_result: BOOLEAN
		do
			if not command_list.is_empty then
				l_command_id := command_list.item (command_list.lower)
				create l_key.make_context_avaiable
				create l_valie.make_empty
				l_valie.set_uint32 ({EV_UI_CONTEXT_AVAILABILITY_ENUM}.not_available)

				if attached ribbon as l_ribbon then
					l_result := l_ribbon.set_command_property (l_command_id, l_key, l_valie)
				end
			end
		end

feature {NONE}	--Action handling

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
			Result := Precursor (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
				Result := update_property_for_text (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
				Result := update_property_for_tooltip (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			end
		end

feature {NONE}	-- Implementation

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
