note
	description: "[
			Hook manager specific for Core hooks.
				- Value Table Alter
				-
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HOOK_CORE_MANAGER

inherit
	CMS_HOOK_MANAGER

create
	make

feature -- Hook: value alter

	subscribe_to_value_table_alter_hook (h: CMS_HOOK_VALUE_TABLE_ALTER)
			-- Add `h' as subscriber of value table alter hooks CMS_HOOK_VALUE_TABLE_ALTER.		
		do
			subscribe_to_hook (h, {CMS_HOOK_VALUE_TABLE_ALTER})
		end

	invoke_value_table_alter (a_table: CMS_VALUE_TABLE; a_response: CMS_RESPONSE)
			-- Invoke value table alter hook for table `a_table'.		
		do
			if attached subscribers ({CMS_HOOK_VALUE_TABLE_ALTER}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_HOOK_VALUE_TABLE_ALTER} ic.item as h then
						h.value_table_alter (a_table, a_response)
					end
				end
			end
		end

feature -- Hook: response

	subscribe_to_response_alter_hook (h: CMS_HOOK_RESPONSE_ALTER)
			-- Add `h' as subscriber of response alter hooks CMS_HOOK_RESPONSE_ALTER.		
		do
			subscribe_to_hook (h, {CMS_HOOK_RESPONSE_ALTER})
		end

	invoke_response_alter (a_response: CMS_RESPONSE)
			-- Invoke response alter hook for response `a_response'.		
		do
			if attached subscribers ({CMS_HOOK_RESPONSE_ALTER}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_HOOK_RESPONSE_ALTER} ic.item as h then
						h.response_alter (a_response)
					end
				end
			end
		end

feature -- Hook: menu_system_alter

	subscribe_to_menu_system_alter_hook (h: CMS_HOOK_MENU_SYSTEM_ALTER)
			-- Add `h' as subscriber of menu system alter hooks CMS_HOOK_MENU_SYSTEM_ALTER.	
		do
			subscribe_to_hook (h, {CMS_HOOK_MENU_SYSTEM_ALTER})
		end

	invoke_menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Invoke menu system alter hook for menu `a_menu_system', and response `a_response'.	
		do
			if attached subscribers ({CMS_HOOK_MENU_SYSTEM_ALTER}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_HOOK_MENU_SYSTEM_ALTER} ic.item as h then
						h.menu_system_alter (a_menu_system, a_response)
					end
				end
			end
		end

feature -- Hook: menu_alter

	subscribe_to_menu_alter_hook (h: CMS_HOOK_MENU_ALTER)
			-- Add `h' as subscriber of menu alter hooks CMS_HOOK_MENU_ALTER.
		do
			subscribe_to_hook (h, {CMS_HOOK_MENU_ALTER})
		end

	invoke_menu_alter (a_menu: CMS_MENU; a_response: CMS_RESPONSE)
			-- Invoke menu alter hook for menu `a_menu', and response `a_response'.
		do
			if attached subscribers ({CMS_HOOK_MENU_ALTER}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_MENU_ALTER} c.item as h then
						h.menu_alter (a_menu, a_response)
					end
				end
			end
		end


feature -- Hook: form_alter

	subscribe_to_form_alter_hook (h: CMS_HOOK_FORM_ALTER)
			-- Add `h' as subscriber of form alter hooks CMS_HOOK_FORM_ALTER,
			-- and response `a_response'.
		do
			subscribe_to_hook (h, {CMS_HOOK_MENU_ALTER})
		end

	invoke_form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
			-- Invoke form alter hook for form `a_form' and associated data `a_form_data'
		do
			if attached subscribers ({CMS_HOOK_FORM_ALTER}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_FORM_ALTER} c.item as h then
						h.form_alter (a_form, a_form_data, a_response)
					end
				end
			end
		end

feature -- Hook: block		

	subscribe_to_block_hook (h: CMS_HOOK_BLOCK)
			-- Add `h' as subscriber of hooks CMS_HOOK_BLOCK.
		do
			subscribe_to_hook (h, {CMS_HOOK_BLOCK})
		end

	invoke_block (a_response: CMS_RESPONSE)
			-- Invoke block hook for response `a_response' in order to get block from modules.
		do
			if attached subscribers ({CMS_HOOK_BLOCK}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_BLOCK} c.item as h then
						across
							h.block_list as blst
						loop
							h.get_block_view (blst.item, a_response)
						end
					end
				end
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
