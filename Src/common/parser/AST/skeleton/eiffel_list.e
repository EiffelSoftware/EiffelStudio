indexing
	description: 
		"List used in abstract syntax trees."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LIST [T->AST_EIFFEL]

inherit
	AST_EIFFEL
		undefine
			copy, is_equal
		redefine
			is_equivalent
		end

	CONSTRUCT_LIST [T]
		export
			{ANY} area
		redefine
			make, make_filled
		end

creation {ARRAY_AS, TUPLE_AS, PARENT_AS, UN_STRIP_AS, FEATURE_CLAUSE_AS, AST_FACTORY, INDEXING_CLAUSE_AS, ROUTINE_AS}
	make, make_filled

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			{CONSTRUCT_LIST} Precursor (n)
			compare_objects
		end

	make_filled (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			{CONSTRUCT_LIST} Precursor (n)
			compare_objects
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_eiffel_list (Current)
		end

--feature -- Element change
--
--	merge_after_position (p: INTEGER; other: LIST [T]) is
--			-- Merge `other' after position `p', i.e. replace
--			-- items after `p' with items from `other'.
--		require
--			other_fits: other.count <= count - p
--		local
--			pos: INTEGER
--			cur: CURSOR
--		do
--			from
--				pos := p + 1
--				cur := other.cursor
--				other.start
--			until
--				pos = p + other.count + 1
--			loop
--				put_i_th (other.item, pos)
--				other.forth
--				pos := pos + 1
--			end
--
--			other.go_to (cur)
--		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			l_area, o_area: SPECIAL [T]
			i, nb: INTEGER
		do
			nb := other.count
			if count = nb then
				from
					l_area := area
					o_area := other.area
					Result := True
				until
					not Result or else i = nb
				loop
					Result := equivalent (l_area.item (i), o_area.item (i))
					i := i + 1
				end
			end
		end

--feature -- Comparison
--
--	is_equivalent (other: like Current): BOOLEAN is
--			-- Is `other' equivalent to the current object ?
--		local
--			i, nb: INTEGER
--		do
--			nb := other.count
--			if count = nb then
--				from
--					i := 1
--					Result := True
--				until
--					not Result or else i > nb
--				loop
--					Result := equivalent (i_th (i),
--						other.i_th (i))
--					i := i + 1
--				end
--			end
--		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		local
--			i, l_count: INTEGER;
--		do
--			ctxt.begin;
--			from
--				i := 1;
--				l_count := count;
--			until
--				i > l_count
--			loop
--				if i > 1 then
--					ctxt.put_separator;
--				end
--				ctxt.new_expression;
--				ctxt.begin;
--				i_th (i).simple_format (ctxt);
--				ctxt.commit;
--				i := i + 1
--			end
--			ctxt.commit;
--		end

end -- class EIFFEL_LIST

