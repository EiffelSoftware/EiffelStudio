indexing
	description:
		"Implementation of comparator builder"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class COMPARATOR_BUILDER_IMPL inherit

	ASCII
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create builder.
		do
			create character_array.make (0, 255)
			create comparators.make
		end

feature {NONE} -- Constants

	Single_character, Range: INTEGER is unique
			-- IDs for `token_type'
			
feature -- Access

	comparators: LINKED_SET[COMPARATOR]
			-- Set of comparators currently built

feature -- Status report

	is_set_defined: BOOLEAN is
			-- Has a character set been defined?
		do
			Result := not character_array.all_cleared
		end

	comparators_available: BOOLEAN is
			-- Is there a set of comparators available?
		do
			Result := not comparators.empty
		end
		
feature -- Status setting

	define_set (s: STRING) is
			-- Define character set.
		require
			non_empty_string: s /= Void and then not s.empty
		do
			comparators.wipe_out
			character_array.clear_all
			add (s)
		end

	add (s: STRING) is
			-- Add to character set.
		require
			non_empty_string: s /= Void and then not s.empty
		do
			from until s.empty loop
				fetch_token (s)
				if not last_token.empty then update_character_array (False) end
			end
		end
		
	remove (s: STRING) is
			-- Remove from character set.
		require
			non_empty_string: s /= Void and then not s.empty
		do
			from until s.empty loop
				fetch_token (s)
				if not last_token.empty then update_character_array (True) end
			end
		end

feature -- Basic operations

	build is
			-- Build comparators.
		require
			set_defined: is_set_defined
		local
			i: INTEGER
			last: BOOLEAN
			cur: BOOLEAN
			start: INTEGER
			count: INTEGER
		do
			from 
				i := 0 
			invariant
				bounds_ok: start <= i
			until 
				i = 256 
			loop
				cur := character_array @ i
				if i > 0 then 
					last := character_array @ (i - 1) 
				else 
					last := False
				end
				if last /= cur then
					if last = True then
						create_comparator 
							(start.ascii_char, start.ascii_char + count)
					end
					start := i
					count := 0
				else
					count := count + 1
				end
				i := i + 1
			end
			if character_array @ start = True then
				create_comparator (start.ascii_char, (255).ascii_char)
			end
		end

feature {NONE} -- Implementation

	last_token: STRING
			-- Last parsed token

	last_character: CHARACTER
			-- Last character fetched by `get_character'
			
	character_array: ARRAY[BOOLEAN]
			-- Array storing the state of each character

	update_character_array (remove_mode: BOOLEAN) is
			-- Update character array with `last_token'.
			-- (Reset state, if `remove_mode' is on.)
		require
			non_empty_token: last_token /= Void and then not last_token.empty
			token_ok: token_type /= 0
		local
			i: INTEGER
			lower: INTEGER
			upper: INTEGER
			val: BOOLEAN
			type: INTEGER
		do
			type := token_type
			val := not remove_mode
			inspect
				type
			when Single_character then
				lower := last_token.item (1).code
				character_array.put (val, lower)
			when Range then
				lower := last_token.item (1).code.min (last_token.item (3).code)
				upper := last_token.item (3).code.max (last_token.item (1).code)
					check
						bounds_ok: lower < upper
							-- Because `min' and `max' have been used before
					end
				from i := lower until i = upper + 1 loop
					character_array.put (val, i)
					i := i + 1
				end
			end
		end
		
	create_comparator (low, high: CHARACTER) is
			-- Create a comparator.
		require
			bounds_ok: low <= high
		local
			c: COMPARATOR
		do
			if high = low then
				create {SINGLE_CHARACTER_COMPARATOR} c.make (low)
			else
				create {RANGE_COMPARATOR} c.make (low, high)
			end
			comparators.extend (clone (c))
		ensure
			comparator_added: comparators.count = old comparators.count + 1
		end
		
	token_type: INTEGER is
			-- Type of token stored in `last_token'.
		do
			if 1 <= last_token.count and last_token.count <= 4 then
				if last_token.count = 1 then
					Result := Single_character
				elseif last_token.count = 3 and
					last_token.item (2) = '-' then
					Result := Range
				end
			end
		end

	fetch_token (tok: STRING) is
			-- Fetch next token from `tok'.
		require
			non_empty_token: tok /= Void and then not tok.empty
		local
			cur: CHARACTER
			next: CHARACTER
			quoted: BOOLEAN
			range_flag: BOOLEAN
			valid: BOOLEAN
		do
			from
				create last_token.make (4)
			until
				valid or tok.empty
			loop
				get_character (tok)
				cur := last_character
				if not tok.empty then 
					next := tok.item (1)
				else
					next := '%U'
				end
				if last_token.empty and cur = '-' and not quoted then
					tok.remove (1)
				end
				if tok.empty and 
					(cur = Backslash.ascii_char and not quoted) then 
					cur := '%U' 
				end
				if quoted then
					last_token.extend (last_character)
					valid := True
				end
				if not valid then
					if cur = Backslash.ascii_char and not quoted then 
						quoted := True
					elseif quoted then 
						quoted := False
					end
					if next = '-' and not quoted then
						range_flag := True
					else
						range_flag := False
					end
					if not quoted then last_token.extend (last_character) end
					if not range_flag and then token_type /= 0 then
						valid := True
					elseif tok.empty and not valid then
						last_token.wipe_out
					end
				end
			end
				check
					valid_token: not last_token.empty implies token_type /= 0
						-- Because the above algorithm always yields correct
						-- tokens
				end
		end

	get_character (s: STRING) is
			-- Get next character from `s'.
		require
			non_empty_string: s /= Void and then not s.empty
		do
			last_character := s.item (1)
			s.remove (1)
		end

invariant

	character_array_set_up: character_array /= Void
	comparators_set_up: comparators /= Void
	token_valid: (last_token /= Void and then not last_token.empty) implies
			token_type /= 0

end -- class COMPARATOR_BUILDER_IMPL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


