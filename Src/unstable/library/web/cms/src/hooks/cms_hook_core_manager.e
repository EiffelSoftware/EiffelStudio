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
		local
			bl, l_alias: READABLE_STRING_8
			bl_optional: BOOLEAN
			l_block_cache: detachable TUPLE [block: CMS_CACHE_BLOCK; region: READABLE_STRING_8; expired: BOOLEAN]
			l_alias_table: detachable STRING_TABLE [LIST [READABLE_STRING_8]] --| block_id => [alias_ids..]
			l_origin_block: detachable CMS_BLOCK
		do
			if attached subscribers ({CMS_HOOK_BLOCK}) as lst then
				l_alias_table := a_response.block_alias_table

				across
					lst as c
				loop
					if attached {CMS_HOOK_BLOCK} c.item as h then
						across
							h.block_list as blst
						loop
							bl := blst.item
							bl_optional := bl.count > 0 and bl[1] = '?'
							if bl_optional then
								bl := bl.substring (2, bl.count)
							end

							if a_response.is_block_included (bl, not bl_optional) then
								l_block_cache := a_response.block_cache (bl)
								if l_block_cache /= Void and then not l_block_cache.expired then
									a_response.add_block (l_block_cache.block, l_block_cache.region)
								else
									h.get_block_view (bl, a_response)
								end
							end
							if
								l_alias_table /= Void and then
								attached l_alias_table.item (bl) as l_aliases
							then
								across
									l_aliases as aliases_ic
								loop
									l_alias := aliases_ic.item
									l_origin_block := a_response.blocks.item (bl)
									if l_origin_block = Void then
										h.get_block_view (bl, a_response)
										l_origin_block := a_response.blocks.item (bl)
										if l_origin_block /= Void then
												-- Previously, it was not included.
												-- Computed only to include alias
												-- then remove `l_origin_block'.
											a_response.remove_block (l_origin_block)
										end
									end
									if l_origin_block /= Void then
										a_response.add_block (create {CMS_ALIAS_BLOCK}.make_with_block (l_alias, l_origin_block), Void)
									end
								end
							end
						end
					end
				end
			end
		end

feature -- Hook: cache

	subscribe_to_cache_hook (h: CMS_HOOK_CACHE)
			-- Add `h' as subscriber of cache hooks CMS_HOOK_CACHE,
			-- and response `a_response'.
		do
			subscribe_to_hook (h, {CMS_HOOK_CACHE})
		end

	invoke_clear_cache (a_cache_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_response: CMS_RESPONSE)
			-- Invoke cache hook for identifiers `a_cache_id_list'.
		do
			if attached subscribers ({CMS_HOOK_CACHE}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_CACHE} c.item as h then
						h.clear_cache (a_cache_id_list, a_response)
					end
				end

				a_response.clear_block_caches (a_cache_id_list)
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
