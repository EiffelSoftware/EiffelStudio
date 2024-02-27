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


feature -- Hook: new user hook

	subscribe_to_user_management_hook (h: CMS_HOOK_USER_MANAGEMENT)
			-- Add `h' as subscriber of value table alter hooks CMS_HOOK_USER_MANAGEMENT.
		do
			subscribe_to_hook (h, {CMS_HOOK_USER_MANAGEMENT})
		end

	invoke_new_user (a_user: CMS_USER)
			-- Invoke new_user hook for user `a_user'.
		do
			if attached subscribers ({CMS_HOOK_USER_MANAGEMENT}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_HOOK_USER_MANAGEMENT} ic.item as h then
						h.new_user (a_user)
					end
				end
			end
		end

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

feature -- Hook: webapi response

	subscribe_to_webapi_response_alter_hook (h: CMS_HOOK_WEBAPI_RESPONSE_ALTER)
			-- Add `h' as subscriber of response alter hooks CMS_HOOK_WEBAPI_RESPONSE_ALTER.		
		do
			subscribe_to_hook (h, {CMS_HOOK_WEBAPI_RESPONSE_ALTER})
		end

	invoke_webapi_response_alter (a_response: WEBAPI_RESPONSE)
			-- Invoke response alter hook for response `a_response'.		
		do
			if attached subscribers ({CMS_HOOK_WEBAPI_RESPONSE_ALTER}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_HOOK_WEBAPI_RESPONSE_ALTER} ic.item as h then
						h.webapi_response_alter (a_response)
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
			subscribe_to_hook (h, {CMS_HOOK_FORM_ALTER})
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
			l_alias_table: detachable STRING_TABLE [LIST [READABLE_STRING_8]] --| block_id => [alias_ids..]
			l_origin_block: detachable CMS_BLOCK
		do
			if attached subscribers ({CMS_HOOK_BLOCK}) as lst then
				l_alias_table := a_response.block_alias_table

				across
					lst as c
				loop
					if
						attached {CMS_HOOK_BLOCK} c.item as h and then
						attached h.block_identifiers (a_response) as l_names
					then
						across
							l_names as blst
						loop
							bl := blst.item
							bl_optional := bl.count > 0 and bl[1] = '?'
							if bl_optional then
								bl := bl.substring (2, bl.count)
							end

							if a_response.is_block_included (bl, not bl_optional) then
								if
									attached a_response.block_cache (bl) as l_block_cache and then
									not l_block_cache.expired
								then
									a_response.add_block (l_block_cache.cache_block, l_block_cache.region)
									h.setup_block (l_block_cache.cache_block, a_response)
								else
									h.get_block_view (bl, a_response)
									if attached a_response.blocks.item (bl) as l_block then
										h.setup_block (l_block, a_response)
									end
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
										if attached a_response.blocks.item (bl) as l_block then
											h.setup_block (l_block, a_response)
										end
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
		local
			retried: BOOLEAN
		do
			if not retried then
				if attached subscribers ({CMS_HOOK_CACHE}) as lst then
					across
						lst as c
					loop
						if attached {CMS_HOOK_CACHE} c.item as h then
							safe_call_clear_cache_on_hook (h, a_cache_id_list, a_response)
						end
					end
					a_response.clear_cache (a_cache_id_list)
				end
			else
				a_response.add_error_message ("Error occurred while clearing cache.")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Hook: cache		

	safe_call_clear_cache_on_hook (a_hook: CMS_HOOK_CACHE; a_cache_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_response: CMS_RESPONSE)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_hook.clear_cache (a_cache_id_list, a_response)
			else
				if attached {CMS_MODULE} a_hook as mod then
					a_response.add_error_message ("Exception occurred for `clear_cache` [" + mod.name + "]")
				else
					a_response.add_error_message ("Exception occurred for `clear_cache`")
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Hook: cleanup

	subscribe_to_cleanup_hook (h: CMS_HOOK_CLEANUP)
			-- Add `h' as subscriber of cleanup hooks CMS_HOOK_CLEANUP.		
		do
			subscribe_to_hook (h, {CMS_HOOK_CLEANUP})
		end

	invoke_cleanup (ctx: CMS_HOOK_CLEANUP_CONTEXT; a_response: CMS_RESPONSE)
			-- Invoke response cleanup hook for response `a_response'.		
		do
			if attached subscribers ({CMS_HOOK_CLEANUP}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_HOOK_CLEANUP} ic.item as h then
						h.cleanup (ctx, a_response)
					end
				end
			end
		end

feature -- Hook: export

	subscribe_to_export_hook (h: CMS_HOOK_EXPORT)
			-- Add `h' as subscriber of export hooks CMS_HOOK_EXPORT.		
		do
			subscribe_to_hook (h, {CMS_HOOK_EXPORT})
		end

	invoke_export_to (a_export_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_export_parameters: CMS_EXPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Invoke response alter hook for response `a_response'.		
		local
			d: DIRECTORY
		do
			if attached subscribers ({CMS_HOOK_EXPORT}) as lst then
				create d.make_with_path (a_export_parameters.location)
				if not d.exists then
					d.recursive_create_dir
				end
				across
					lst as ic
				loop
					if attached {CMS_HOOK_EXPORT} ic.item as h then
						h.export_to (a_export_id_list, a_export_parameters, a_response)
					end
				end
			end
		end

feature -- Hook: import

	subscribe_to_import_hook (h: CMS_HOOK_IMPORT)
			-- Add `h' as subscriber of import hooks CMS_HOOK_IMPORT.		
		do
			subscribe_to_hook (h, {CMS_HOOK_IMPORT})
		end

	invoke_import_from (a_import_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_import_ctx: CMS_IMPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Invoke response alter hook for response `a_response'.		
		local
			d: DIRECTORY
		do
			if attached subscribers ({CMS_HOOK_IMPORT}) as lst then
				create d.make_with_path (a_import_ctx.location)
				if not d.exists then
					d.recursive_create_dir
				end
				across
					lst as ic
				loop
					if attached {CMS_HOOK_IMPORT} ic.item as h then
						h.import_from (a_import_id_list, a_import_ctx, a_response)
					end
				end
			end
		end


note
	copyright: "2011-2024, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
