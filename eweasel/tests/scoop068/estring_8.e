note
	description: "{ESTRING_8} is an expanded, immutable 8-bit string. It defaults to an empty string."
	author: "Mischael Schill"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ESTRING_8

inherit
	ANY
		redefine
			out,
			default_create,
			is_equal
		end

create
	make_from_string_8, default_create

feature {NONE} -- Initialization

	default_create
		do
		end

	make_from_string_8 (a_string: READABLE_STRING_GENERAL)
		require
			a_string.is_valid_as_string_8
		local
			i: INTEGER
			l_string: MANAGED_POINTER
		do
			create l_string.make (a_string.count + 1)
			from
				i := 1
			until
				i > a_string.count
			loop
				l_string.put_character (a_string [i].to_character_8, i - 1)
				i := i + 1
			end
			make_from_area (create {EAREA}.copy_from_pointer (l_string.item, l_string.count))
		end

	make_from_area (a_area: EAREA)
		do
			area := a_area
		end

feature -- Access

	item alias "[]" (i: INTEGER): CHARACTER_8
		require
			valid_index: valid_index (i)
		do
			Result := area.read_character (i - 1)
		end

	area: EAREA

feature -- Status report

	is_empty: BOOLEAN
			-- Is structure empty?
		do
			Result := count = 0
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index?
		do
			Result := i > 0 and i <= count
		end

	is_valid_as_string_8: BOOLEAN
			-- Is `Current' convertible to a sequence of CHARACTER_8 without information loss?
		local
			i: INTEGER
			l_area: STRING_8
		do
			Result := True
		end

	is_equal (a_other: like Current): BOOLEAN
		local
			l_count: INTEGER
			l_other_area, l_area: like area
		do
			Result := area ~ a_other.area
		end

	is_less alias "<" (a_other: like Current): BOOLEAN
		local
			i: INTEGER
			c1, c2: CHARACTER_8
			break: BOOLEAN
		do
				-- NOTE: It fails even faster when this code is enabled.
			(create {MEMORY}).full_collect

			from
				i := 1
			until
				i > count or else i > a_other.count or else item (i) /= a_other.item (i)
			loop
				i := i + 1
			end
			if count = 0 and a_other.count = 0 then
				Result := False
			elseif i > count and i > a_other.count then
				Result := item (i - 1) < a_other.item (i - 1)
			elseif i > count then
				Result := True
			elseif i > a_other.count then
				Result := False
			else
				Result := item (i) < a_other.item (i)
			end
		end

feature -- Measurement

	count: INTEGER
		do
			Result := (area.count - 1).max (0)
		end

	capacity: INTEGER
		do
			Result := count
		end

feature -- Conversion

	to_string_8: STRING_8
		require
			is_valid_as_string_8: is_valid_as_string_8
		local
			i: INTEGER
		do
			create Result.make (count)
			from
				i := 1
			until
				i > count
			loop
				Result.extend (item (i))
				i := i + 1
			end
		ensure
			as_string_8_not_void: Result /= Void
			identity: (conforms_to ("") and Result = Current) or (not conforms_to ("") and Result /= Current)
		end

	out: STRING_8
		do
			Result := to_string_8
		end

invariant
		-- NOTE: The test usually fails when this invariant is active.
	irreflexive_comparison: not (Current < Current)
end
