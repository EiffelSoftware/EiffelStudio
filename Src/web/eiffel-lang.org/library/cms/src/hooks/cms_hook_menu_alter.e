note
	description: "Summary description for {CMS_HOOK_MENU_ALTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_MENU_ALTER

inherit
	CMS_HOOK

feature -- Hook

	menu_alter (a_menu_system: CMS_MENU_SYSTEM; a_execution: CMS_EXECUTION)
		deferred
		end

end
