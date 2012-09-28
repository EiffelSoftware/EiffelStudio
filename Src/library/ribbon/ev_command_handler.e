note
	description: "[
					EiffelRibbon UI Command Handler class
					
					The class gathering Command information and handling Command events from 
					the Windows Ribbon framework.
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMMAND_HANDLER

inherit
	EV_SHARED_RESOURCES

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create observers.make (100)
		end

feature -- Command

	add_observer (a_observer: EV_COMMAND_HANDLER_OBSERVER)
			-- Add `a_observer' to `observers'
			-- This will be called during the creation of the ribbon and
			-- the value of `observers' is the value of the current
			-- {EV_RIBBON}.observers that we are currently initializing.
		do
			observers.extend (a_observer)
		end

	remove_observer (a_observer: EV_COMMAND_HANDLER_OBSERVER)
			-- Remove `a_observer' from `obervers'
		do
			observers.prune_all (a_observer)
		end

feature {EV_RIBBON_DISPACHER} -- Command

	execute (a_command_handler: POINTER; a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- Responds to execute events on Commands bound to the Command handle
			-- This function is called from C codes
		local
			l_result: NATURAL_32
			l_ribbon: detachable EV_RIBBON
			l_ribbon_list: like ribbon_resource.ribbon_list
		do
			from
				l_ribbon_list := ribbon_resource.ribbon_list
				l_ribbon_list.start
			until
				l_ribbon_list.after
			loop
				l_ribbon := l_ribbon_list.item
				if l_ribbon.command_handler = a_command_handler then
					if attached l_ribbon.observers as l_observers then
						from
							l_observers.start
							l_result := {WEL_COM_HRESULT}.e_not_impl
						until
							l_observers.after or l_result = {WEL_COM_HRESULT}.s_ok
						loop
							l_result := l_observers.item.execute (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
							l_observers.forth
						end
					end
				end
				l_ribbon_list.forth
			end

		end

	update_property (a_command_handler: POINTER; a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Responds to property update requests from the Ribbon framework
			-- This function is called from C codes
		local
			l_result: NATURAL_32
			l_ribbon: detachable EV_RIBBON
			l_ribbon_list: like ribbon_resource.ribbon_list
		do
			from
				l_ribbon_list := ribbon_resource.ribbon_list
				l_ribbon_list.start
			until
				l_ribbon_list.after
			loop
				l_ribbon := l_ribbon_list.item
				if l_ribbon.command_handler = a_command_handler then
					if attached l_ribbon.observers as l_observers then
						from
							l_observers.start
							l_result := {WEL_COM_HRESULT}.e_not_impl
						until
							l_observers.after or l_result = {WEL_COM_HRESULT}.s_ok
						loop
							l_result := l_observers.item.update_property (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
							l_observers.forth
						end
					end
				end
				l_ribbon_list.forth
			end
		end

feature {EV_RIBBON} -- Observers

	recreate_observers
			-- Recreate observers, leave it empty
		do
			make
		ensure
			observers_is_empty: observers.is_empty
		end

	observers: ARRAYED_LIST [EV_COMMAND_HANDLER_OBSERVER];
			-- Observer pattern
			-- All Observers of `execute' and `update_property'

note
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
