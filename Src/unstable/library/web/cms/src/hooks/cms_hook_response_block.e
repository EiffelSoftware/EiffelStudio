note
	description: "[
				Hook providing a way to provide blocks,
				within the context of a response.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_RESPONSE_BLOCK

inherit
	CMS_HOOK_BLOCK
		rename
			block_identifiers as old_block_identifiers
		redefine
			old_block_identifiers
		end

feature -- Hook

	frozen block_list: detachable ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object.
			-- If prefixed by "?", condition will be checked
			-- to determine if it should be displayed (and computed) or not.
		do
			Result := block_identifiers (Void)
		end

	frozen old_block_identifiers (a_response: detachable CMS_RESPONSE): detachable ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := block_identifiers (a_response)
		end

	block_identifiers (a_response: detachable CMS_RESPONSE): detachable ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object, in the context of `a_response' if set.
			-- If prefixed by "?", condition will be checked
			-- to determine if it should be displayed (and computed) or not.
		deferred
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
