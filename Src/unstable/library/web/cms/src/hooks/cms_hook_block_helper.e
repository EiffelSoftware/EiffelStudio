note
	description: "Summary description for {CMS_HOOK_BLOCK_HELPER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_BLOCK_HELPER

feature {NONE} -- Factory	

	smarty_template_block (a_module: CMS_MODULE; a_block_id: READABLE_STRING_8; a_cms_api: CMS_API): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id' in the context of `a_module' and `a_cms_api'.
		local
			res: PATH
			p: detachable PATH
		do
			create res.make_from_string ("templates")
			res := res.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")
			p := a_cms_api.module_theme_resource_location (a_module, res)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
		end

	smarty_template_block_with_values (a_module: CMS_MODULE; a_block_id: READABLE_STRING_8; a_cms_api: CMS_API; a_values: STRING_TABLE [ANY]): like smarty_template_block
			-- Smarty content block for `a_block_id' in the context of `a_module' and `a_cms_api',
			-- With additional `a_values'.
		do
			Result := smarty_template_block (a_module, a_block_id, a_cms_api)
			if Result /= Void then
				across
					a_values as ic
				loop
					Result.set_value (ic.item, ic.key)
				end
			end
		end

feature {NONE} -- Factory: obsolete

	template_block (a_module: CMS_MODULE; a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id' in the context of `a_module' and `a_response'.
		obsolete
			"Use smarty_template_block [2017-05-31]"
		do
			Result := smarty_template_block (a_module, a_block_id, a_response.api)
		end

	template_block_with_values (a_module: CMS_MODULE; a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE; a_values: STRING_TABLE [ANY]): like smarty_template_block
			-- Smarty content block for `a_block_id' in the context of `a_module' and `a_response',
			-- With additional `a_values'.
		obsolete
			"Use smarty_template_block_with_values [2017-05-31]"
		do
			Result := smarty_template_block_with_values (a_module, a_block_id, a_response.api, a_values)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
