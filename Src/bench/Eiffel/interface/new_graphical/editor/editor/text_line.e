indexing
	description: "Item of a 2-3-4 tree"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_LINE

inherit
	TREE_ITEM
		rename
			tree as paragraph
		redefine
			paragraph
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

	tokens: LINKED_LIST [TEXT_TOKEN]

	length: INTEGER is
		do
			from
				tokens.start
			until
				tokens.after
			loop
				Result := Result + tokens.item.length
				tokens.forth
			end
		end

	paragraph: PARAGRAPH

	order_in_paragraph: INTEGER

feature -- Element change

	append_token (t: TEXT_TOKEN) is
		do
			tokens.extend (t)
		end

feature -- Basic Operations

	list is
		do
			from
				tokens.start
			until
				tokens.after
			loop
				io.put_string (tokens.item.value)
				tokens.forth
			end
			io.new_line
		end

end -- class TEXT_LINE
