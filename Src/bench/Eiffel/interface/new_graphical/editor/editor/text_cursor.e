indexing
	description: "Item of a 2-3-4 tree"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_CURSOR

inherit
	TREE_ITEM
		rename
			make as shnoggle
		end

create
	make, make_from_string

feature -- Initialization

	make is
		do
			create tokens.make
		end

	make_from_string (s: STRING) is
		local
			i, j: INTEGER
			alphanum: BOOLEAN
			c: CHARACTER
--			s_aux: STRING
			tok: TEXT_TOKEN
		do
			make
			if s.count > 0 then
				from
					i := 2
					j := 1
--					c := s @ 1
--					alphanum := ((c).is_alpha or else (c).is_digit)
					alphanum := ((s @ 1).is_alpha or else (s @ 1).is_digit)
--					s_aux := c.out
				until
					i > s.count
				loop
					c := (s @ i)
					if alphanum /= (c.is_alpha or else c.is_digit) then
--					if alphanum /= ((s @ i).is_alpha or else (s @ i).is_digit) then
						alphanum := not alphanum
						create tok.make (s.substring (j, i-1))
--						create tok.make (s_aux)
						append_token (tok)
						j := i
--						s_aux := c.out
--					else
--						s_aux.append_character (c)
					end
					i := i+1
				end
				create tok.make (s.substring (j, s.count))
--				create tok.make (s_aux)
				append_token (tok)
			end
		end

feature -- Access

	pos_in_token: INTEGER

	token: TEXT_TOKEN

	line: TEXT_LINE

	paragraph: PARAGRAPH

	x_in_characters: INTEGER is
		do
			from
				line.tokens.start
			until
				line.tokens = token
			loop
				Result := Result + tokens.item.length
				tokens.forth
			end
			Result := Result += pos_in_token
		end

	x_theoric_in_characters: INTEGER

	y_in_lines: INTEGER

end -- class TEXT_CURSOR
