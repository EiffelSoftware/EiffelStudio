note
	description: "[
			Taxonomy vocabulary term.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TERM

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make,
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_id: INTEGER_64; a_text: READABLE_STRING_GENERAL)
		do
			id := a_id
			make (a_text)
		end

	make (a_text: READABLE_STRING_GENERAL)
		do
			set_text (a_text)
		end

feature -- Access

	id: INTEGER_64
			-- Associated term id.

	text: IMMUTABLE_STRING_32
			-- Text for the term.

	description: detachable IMMUTABLE_STRING_32
			-- Optional description.

	weight: INTEGER
			-- Associated weight for ordering.

feature -- Status report

	has_id: BOOLEAN
			-- Has valid id?
		do
			Result := id > 0
		end

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			Result.append_character ('#')
			Result.append (id.out)
			Result.append_character (' ')
			Result.append (text)
			Result.append_character (' ')
			Result.append ("weight=")
			Result.append_integer (weight)
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if weight = other.weight then
				if text.same_string (other.text) then
					Result := id < other.id
				else
					Result := text < other.text
				end
			else
				Result := weight < other.weight
			end
		end

feature -- Element change

	set_id (a_id: INTEGER_64)
		do
			id := a_id
		end

	set_text (a_text: READABLE_STRING_GENERAL)
		do
			create text.make_from_string_general (a_text)
		end

	set_weight (w: like weight)
		do
			weight := w
		end

	set_description (a_description: READABLE_STRING_GENERAL)
		do
			create description.make_from_string_general (a_description)
		end

end

