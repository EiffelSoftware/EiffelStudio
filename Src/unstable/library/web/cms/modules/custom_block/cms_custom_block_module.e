note
	description: "[
			Module that provide custom block factory.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CUSTOM_BLOCK_MODULE

inherit
	CMS_MODULE
		rename
			module_api as custom_block_api
		redefine
			initialize,
			setup_hooks,
			custom_block_api
		end

	CMS_HOOK_RESPONSE_BLOCK

	CMS_HOOK_BLOCK_HELPER

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Custom Block"
			package := "layout"
		end

feature -- Access

	name: STRING = "custom_block"
			-- <Precursor>

feature {CMS_API} -- Module Initialization

	initialize (api: CMS_API)
			-- Initialize Current module with `api'.
		do
			create custom_block_api.make (api)
			Precursor (api)
		end

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Module api

	custom_block_api: detachable CMS_MODULE_API
			-- <Precursor>.

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	block_identifiers (a_response: detachable CMS_RESPONSE): detachable ARRAYED_LIST [READABLE_STRING_8]
			-- <Precursor>
		local
			api: CMS_API
			l_name: READABLE_STRING_32
			l_block_id: READABLE_STRING_8
			l_conds: detachable ARRAYED_LIST [CMS_BLOCK_CONDITION]
		do
			if attached custom_block_api as l_mod_api then
				api := l_mod_api.cms_api
				if
					attached api.module_configuration (Current, name) as cfg and then
					attached cfg.table_keys ("blocks") as lst
				then
					create Result.make (0)
					across
						lst as ic
					loop
						l_name := ic.item
						l_conds := Void
						if l_name.is_valid_as_string_8 then
							l_block_id := l_name.to_string_8
							if a_response /= Void then
								if attached cfg.text_list_item ("blocks." + l_block_id + ".conditions") as l_cond_expressions then
									create l_conds.make (l_cond_expressions.count)
									across
										l_cond_expressions as exp_ic
									loop
										l_conds.force (create {CMS_BLOCK_EXPRESSION_CONDITION}.make (exp_ic.item))
									end
								end
								if l_conds = Void or else l_conds.is_empty then
									Result.force ("?" + l_block_id)
								elseif are_conditions_satisfied (l_conds, a_response) then
									Result.force (l_block_id)
								end
							else
								Result.force ("?" + l_block_id)
							end
						end
					end
				end
			end
		end

	are_conditions_satisfied (a_conditions: LIST [CMS_BLOCK_CONDITION]; a_response: CMS_RESPONSE): BOOLEAN
			-- Are `a_conditions' satisfied for `a_response'?
		do
			Result := across a_conditions as ic some ic.item.satisfied_for_response (a_response) end
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			l_region: detachable READABLE_STRING_8
			l_cond: CMS_BLOCK_EXPRESSION_CONDITION
			l_block_pref: STRING
		do
			if attached smarty_template_block (Current, a_block_id, a_response.api) as bk then
				if attached a_response.api.module_configuration (Current, name) as cfg then
					l_block_pref := "blocks." + a_block_id
					if
						attached cfg.text_item (l_block_pref + ".region") as s and then
						s.is_valid_as_string_8
					then
						l_region := s.to_string_8
					end
					bk.set_weight (cfg.integer_item (l_block_pref + ".weight"))
					bk.set_title (cfg.text_item (l_block_pref + ".title"))
					if attached cfg.text_item (l_block_pref + ".is_raw") as l_is_raw then
						bk.set_is_raw (l_is_raw.is_case_insensitive_equal ("yes"))
					end
					if attached cfg.text_list_item (l_block_pref + ".conditions") as l_cond_exp_list then
						across
							l_cond_exp_list as ic
						loop
							create l_cond.make (ic.item)
							bk.add_condition (l_cond)
						end
					end
				end
				a_response.add_block (bk, l_region)
			else
				a_response.add_debug_message ("Missing template for custom block %"" + a_block_id + "%"!")
			end
		end

end
