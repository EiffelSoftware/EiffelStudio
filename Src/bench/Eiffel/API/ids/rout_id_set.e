indexing
	description: "Routine identifier sets indexed by routine id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ROUT_ID_SET
	
inherit

	ID_SET
		export
			{COMPILER_EXPORTER} put, force, extend, merge, wipe_out
		redefine
			extend
		end

	SHARED_COUNTER
		undefine
			is_equal, copy
		end
	
	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end
	
create
	make
	
feature {COMPILER_EXPORTER}

	extend (a_rout_id: like first) is
			-- Insert routine id `a_rout_id' in set if not already
			-- present.
		local
			l_rout_id: INTEGER
			l_pos: INTEGER
			l_area: like area
		do
			if not has (a_rout_id) then
					-- Routine id `a_rout_id' is not present in set.
				if first = Dead_value then
					first := a_rout_id
				else
					l_area := area
					if l_area /= Void then
						l_pos := l_area.count
					end
					l_area := new_area (l_area, l_pos + 1)
					area := l_area
					l_area.put (a_rout_id, l_pos)
				end

					-- Processing for attribute table:
					-- Since the byte code inspect the first value of this	
					-- routine id set, if there are thw ids one for a routine
					-- table and another one for an attribute table, the one
					-- for the attribute table must be in first position
				if
					Routine_id_counter.is_attribute (a_rout_id) and then
					not Routine_id_counter.is_attribute (first)
				then
					if l_area /= Void then
						l_rout_id := first
						first := a_rout_id
						l_area.put (l_rout_id, l_pos)
					end
				end
			end
		end

	has_attribute_origin: BOOLEAN is
			-- Is in routine id set an attribute offset table id?
		require
			not_empty: not is_empty
		do
			Result := Routine_id_counter.is_attribute (first)
		end
			
	update (l: LINKED_LIST [INHERIT_INFO]) is
			-- Update through inherited features in `l'.
		require
			l_not_void: l /= Void
			l_not_empty: not l.is_empty
		do
			from
				l.start
			until
				l.after
			loop
				merge (l.item.a_feature.rout_id_set)
				l.forth
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

end -- class ROUT_ID_SET
