indexing
	description:
		"Comparator for character sets"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"
	usage: "The features 'define', 'add' and 'remove' accept a string as%
		   %argument that represents a set of single character (like 'a')%
		   %or character ranges (like 'a-z'). To use a character with a%
		   %special meaning (like '-') as single character, it can be quoted%
		   %using the character '\'"

class CHARACTER_SET inherit

	COMPARATOR_BUILDER

feature -- Access

	set: STRING is
			-- Current character set
		require
			not_empty: not is_empty
		local
			old_idx: INTEGER
		do
			old_idx := comparators.index
			create Result.make (10)
			from
				comparators.start
			until
				comparators.after
			loop
				Result.append (comparators.item.character_set)
				comparators.forth
			end
			comparators.go_i_th (old_idx)
		ensure
			index_unchanged: comparators.index = old comparators.index
		end

	has (token: STRING): BOOLEAN is
			-- Is there a comparator for `token'?
		require
			non_empty_token: token /= Void and then not token.is_empty
		local
			old_idx: INTEGER
		do
			old_idx := comparators.index
			from
				comparators.start
			until
				comparators.after or Result
			loop
				Result := equal (comparators.item.character_set, token)
				comparators.forth
			end
			comparators.go_i_th (old_idx)
		ensure
			index_unchanged: comparators.index = old comparators.index
		end

	contains_string (s: STRING): BOOLEAN is
			-- Does character set contain string `s'?
		require
			not_empty: not is_empty
			string_exists: s /= Void
		local
			i: INTEGER
			str: STRING
		do
			if not s.is_empty then
				str := clone (s)
				remove_duplicate_characters (str)
				from
					i := 1
					Result := True
				variant
					str.count + 1 - i
				until
					not Result or i = str.count + 1
				loop
					Result := contains_character (str.item (i))
					i := i + 1
				end
			else
				Result := True
			end
		end

	contains_character (c: CHARACTER): BOOLEAN is
			-- Does character set contain character `c'?
		require
			not_empty: not is_empty
		local
			old_idx: INTEGER
		do
			old_idx := comparators.index
			from
				comparators.start
			until
				Result or comparators.after
			loop
				Result := comparators.item.contains (c)
				comparators.forth
			end
			comparators.go_i_th (old_idx)
		ensure
			index_unchanged: comparators.index = old comparators.index
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is character set empty?
		do
			Result := comparators = Void or else comparators.is_empty
		end
		
feature -- Status setting

	define (s: STRING) is
			-- Define character set.
		require
			string_exists: s /= Void
		local
			str: STRING
		do
			str := clone (s)
			comparator_builder.define_set (str)
			comparator_builder.build
			comparators := clone (comparator_builder.comparators)
		ensure
			comparators_set_up: comparators /= Void and then not
						comparators.is_empty
		end

feature -- Element change

	add (s: STRING) is
			-- Add `s' to character set.
		require
			non_empty_string: s /= Void and then not s.is_empty
			no_such_comparator: not has (s)
		do
			comparator_builder.add (s)
			comparator_builder.build
			comparators := clone (comparator_builder.comparators)
		ensure
			elements_added: comparators.count >= old comparators.count
		end
		
feature -- Removal

	remove (s: STRING) is
			-- Remove `s' from character set.
		require
			non_empty_string: s /= Void and then not s.is_empty
			has_comparator: has (s)
		do
			comparator_builder.remove (s)
			comparator_builder.build
			comparators := clone (comparator_builder.comparators)
		ensure
			elements_removed: comparators.count <= old comparators.count
		end
		
feature {NONE} -- Implementation

	comparators: LINKED_SET[COMPARATOR]

	remove_duplicate_characters (s: STRING) is
			-- Remove duplicate characters from `s'.
		require
			string_exists: s /= Void and then not s.is_empty
		local
			i: INTEGER
			newstr: STRING
			c: CHARACTER
			ch_set: BINARY_SEARCH_TREE_SET[CHARACTER]
		do
			from
				i := 1
				create ch_set.make
				create newstr.make (s.count)
			variant
				s.count + 1 - i
			until
				i = s.count + 1
			loop
				c := s.item (i)
				if not ch_set.has (c) then
					newstr.extend (c)
					ch_set.extend (c)
				end
				i := i + 1
			end
			s.copy (newstr)
		ensure
			-- no_duplicates: For every `i' in 1 .. s.count, 
			-- s.occurences (s.item (i)) 
		end

end -- class CHARACTER_SET


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

