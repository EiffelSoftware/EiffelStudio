note
	description: "Summary description for EV_COMMAND_HANDLER_OBSERVER."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMMAND_HANDLER_OBSERVER

feature -- Action handlers

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- Responds to execute events on Commands bound to the Command handle
			-- This function is called from C codes
		deferred
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Responds to property update requests from the Ribbon framework
			-- This function is called from C codes
		deferred
		end

feature -- Command

	ribbon: detachable EV_RIBBON
			-- Parent ribbon
		local
			l_resource: EV_RIBBON_RESOURCES
		do
			if ribbon_cache /= Void then
				Result := ribbon_cache
			else
				create l_resource
				if attached {EV_RIBBON_TAB} Current as l_tab then
					Result := l_resource.ribbon_for_tab (l_tab)
				elseif attached {EV_RIBBON_GROUP} Current as l_group then
					Result := l_resource.ribbon_for_group (l_group)
				elseif attached {EV_RIBBON_ITEM} Current as l_item then
					Result := l_resource.ribbon_for_item (l_item)
				else
					check not_possible: False end
				end
			end
		end

feature {NONE}	-- Register

	register_observer
			--
		local
			l_shared: EV_SHARED_RESOURCES
		do
			create l_shared
			l_shared.command_handler_singleton.add_observer (Current)
		end

feature {NONE} -- Implementation

	ribbon_cache: detachable EV_RIBBON
			-- Ribbon computed by `ribbon'
end
