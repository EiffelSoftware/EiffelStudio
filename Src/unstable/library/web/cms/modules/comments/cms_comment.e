note
	description: "[
				Comment object.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_COMMENT

inherit
	ITERABLE [CMS_COMMENT]
		undefine
			is_equal
		end

	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current profile.
		do
			create {ARRAYED_LIST [CMS_COMMENT]} items.make (0)
			create modification_date.make_now_utc
			creation_date := modification_date
		end

feature -- Access

	id: INTEGER_64 assign set_id
			-- Unique id.
			--| Should we use NATURAL_64 instead?

	content: detachable READABLE_STRING_32

	format: detachable READABLE_STRING_8

	author: detachable CMS_USER

	author_name: detachable READABLE_STRING_32
			-- Author name if no CMS user is associated.

	creation_date: DATE_TIME
			-- When the comment was created.

	modification_date: DATE_TIME
			-- When the comment was updated.

	status: INTEGER
			-- Status of Current comment.

	parent: detachable CMS_COMMENT

	entity: detachable CMS_CONTENT
			-- Associated content.

feature -- Access

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	new_cursor: ITERATION_CURSOR [CMS_COMMENT]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Optional

	items: LIST [CMS_COMMENT]

	extend (c: CMS_COMMENT)
		do
			items.extend (c)
		end

	count: INTEGER
		do
			Result := items.count
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := creation_date < other.creation_date
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			Result.append_character ('#')
			Result.append_integer_64 (id)
			if attached content as l_content then
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (l_content.head (25))
				if l_content.count > 25 then
					Result.append ("...")
				end
				Result.append_character ('%"')
			end
		end

feature -- Change

	set_id (a_id: like id)
		require
			a_id_positive: a_id > 0
		do
			id := a_id
		end

	set_content (s: like content)
		do
			content := s
		end

	set_format (f: like format)
		do
			format := f
		end

	set_author (u: detachable CMS_USER)
		do
			author := u
		end

	set_author_name (n: like author_name)
		do
			author_name := n
		end

	set_creation_date (dt: DATE_TIME)
		do
			creation_date := dt
		end

	set_modification_date (dt: DATE_TIME)
		do
			modification_date := dt
		end

	set_status (st: like status)
		do
			status := st
		end

	set_parent (p: detachable CMS_COMMENT)
		do
			parent := p
		end

	set_entity (e: like entity)
		do
			entity := e
		end


;note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
