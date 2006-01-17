indexing

	description: 
		"List used in abstract syntax trees."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class LACE_LIST [T->AST_LACE]

inherit
	AST_LACE
		undefine 
			copy, is_equal
		redefine
			adapt, adapt_defaults
		end

	ARRAYED_LIST [T]
		rename
			duplicate as construct_list_duplicate
		end

create
	make, make_filled

feature {COMPILER_EXPORTER}

	adapt is
			-- Adaptation iteration
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).adapt
				i := i + 1
			end
		end

	adapt_defaults is
			-- Adaptation iteration for system default clause to current.
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).adapt_defaults
				i := i + 1
			end
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			create Result.make (count)
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				Result.extend (l_area.item (i).duplicate)
				i := i + 1
			end
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			nb := count
			if nb = other.count then
				from
					Result := True
					l_area := area
					nb := count
				until
					i = nb or not Result
				loop
					Result := same_ast (l_area.item (i), other.i_th (i + 1))
					i := i + 1
				end
			end
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st' separated by new lines.
		do
			save_with_new_line (st)
		end

	save_with_new_line (st: GENERATION_BUFFER) is
			-- Save current in `st' separated by new lines.
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			from
				l_area := area
				nb := count;
			until
				i = nb
			loop
				l_area.item (i).save (st)
				st.put_new_line
				i := i + 1
			end
		end

	save_with_interval_separator (st: GENERATION_BUFFER; sep: STRING) is
			-- Save current in `st' separated by `sep' execpt for
			-- last element.
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			from
				l_area := area
				nb := count;
			until
				i = nb
			loop
				l_area.item (i).save (st)
				i := i + 1

				if i /= nb then
					st.put_string (sep)
				end
			end
		end

	save_with_separator (st: GENERATION_BUFFER; sep: STRING) is
			-- Save current in `st' separated by `sep'.
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			from
				l_area := area
				nb := count;
			until
				i = nb
			loop
				l_area.item (i).save (st)
				st.put_string (sep)
				i := i + 1
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class LACE_LIST [T->AST_LACE]
