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
		do
			Result := {WEL_COM_HRESULT}.e_not_impl
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Responds to property update requests from the Ribbon framework
			-- This function is called from C codes
		do
			Result := {WEL_COM_HRESULT}.e_not_impl
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
					if Result = Void then
						-- Maybe it's application menu's item
						Result := l_resource.ribbon_for_application_menu_item (l_item)
					end
					if Result = Void then
						-- Maybe it's Quick Access Toolbar's item
						Result := l_resource.ribbon_for_qat_item (l_item)
					end
					if Result = Void then
						-- Maybe it's item in Contextual Tab
						Result := l_resource.ribbon_for_contextual_tab_item (l_item)
					end
				elseif attached {EV_RIBBON_APPLICATION_MENU} Current as l_item then
					Result := l_resource.ribbon_for_application_menu (l_item)
				elseif attached {EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS} Current as l_item then
					Result := l_resource.ribbon_for_application_menu_recent_items (l_item)
				elseif attached {EV_RIBBON_HELP_BUTTON} Current as l_help_button then
					Result := l_resource.ribbon_for_help_button (l_help_button)
				elseif attached {EV_RIBBON_QUICK_ACCESS_TOOLBAR} Current as l_quick_access_toolbar then
					Result := l_resource.ribbon_for_quick_access_toolbar (l_quick_access_toolbar)
				elseif attached {EV_RIBBON_MINI_TOOLBAR} Current as l_mini_toolbar then
					Result := l_resource.ribbon_for_mini_toolbar (l_mini_toolbar)
				elseif attached {EV_RIBBON_CONTEXT_MENU} Current as l_context_menu then
					Result := l_resource.ribbon_for_context_menu (l_context_menu)
				elseif attached {EV_RIBBON_TAB_GROUP} Current as l_tab_group then
					Result := l_resource.ribbon_for_contextual_tabs (l_tab_group)
				elseif attached {EV_RIBBON_APPLICATION_MENU_GROUP} Current as l_app_menu_group then
					Result := l_resource.ribbon_for_menu_group (l_app_menu_group)
				else
					check not_possible: False end
				end

				ribbon_cache := Result
			end
		end

feature {NONE}	-- Register

	register_observer
			-- Add current to observer list
		local
			l_shared: EV_SHARED_RESOURCES
		do
			create l_shared
			l_shared.command_handler_singleton.add_observer (Current)
		end

feature {NONE} -- Implementation

	ribbon_cache: detachable EV_RIBBON
			-- Ribbon computed by `ribbon'
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
