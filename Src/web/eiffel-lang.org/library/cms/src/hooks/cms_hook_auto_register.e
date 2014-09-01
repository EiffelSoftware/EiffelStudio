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

	hook_auto_register (a_service: CMS_SERVICE)
		do
			if attached {CMS_HOOK_MENU_ALTER} Current as h_menu_alter then
				a_service.add_menu_alter_hook (h_menu_alter)
			end
			if attached {CMS_HOOK_BLOCK} Current as h_block then
				a_service.add_block_hook (h_block)
			end
			if attached {CMS_HOOK_FORM_ALTER} Current as h_block then
				a_service.add_form_alter_hook (h_block)
			end

		end

end
