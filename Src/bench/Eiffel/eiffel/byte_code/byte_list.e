-- List used in the byte code generation.
-- Defines some of the commonly used iterations.

class BYTE_LIST [T -> BYTE_NODE] 

inherit
	BYTE_NODE
		undefine
			copy, is_equal
		redefine
			enlarge_tree, analyze, generate, generate_il, make_byte_code,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code, has_separate_call
		end

	FIXED_LIST [T]
		export
			{ANY} area
		end

creation
	make, make_filled

feature -- Code analyzis

	analyze is
			-- Loop over `list' and analyze each item
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).analyze
				i := i + 1
			end
		end

feature -- C generation

	generate is
			-- Loop over `list' and generate each item
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).generate
				i := i + 1
			end
		end

feature -- IL code generation

	generate_il is
			-- Loop over `list' and generate IL code for each item
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).generate_il
				i := i + 1
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generates byte code for element in the list
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).make_byte_code (ba)
				i := i + 1
			end
		end

feature -- Tree enlargment

	enlarge_tree is
			-- Loop ovet `list' and enlarges each item
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
			l_item: T
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_item := l_area.item (i)
				if l_item.need_enlarging then
					l_area.put (l_item.enlarged, i)
				else
					l_item.enlarge_tree
				end
				i := i + 1
			end
		end

feature -- Array optimization

	assigns_to (n: INTEGER): BOOLEAN is
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				Result or else i = nb
			loop
				Result := l_area.item (i).assigns_to (n)
				i := i + 1
			end
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				Result or else i = nb
			loop
				Result := l_area.item (i).calls_special_features (array_desc)
				i := i + 1
			end
		end

	is_unsafe: BOOLEAN is
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				Result or else i = nb
			loop
				Result := l_area.item (i).is_unsafe
				i := i + 1
			end
		end

	optimized_byte_node: like Current is
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			Result := Current
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.put (l_area.item (i).optimized_byte_node, i)
				i := i + 1
			end
		end

feature -- Inlining

	size: INTEGER is
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				Result := Result + l_area.item (i).size
				i := i + 1
			end
		end

	pre_inlined_code: like Current is
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			Result := Current
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.put (l_area.item (i).pre_inlined_code, i)
				i := i + 1
			end
		end

	inlined_byte_code: like Current is
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			Result := Current
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.put (l_area.item (i).inlined_byte_code, i)
				i := i + 1
			end
		end

feature -- Convenience

	remove_voids: like Current is
		local
			nbr_void: INTEGER
			l_area, r_area: SPECIAL [T]
			i, j, nb: INTEGER
			l_item: T
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				if (l_area.item (i) = Void) then
					nbr_void := nbr_void + 1
				end
				i := i + 1
			end

			if (nbr_void < count) then
				--| Not all elements are void
				if nbr_void > 0 then
					--| Remove the void elements
					from
						!! Result.make_filled (count - nbr_void)
						r_area := Result.area
						i := 0
					until
						i = nb
					loop
						l_item := l_area.item (i)
						if (l_item /= Void) then
							r_area.put (l_item, j)
							j := j + 1
						end
						i := i + 1
					end
				else
					--| There are no void elements
					Result := Current
				end
			end
		end

feature -- Concurrent Eiffel

	has_separate_call: Boolean is
			-- Loop over `list' and determine is there is a separate
			-- call
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				Result or i = nb
			loop
				Result := l_area.item (i).has_separate_call
				i := i + 1
			end
		end

end
