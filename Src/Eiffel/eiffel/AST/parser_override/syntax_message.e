indexing
	description: "To represent a message related to syntax."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	display_line (a_text_formatter: TEXT_FORMATTER; a_line: STRING) is
			-- Display `a_line' in `a_text_formatter'. It translates `%T' accordingly to `a_text_formatter' specification
			-- which is to call `add_indent'.
		require
			st_not_void: a_text_formatter /= Void
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
						a_text_formatter.add (" ")
						a_text_formatter.add (" ")
						a_text_formatter.add (" ")
						a_text_formatter.add (" ")
					else
						a_text_formatter.add (c.out)
					end
				end
				a_text_formatter.add_new_line
			end
		end

	display_syntax_line (a_text_formatter: TEXT_FORMATTER; a_line: STRING) is
			-- Display `a_line' which does like `display_line' but with an additional
			-- arrowed line that points out to `column' where syntax issue is located.
		require
			st_not_void: a_text_formatter /= Void
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
					a_text_formatter.add (" ")
					a_text_formatter.add (" ")
					a_text_formatter.add (" ")
					a_text_formatter.add (" ")
					if i <= column then
						nb_tab := nb_tab + 1
					end
				else
					a_text_formatter.add (c.out)
				end
			end
			a_text_formatter.add_new_line
			if column > 0 then
				position := (column - 1) + 3 * nb_tab
			else
				position := 3 * nb_tab
			end
			if position = 0 then
				a_text_formatter.add ("^---------------------------")
				a_text_formatter.add_new_line
			else
				from
					i := 1
				until
					i > position
				loop
					a_text_formatter.add ("-")
					i := i + 1
				end
				a_text_formatter.add ("^")
				a_text_formatter.add_new_line
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SYNTAX_MESSAGE
