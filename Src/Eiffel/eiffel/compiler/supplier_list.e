indexing
	description: "Descritpion of the suppliers of a class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SUPPLIER_LIST

inherit
	ARRAYED_LIST [SUPPLIER_INFO]
		export
			{ANY} count, start, after, forth, item, cursor, go_to, is_empty, wipe_out,
				valid_index, index, readable, off, valid_cursor, prunable, extendible
			{SUPPLIER_LIST} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

create
	make

create {SUPPLIER_LIST}
	make_filled

feature -- Element change

	remove_occurrence (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]) is
			-- Remove one occurrence for each supplier of id
			-- included in `l'.
			--| FIXME: look at eweasel test#incr109 and test#fixed070 which shows that
			--| the `consistency' precondition is being violated. At this stage we think that
			--| the precondition might be too strong, but this hasn't been checked carefully.
		require
			l_not_void: l /= Void
			consistency: is_ok (l)
		local
			suppl_info: SUPPLIER_INFO
			l_class_id: INTEGER
			l_system: SYSTEM_I
		do
			from
				l_system := eiffel_system.system
				l.start
			until
				l.after
			loop
				l_class_id := l.item.class_id
				if l_system.class_of_id (l_class_id) /= Void then
					goto (l_class_id)
						-- Defensive programming: according to the
						-- precondition, after should always be false
					if not after then
						suppl_info := item
						suppl_info.remove_occurrence
						if suppl_info.occurrence <= 0 then
							remove
						end
					end
				end
				l.forth
			end
		end

	add_occurrence (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]) is
			-- Add one occurrence for each supplier of id
			-- included in `l'.
		require
			l_not_void: l /= Void
		local
			suppl_info: SUPPLIER_INFO
			l_class_id: INTEGER
		do
			from
				l.start
			until
				l.after
			loop
				l_class_id := l.item.class_id
				check
					has_class: Eiffel_system.class_of_id (l_class_id) /= Void
				end
				debug ("ACTIVITY")
					io.error.put_string ("SUPPLIER_LIST add_occurrence: ")
					io.error.put_string (Eiffel_system.class_of_id (l_class_id).name)
					io.error.put_new_line
				end
				suppl_info := info (l_class_id)
				if suppl_info = Void then
					create suppl_info.make (l_class_id)
					put_front (suppl_info)
				else
					suppl_info.add_occurrence
				end

				l.forth
			end
		ensure
			consistency: is_ok (l)
		end

	same_suppliers: SUPPLIER_LIST is
			-- Duplicated list
		do
			create Result.make (count)
			from
				start
			until
				after
			loop
				Result.extend (item.twin)
				forth
			end
		end

	classes: ARRAYED_LIST [CLASS_C] is
			-- List of `CLASS_C'es
		do
			from
				create Result.make (count)
				start
			until
				after
			loop
				Result.extend (item.supplier)
				Result.forth
				forth
			end
		end

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class' from Current.
			-- Cursor can be moved
		require
			a_class_not_void: a_class /= Void
		local
			class_id: INTEGER
			found: BOOLEAN
		do
			from
				start
				class_id := a_class.class_id
			until
				after or found
			loop
				if item.supplier_id = class_id then
					remove
					found := True
				else
					forth
				end
			end
		end

feature -- Consistency

	is_ok (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]): BOOLEAN is
			-- Is the supplier list consistant regarding to `l'.
		require
			l_not_void: l /= Void
		local
			suppl_info: SUPPLIER_INFO
			l_class_id: INTEGER
			l_system: SYSTEM_I
		do
			debug ("ACTIVITY")
				trace
			end
			from
				Result := True
				l_system := eiffel_system.system
				l.start
			until
				l.after or else not Result
			loop
				l_class_id := l.item.class_id
				if l_system.class_of_id (l_class_id) /= Void then
					suppl_info := info (l_class_id)
					Result := suppl_info /= Void and then suppl_info.occurrence >= 1
				end
				l.forth
			end
		end

feature {NONE} -- Implementation: debugging

	trace is
			-- Debug purpose
		do
			io.error.put_string ("SUPPLIER_LIST.trace%N")
			from
				start
			until
				after
			loop
				io.error.put_string (item.supplier.name)
				io.error.put_string (" [")
				io.error.put_integer (item.occurrence)
				io.error.put_string ("]  ")
				forth
			end
		end

feature {NONE} -- Implementation: traversal

	goto (id: INTEGER) is
			-- Move cursor to supplier info of id `id'.
		require
			valid_id: id >= 0
		do
			from
				start
			until
					-- The test for `after' is a defensive programming
					-- test!!!
				after or else item.supplier_id = id
			loop
				forth
			end
		end

	info (id: INTEGER): SUPPLIER_INFO is
			-- Supplier information associated to supplier of id `id'.
		require
			valid_id: id >= 0
		local
			cur: CURSOR
		do
			cur := cursor
			goto (id)
			if not after then
					-- We found it.
				Result := item
				check
					result_not_void: Result /= Void
				end
			end
			go_to (cur)
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

end
