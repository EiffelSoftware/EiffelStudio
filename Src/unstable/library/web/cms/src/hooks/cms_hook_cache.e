note
	description: "[
				Hook providing cache related management facilities.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_CACHE

inherit
	CMS_HOOK

feature -- Hook

	clear_cache (a_cache_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_response: CMS_RESPONSE)
			-- Clear caches identified by `a_cache_id_list',
			-- or clear all caches if `a_cache_id_list' is Void.
		deferred
		end

	cache_identifiers: detachable ITERABLE [like {CMS_BLOCK}.name]
			-- Optional list of cache id, if any.
		do
				-- To redefine if needed.
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
