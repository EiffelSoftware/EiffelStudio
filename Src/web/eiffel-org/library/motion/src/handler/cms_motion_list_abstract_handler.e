note
	description: "Summary description for {CMS_MOTION_LIST_ABSTRACT_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MOTION_LIST_ABSTRACT_HANDLER

inherit

	CMS_MODULE_HANDLER [CMS_MOTION_API]
		rename
			module_api as motion_api
		end

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

feature {NONE} -- Helpers

	template_block (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id'
		local
			p: detachable PATH
		do
			create p.make_from_string ("templates")
			p := p.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location_by_name (motion_api.name, p)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
			if Result /= Void then
				Result.set_value (motion_api.resource_path, "resource_path")
				Result.set_value (motion_api.name, "module_name")
				Result.set_value (motion_api.item, "module_item")
			end
		end

feature {NONE} -- Block views

	get_block_view_login (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if attached template_block (a_block_id, a_response) as l_tpl_block then
				a_response.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				end
			end
		end



end
