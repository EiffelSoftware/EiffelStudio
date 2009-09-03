note
	description: "[
		List that collects all generic derivation of a generic class
		in current system.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TYPE_LIST

inherit
	ARRAYED_LIST [CLASS_TYPE]
		export
			{ANY} first, start, after, forth, item, is_empty, count,
				remove, cursor, go_to, wipe_out, extend, valid_index,
				valid_cursor, extendible, prunable, readable, index, off,
				writable
			{TYPE_LIST} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		undefine
			is_equal, copy
		end

create
	make

create {TYPE_LIST}
	make_filled

feature -- Search

	has_type (context_type, t: TYPE_A): BOOLEAN
			-- Is the type `t' present in instances of CLASS_TYPE in the
			-- list ?
		require
			type_not_void: t /= Void
		local
			l_area: like area
			l_item: like item
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count - 1
			until
				i > nb or Result
			loop
				l_item := l_area.item (i)
				Result := t.same_generic_derivation_as (context_type, l_item.type)
				i := i + 1
			end

			if Result then
				found_item := l_item
			else
				found_item := Void
			end
		ensure
			cursor_not_changed: index = old index
		end

	search_item (context_type, t: TYPE_A): CLASS_TYPE
			-- Is the type `t' resolved in `context_type' present in instances of CLASS_TYPE
			-- in the list? If not, return the last item found in the list.
		require
			type_not_void: t /= Void
			has_type: has_type (context_type, t)
		do
			if has_type (context_type, t) then
				Result := found_item
			end
		ensure
			cursor_not_changed: index = old index
			result_not_void: Result /= Void
		end

feature -- Access

	found_item: CLASS_TYPE
			-- Last item found during a search.

	nb_modifiable_types: INTEGER
			-- Number of modifiable types (i.e. precompiled or static)
			-- derived from the current class
		local
			l_area: like area
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count - 1
			until
				i > nb
			loop
				if l_area.item (i).is_modifiable then
					Result := Result + 1
				end
				i := i + 1
			end
		ensure
			cursor_not_changed: index = old index
		end

feature -- Traversals

	pass4
			-- Proceed to the `pass4' on the items of the list.
		local
			l_area: like area
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count - 1
			until
				i > nb
			loop
				l_area.item (i).pass4
				i := i + 1
			end
		ensure
			cursor_not_changed: index = old index
		end

	melt
			-- Proceed to the `melt' on the items of the list
		local
			l_area: like area
			l_item: like item
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count - 1
			until
				i > nb
			loop
				l_item := l_area.item (i)
				if not l_item.is_precompiled then
					l_item.melt
				end
				i := i + 1
			end
		ensure
			cursor_not_changed: index = old index
		end

	update_execution_table
			-- Proceed to the `update_execution_table' on the items of the list
		local
			l_area: like area
			l_item: like item
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count - 1
			until
				i > nb
			loop
				l_item := l_area.item (i)
				if not l_item.is_precompiled then
					l_item.update_execution_table
				end
				i := i + 1
			end
		ensure
			cursor_not_changed: index = old index
		end

	melt_feature_table
			-- Proceed to the `melt_feature_table' on the items of the list
		local
			l_area: like area
			l_item: like item
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count - 1
			until
				i > nb
			loop
				l_item := l_area.item (i)
				if l_item.is_modifiable then
					l_item.melt_feature_table
				end
				i := i + 1
			end
		ensure
			cursor_not_changed: index = old index
		end

feature -- Sorting

	sort
			-- Sort current by topological conformance. This is a crucial step
			-- for finalization where all the computed dynamic types ensure
			-- that A conforms to B implies type_id_of_A > type_id_of_B. This
			-- fixes eweasel test#exec272 and test#final039.
		local
			i, nb: INTEGER
			l_list: TWO_WAY_LIST [TUPLE [type_a: TYPE_A; class_type: CLASS_TYPE]]
			l_type_a: TYPE_A
			l_done: BOOLEAN
			l_area: like area
			l_item: like item
		do
			nb := count - 1
			if nb > 0 then
					-- Perform sorting
				from
					l_area := area
					create l_list.make
				until
					i > nb
				loop
					l_item := l_area.item (i)
						-- We instantiate the type in the `constraint_actual_type' so that
						-- all formals if any are replaced by the constraint below, that way
						-- the conformance test will say that A [INTEGER] will conform to A [ANY]
						-- for us putting A[G] first in the current type list.
					l_type_a := l_item.type.instantiated_in (l_item.associated_class.constraint_actual_type)
					from
						l_list.start
						l_done := l_list.after
					until
						l_done or else l_list.after
					loop
						if l_list.item.type_a.conform_to (l_item.associated_class, l_type_a) then
							l_done := True
						else
							l_list.forth
						end
					end
					l_list.put_left ([l_type_a, l_item])
					i := i + 1
				end
					-- Update `area' with sorted elements.
				from
					l_list.start
					i := 0
				until
					l_list.after
				loop
					l_area.put (l_list.item.class_type, i)
					i := i + 1
					l_list.forth
				end
				do_nothing
			end
		end

feature -- Cleanup

	clean
			-- Remove types that are not valid anymore.
		local
			l_class_type: CLASS_TYPE
		do
			from
				start
			until
				after
			loop
				l_class_type := item
				if not l_class_type.is_valid then
					l_class_type.system.remove_class_type (l_class_type)
					remove
				else
					forth
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
