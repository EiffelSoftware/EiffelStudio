indexing

	description: 
		"List used in abstract syntax trees.";
	date: "$Date$";
	revision: "$Revision $"

class LACE_LIST [T->AST_LACE]

inherit
	AST_LACE
		undefine 
			copy, is_equal
		redefine
			adapt
		end

	CONSTRUCT_LIST [T]
		rename
			duplicate as construct_list_duplicate
		end

creation
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
				st.new_line
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
					st.putstring (sep)
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
				st.putstring (sep)
				i := i + 1
			end
		end

end -- class LACE_LIST [T->AST_LACE]
