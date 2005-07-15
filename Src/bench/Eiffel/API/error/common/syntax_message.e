indexing
	description: "To represent a message related to syntax."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SYNTAX_MESSAGE

feature -- Properties

	file_name: STRING is
			-- Path to file where syntax issue happened
		deferred
		end

	line: INTEGER is
			-- Line number of token involved in syntax issue
		deferred
		end

	column: INTEGER is
			-- Column number of token involved in syntax issue
		deferred
		end

feature {NONE} -- Output

	display_line (st: STRUCTURED_TEXT; a_line: STRING) is
			-- Display `a_line' in `st'. It translates `%T' accordingly to `st' specification
			-- which is to call `add_indent'.
		require
			st_not_void: st /= Void
		local
			i: INTEGER
			nb: INTEGER
			c: CHARACTER
		do
			if a_line /= Void then
				from
					nb := a_line.count
				until
					i = nb
				loop
					i := i + 1
					c := a_line.item (i)
					if c = '%T' then
						st.add_string (" ")
						st.add_string (" ")
						st.add_string (" ")
						st.add_string (" ")
					else
						st.add_string (c.out)
					end
				end
				st.add_new_line
			end
		end

	display_syntax_line (st: STRUCTURED_TEXT; a_line: STRING) is
			-- Display `a_line' which does like `display_line' but with an additional
			-- arrowed line that points out to `column' where syntax issue is located.
		require
			st_not_void: st /= Void
			a_line_not_void: a_line /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
			position, nb_tab: INTEGER
		do
			from
				nb := a_line.count
			until
				i = nb
			loop
				i := i + 1
				c := a_line.item (i)
				if c = '%T' then
					st.add_string (" ")
					st.add_string (" ")
					st.add_string (" ")
					st.add_string (" ")
					if i <= column then
						nb_tab := nb_tab + 1
					end
				else
					st.add_string (c.out)
				end
			end
			st.add_new_line
			if column > 0 then
				position := (column - 1) + 3 * nb_tab
			else
				position := 3 * nb_tab
			end
			if position = 0 then
				st.add_string ("^---------------------------")
				st.add_new_line
			else
				from
					i := 1
				until
					i > position
				loop
					st.add_string ("-")
					i := i + 1
				end
				st.add_string ("^")
				st.add_new_line
			end
		end

end -- class SYNTAX_MESSAGE
