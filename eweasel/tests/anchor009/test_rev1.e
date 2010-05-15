class
	TEST

inherit
	COMPARABLE

create
	make

feature

	make
		do
		end

feature
	domain: detachable TEST1 [CHARACTER]

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
		-- Is current object less than `other'?
	local
		cursor, other_cursor: like domain.new_cursor
--		cursor, other_cursor: ITERATION_CURSOR[CHARACTER]
		exit: BOOLEAN
	do
		from
			cursor := domain.new_cursor
			other_cursor := other.domain.new_cursor
		until
			exit or cursor.after or other_cursor.after
		loop
			if cursor.item < other_cursor.item then
				result := true
				exit := true
			elseif other_cursor.item < cursor.item then
				result := false
				exit := true
			end
		end

		if not exit then
			result := (cursor.after and not other_cursor.after)
		end
	end




--note removed: "[
--
--note
--	description: "Summary description for {CONSUMER}."
--	author: "David Le Bansais"
--
--class
--	CONSUMER
--
--inherit
--	CHARACTER_SET
--		rename
--			make_empty as make_empty_character_set,
--			to_string as character_set_to_string
--		redefine
--			make,
--			is_equal,
--			copy
--		end
--
--	RECURSION
--		rename
--			make as make_recursion,
--			make_empty as make_empty_recursion,
--			to_string as recursion_to_string
--		redefine
--			is_equal,
--			copy
--		end
--
--create
--	make_from_unrepeated
--
--create {CONSUMER}
--	make
--
--feature -- Merging of base class features
--
--	make
--	do
--		create nested_grammar_name.make_empty
--		precursor
--	end
--
--	is_equal (other: like current): BOOLEAN
--	do
--		result := precursor{CHARACTER_SET}(other) and precursor{RECURSION}(other)
--	end
--
--	is_charset_equal (other: CHARACTER_SET): BOOLEAN
--	local
--		current_copy, other_copy: CHARACTER_SET
--	do
--		create current_copy.make_from_list_with_type(current, current.negated)
--		current_copy.modify_repetition(current)
--		create other_copy.make_from_list_with_type(other, other.negated)
--		other_copy.modify_repetition(other)
--
--		result := current_copy.is_equal(other_copy)
--	end
--
--	is_recursion_equal (other: RECURSION): BOOLEAN
--	local
--		current_copy, other_copy: RECURSION
--	do
--		create current_copy.make_from_other(current)
--		create other_copy.make_from_other(other)
--		result := current_copy.is_equal(other_copy)
--	end
--
--	copy (other: like current)
--	do
--		precursor{CHARACTER_SET}(other)
--		precursor{RECURSION}(other)
--	end
--
--feature -- Debugging
--
--	to_string: STRING_32
--	do
--		result := ""
--	end
--
--]"

end
