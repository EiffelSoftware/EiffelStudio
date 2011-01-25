note
	description: "Abstract representation of a checkbox in a ribbon"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_CHECKBOX

inherit
	EV_RIBBON_ITEM

	EV_COMMAND_HANDLER_OBSERVER

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
			-- Select actions executed just after user clicked on check box.

	text: STRING_32
			-- Text of check box.
		deferred
		end

	is_selected: BOOLEAN
			-- If current has been checked?
		local
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end
			create l_value.make_empty
			if attached ribbon as l_ribbon then
				{EV_RIBBON}.get_UI_Command_Property_Boolean (l_command_id, l_value.pointer.item, l_ribbon.item)
			end

			Result := l_value.boolean_value
		end

	ribbon: detachable EV_RIBBON
			-- Parent ribbon
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON]
			l_ribbon: EV_RIBBON
			l_tab: EV_RIBBON_TAB
			l_group: EV_RIBBON_GROUP
			l_item: EV_RIBBON_ITEM
		do
			from
				create l_res
				l_list := l_res.ribbon_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon := l_list.item
				from
					-- Search tabs in `l_ribbon'
					l_ribbon.tabs.start
				until
					l_ribbon.tabs.after or Result /= Void
				loop
					l_tab := l_ribbon.tabs.item
					from
						-- Search group in `l_tab'
						l_tab.groups.start
					until
						l_tab.groups.after or Result /= Void
					loop
						l_group := l_tab.groups.item
						from
							-- Search items in `l_group'
							l_group.buttons.start
						until
							l_group.buttons.after or Result /= Void
						loop
							if l_group.buttons.item = Current then
								Result := l_ribbon
							end
							l_group.buttons.forth
						end

						l_tab.groups.forth
					end
					l_ribbon.tabs.forth
				end
				l_list.forth
			end
		end

feature {EV_RIBBON} -- Command

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				select_actions.call (Void)
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current


end
