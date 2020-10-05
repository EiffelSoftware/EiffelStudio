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

	CMS_WITH_MODULE_ADMINISTRATION

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
			create custom_block_api.make (Current, api)
			Precursor (api)
		end

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Module api

	custom_block_api: detachable CMS_CUSTOM_BLOCK_API
			-- <Precursor>.

feature {NONE} -- Administration

	administration: CMS_CUSTOM_BLOCK_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

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
			bk: CMS_CUSTOM_BLOCK
			l_conds: detachable ARRAYED_LIST [CMS_BLOCK_CONDITION]
		do
			if attached custom_block_api as l_mod_api then
				if attached l_mod_api.blocks as lst then
					create Result.make (0)
					across
						lst as ic
					loop
						bk := ic.item
						l_conds := bk.conditions
						if a_response /= Void then
							if l_conds = Void or else l_conds.is_empty then
								Result.force ("?" + bk.id)
							elseif are_conditions_satisfied (l_conds, a_response) then
								Result.force (bk.id)
							end
						else
							Result.force ("?" + bk.id)
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
		do
			if
				attached custom_block_api as l_custom_block_api and then
				attached l_custom_block_api.block_template (a_block_id) as tplbk and then
				attached l_custom_block_api.block (a_block_id) as bk
			then
				tplbk.set_is_raw (bk.is_raw)
				tplbk.set_title (bk.title)
				tplbk.set_weight (bk.weight)
				if attached bk.conditions as l_conds then
					across
						l_conds as ic
					loop
						tplbk.add_condition (ic.item)
					end
				end
				a_response.add_block (tplbk, bk.region)
			else
				a_response.add_debug_message ("Missing template for custom block %"" + a_block_id + "%"!")
			end
		end

end
