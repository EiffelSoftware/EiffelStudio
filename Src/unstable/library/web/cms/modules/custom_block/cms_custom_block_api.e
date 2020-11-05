note
	description: "Summary description for {CMS_CUSTOM_BLOCK_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CUSTOM_BLOCK_API

inherit
	CMS_MODULE_API
		rename
			make as make_api
		redefine
			initialize
		end

	CMS_HOOK_BLOCK_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_module: CMS_CUSTOM_BLOCK_MODULE; a_api: CMS_API)
		do
			module := a_module
			cms_api := a_api
			initialize
		end

	initialize
			-- Initialize Current api.
		do
			Precursor
		end

feature -- Access

	module: CMS_CUSTOM_BLOCK_MODULE

feature -- Query

	block (a_block_id: READABLE_STRING_8): detachable CMS_CUSTOM_BLOCK
		local
			bk: CMS_CUSTOM_BLOCK
		do
			if attached internal_blocks as l_blocks then
				Result := l_blocks [a_block_id]
			else
				if attached cms_api.module_configuration (module, module.Name) as cfg and then cfg.has_item ("blocks." + a_block_id) then
					bk := block_from_cfg (a_block_id, cfg)
				end
			end
		end

	blocks: STRING_TABLE [CMS_CUSTOM_BLOCK]
		local
			bk: CMS_CUSTOM_BLOCK
			l_name: READABLE_STRING_32
			l_block_id: READABLE_STRING_8
		do
			Result := internal_blocks
			if Result = Void then
				create Result.make_caseless (1)
				if attached cms_api.module_configuration (module, module.Name) as cfg and then attached cfg.table_keys ("blocks") as lst then
					across
						lst as ic
					loop
						l_name := ic.item
						if l_name.is_valid_as_string_8 then
							l_block_id := l_name.to_string_8
							if cfg.has_item ("blocks." + l_block_id) then
								bk := block_from_cfg (l_block_id, cfg)
								check
										not Result.has (bk.id)
								end
								Result [bk.id] := bk
							end
						end
					end
				end
				internal_blocks := Result
			end
		end

	block_template (a_block_id: READABLE_STRING_8): detachable CMS_SMARTY_TEMPLATE_BLOCK
		do
			Result := smarty_template_block (module, a_block_id, cms_api)
		end

feature {NONE} -- Implementation

	internal_blocks: detachable like blocks

	block_from_cfg (a_block_id: READABLE_STRING_8; cfg: attached like cms_api.module_configuration): CMS_CUSTOM_BLOCK
		require
				cfg.has_item (a_block_id)
		local
			l_block_pref: READABLE_STRING_8
		do
			create Result.make (a_block_id)
			l_block_pref := "blocks." + a_block_id
			if attached cfg.text_list_item (l_block_pref + ".conditions") as l_cond_expressions then
				across
					l_cond_expressions as exp_ic
				loop
					Result.add_condition_expression (exp_ic.item)
				end
			end
			if attached cfg.text_item (l_block_pref + ".region") as s and then s.is_valid_as_string_8 then
				Result.set_region (s.to_string_8)
			end;
			Result.set_weight (cfg.integer_item (l_block_pref + ".weight"));
			Result.set_title (cfg.text_item (l_block_pref + ".title"))
			if attached cfg.text_item (l_block_pref + ".is_raw") as l_is_raw then
				Result.set_is_raw (l_is_raw.is_case_insensitive_equal_general ("yes"))
			end
		end

end
