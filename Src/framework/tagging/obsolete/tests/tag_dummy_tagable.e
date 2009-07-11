note
	description: "[
		Dummy {TAGABLE_I} used for unit tests.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_DUMMY_TAGABLE

inherit
	TAGABLE_I

create
	make

feature {NONE} -- Initialization

	make (a_name: like name)
			-- Initialize `Current'.
		do
			name := a_name
			create tags.make_default
		end

feature -- Access

	name: STRING
			-- <Precursor>

	tags: DS_HASH_SET [STRING]
			-- <Precursor>

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := name.hash_code
		end

	memento: TAGABLE_MEMENTO_I
			-- <Precursor>
		do
		end

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

	has_changed: BOOLEAN = False
			-- <Precursor>

feature -- Status setting

	clear_changes
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
