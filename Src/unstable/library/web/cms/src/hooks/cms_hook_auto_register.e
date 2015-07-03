note
	description: "[
			Summary description for {CMS_HOOK_AUTO_REGISTER}.
			When inheriting from this class, the declared hooks are automatically
			registered, otherwise, each descendant has to add it to the cms service
			itself.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_AUTO_REGISTER

inherit
	CMS_HOOK

feature -- Hook

	auto_subscribe_to_hooks (a_response: CMS_RESPONSE)
		do
			if attached {CMS_HOOK_MENU_SYSTEM_ALTER} Current as h_menu_system_alter then
				a_response.subscribe_to_menu_system_alter_hook (h_menu_system_alter)
			end
			if attached {CMS_HOOK_MENU_ALTER} Current as h_menu_alter then
				a_response.subscribe_to_menu_alter_hook (h_menu_alter)
			end
			if attached {CMS_HOOK_BLOCK} Current as h_block then
				a_response.subscribe_to_block_hook (h_block)
			end
			if attached {CMS_HOOK_FORM_ALTER} Current as h_form then
				a_response.subscribe_to_form_alter_hook (h_form)
			end
			if attached {CMS_HOOK_VALUE_TABLE_ALTER} Current as h_value then
				a_response.subscribe_to_value_table_alter_hook (h_value)
			end
			if attached {CMS_HOOK_RESPONSE_ALTER} Current as h_resp then
				a_response.subscribe_to_response_alter_hook (h_resp)
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
