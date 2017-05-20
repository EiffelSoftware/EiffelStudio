note
	description: "[
			CMS HOOK providing a way to export module data according to specific export parameters.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_EXPORT

inherit
	CMS_HOOK

feature -- Hook	

	export_to (a_export_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_export_ctx: CMS_EXPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Export data identified by `a_export_id_list',
			-- or export all data if `a_export_id_list' is Void.
		deferred
		end

--	export_identifiers: detachable ITERABLE [READABLE_STRING_GENERAL]
--			-- Optional list of exportation ids, if any.
--		do
--				-- To redefine if needed.
--		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
