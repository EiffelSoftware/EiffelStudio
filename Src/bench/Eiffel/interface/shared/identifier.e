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
			definition: Result = (c.is_digit or c.is_alpha or c = '_')
		end
		
	is_valid (an_id: STRING): BOOLEAN is
			-- Is Current a valid Eiffel identifier?
		local
			i, nb: INTEGER
		do
			if
				an_id /= Void and then
				not an_id.is_empty and then is_valid_first_character (an_id.item(1))
			then
				from
					Result := True
					nb := an_id.count
					i := 2
				until
					i > nb or else not Result
				loop
					Result := is_valid_character (an_id.item (i))
					i := i + 1
				end
			end
		ensure
			definition: (an_id /= Void and then not an_id.is_empty) implies
				Result = (is_valid_first_character (an_id.item (1))
					and an_id.substring (2, an_id.count).linear_representation.for_all (
						agent is_valid_character))
		end

	is_valid_first_upper_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid for the first upper character of an Eiffel identifier?
		do
			Result := c.is_alpha and c.is_upper
		ensure
			definition: Result = (c.is_alpha and c.is_upper)
		end

	is_valid_upper_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid upper character for an Eiffel identifier?
		do
			Result := c.is_digit or (c.is_alpha and c.is_upper) or c = '_'
		ensure
			definition: Result = (c.is_digit or (c.is_alpha and c.is_upper) or c = '_')
		end

	is_valid_upper (an_id: STRING): BOOLEAN is
			-- Is Current a valid Eiffel identifier only made of upper case character.
		local
			i, nb: INTEGER
		do
			if
				an_id /= Void and then
				not an_id.is_empty and then is_valid_first_upper_character (an_id.item(1))
			then
				from
					Result := True
					nb := an_id.count
					i := 2
				until
					i > nb or else not Result
				loop
					Result := is_valid_upper_character (an_id.item (i))
					i := i + 1
				end
			end
		ensure
			definition: (an_id /= Void and then not an_id.is_empty) implies
				Result = (is_valid_first_upper_character (an_id.item (1))
					and an_id.substring (2, an_id.count).linear_representation.for_all (
						agent is_valid_upper_character))
		end

end
