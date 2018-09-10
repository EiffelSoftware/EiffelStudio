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
			-- Setup block `a_block` and perform additional setup on `a_respnse` if needed
			-- (such as linking with css, js, ...).
			--| To be redefined if needed.
		do
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
