indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- List used in the byte code generation.
-- Defines some of the commonly used iterations.

class BYTE_LIST [reference T -> BYTE_NODE]

inherit
	BYTE_NODE
		undefine
			copy, is_equal
		redefine
			enlarge_tree, analyze, generate,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code
		end

	FIXED_LIST [T]
		export
			{ANY} area
		end

create
	make, make_filled

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_byte_list (Current)
		end

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
						create Result.make_filled (count - nbr_void)
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

end
