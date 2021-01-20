note
	description: "[
				User profile used to extend information associated with a {CMS_USER}.

				Any profile item with a key starting by "." will be considered internal,
				and thus not displayed under the user account view
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

	item alias "[]" (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32 assign set_item
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

	has_visible_items: BOOLEAN
			-- Has visible items?
		do
			Result := not is_empty and then
					across items as ic some not ic.item.starts_with (".") end
		end

feature -- Change

	set_item (v: detachable READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		do
			force (v, k)
		end

	force (v: detachable READABLE_STRING_GENERAL; k: READABLE_STRING_GENERAL)
			-- Associated value `v` with key `k`.
		do
			if v = Void then
				items.remove (k)
			else
				items.force (v.to_string_32, k)
			end
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
	copyright: "2011-2021, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
