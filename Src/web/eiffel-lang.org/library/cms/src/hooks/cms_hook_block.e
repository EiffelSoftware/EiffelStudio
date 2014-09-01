note
	description: "Summary description for {CMS_HOOK_BLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_BLOCK

inherit
	CMS_HOOK

feature -- Hook

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		deferred
		end

	get_block_view (a_block_id: detachable READABLE_STRING_8; a_execution: CMS_EXECUTION)
		deferred
		end

end
