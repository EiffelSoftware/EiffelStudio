note
	description: "[
				User profile used to extend information associated with a {CMS_USER}.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_PROFILE

inherit
	TABLE_ITERABLE [READABLE_STRING_32, READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current profile.
		do
			create items.make (0)
		end

feature -- Access

	item alias "[]" (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Profile item associated with key `k`.
		do
			Result := items.item (k)
		end

	has_key (k: READABLE_STRING_GENERAL): BOOLEAN
			-- Has a profile item associated with key `k`?
		do
			Result := items.has (k)
		end

	count: INTEGER
		do
			Result := items.count
		end

	is_empty: BOOLEAN
		do
			Result := items.is_empty
		end

feature -- Change

	force (v: READABLE_STRING_GENERAL; k: READABLE_STRING_GENERAL)
			-- Associated value `v` with key `k`.
		do
			items.force (v.to_string_32, k)
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [READABLE_STRING_32, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature {NONE} -- Implementation				

	items: STRING_TABLE [READABLE_STRING_32]

;note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
