indexing
	description: "Perform validation of Eiffel identifiers"
	date: "$Date$"
	revision: "$Revision$"

class IDENTIFIER_CHECKER

feature -- Validity

	is_valid_first_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid for the first character of an Eiffel identifier?
		do
			Result := c.is_alpha
		ensure
			definition: Result = c.is_alpha
		end

	is_valid_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid for an Eiffel identifier?
		do
			Result := c.is_digit or c.is_alpha or c = '_'
		ensure
			definition: c.is_digit or c.is_alpha or c = '_'
		end
		
	is_valid (an_id: STRING): BOOLEAN is
			-- Is Current a valid Eiffel identifier?
		require
			an_id_not_void: an_id /= Void
		local
			i, nb: INTEGER;
			char: CHARACTER
		do
			if not an_id.is_empty and then is_valid_first_character (an_id.item(1)) then
				from
					Result := True
					nb := an_id.count
					i := 2
				until
					i > nb or else not Result
				loop
					char := an_id.item (i)
					Result := is_valid_character (an_id.item (i))
					i := i + 1
				end
			end
		ensure
			definition: not an_id.is_empty implies
				Result = is_valid_first_character (an_id.item (1))
					-- and for i in 2..an_id.count is_valid_character (an_id.item (i))
		end

end
