note
	description: "[
				Hook providing a way to provide blocks.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_BLOCK

inherit
	CMS_HOOK

feature -- Blocks

	block_list: detachable ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object.
			-- If prefixed by "?", condition will be checked
			-- to determine if it should be displayed (and computed) or not.
		deferred
		end

	block_identifiers (a_response: detachable CMS_RESPONSE): detachable ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object, in the context of `a_response' if set.
			-- If prefixed by "?", condition will be checked
			-- to determine if it should be displayed (and computed) or not.
		do
			Result := block_list
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
			-- Get block object identified by `a_block_id' and associate with `a_response'.
			-- Warning: be carefully with caching, if `get_block_view` is altering `a_response`
			--		as linking with css, js ... It should be done in `setup_block_view`.
		deferred
		end

	setup_block (a_block: CMS_BLOCK; a_response: CMS_RESPONSE)
			-- Setup block `a_block` and perform additional setup on `a_response` if needed
			-- (such as linking with css, js, ...).
			--| To be redefined if needed.
		do
		end

	clear_block_caches (a_block_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_cms_api: CMS_API)
			-- Clear cache for block `a_block_id_list' if set,
			-- otherwise clear all block caches if `a_block_id_list' is Void.
		local
			p: PATH
			l_cache: CMS_FILE_STRING_8_CACHE
			l_id, s: READABLE_STRING_GENERAL
			l_found: BOOLEAN
		do
			p := a_cms_api.cache_location.extended ("_blocks")
			if a_block_id_list /= Void and attached block_list as l_ids then
				across
					a_block_id_list as ic
				loop
					l_id := ic.item
					if not l_id.is_whitespace and l_id[1] = '?' then
						l_id := l_id.substring (2, l_id.count)
					end
					l_found := False
					across
						l_ids as ids_ic
					until
						l_found
					loop
						s := ids_ic.item
						if not s.is_whitespace and then s[1] = '?' then
							s := s.substring (2, s.count)
						end
						l_found := s.is_case_insensitive_equal (l_id)
					end
					if l_found then
						create l_cache.make (p.extended (l_id).appended_with_extension ("html"))
						if l_cache.exists then
							l_cache.delete
						end
					end
				end
			elseif attached block_identifiers (Void) as lst then
				clear_block_caches (lst, a_cms_api)
			end
		end

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
