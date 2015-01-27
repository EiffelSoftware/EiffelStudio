note
	description: "[
			Hook providing a way to alter a menu
		]"
	date: "$Date$"

deferred class
	CMS_HOOK_MENU_ALTER

inherit
	CMS_HOOK

feature -- Hook

	menu_alter (a_menu: CMS_MENU; a_response: CMS_RESPONSE)
			-- Hook execution on menu `a_menu'
			-- for related response `a_response'.
		deferred
		end

end
