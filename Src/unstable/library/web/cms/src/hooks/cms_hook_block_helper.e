note
	description: "Summary description for {CMS_HOOK_BLOCK_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_BLOCK_HELPER

feature -- Factory	

	template_block (a_module: CMS_MODULE; a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id' in the context of `a_module' and `a_response'.
		local
			res: PATH
			p: detachable PATH
		do
			create res.make_from_string ("templates")
			res := res.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")
			p := a_response.module_resource_path (a_module, res)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
		end

end
