indexing
	description: "[
		Selection table:

		Associates routine ids with execution units. At generation time
		the select table leads to one descriptor per associated class type.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SELECT_TABLE

inherit
	HASH_TABLE [FEATURE_I, INTEGER]

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end
		
	SHARED_HISTORY_CONTROL
		undefine
			copy, is_equal
		end

create
	make

feature -- Final mode

	add_units (id: INTEGER) is
			-- Insert units of Current in the history
			-- controler (routine table construction)
		local
			new_unit: ENTRY
			feature_i: FEATURE_I
			rout_id: INTEGER
		do
			from
				start
			until
				after
			loop
				feature_i := item_for_iteration
				if feature_i.has_entry then
					rout_id := key_for_iteration
					new_unit := feature_i.new_entry (rout_id)
					new_unit.set_class_id (id)
					History_control.add_new (new_unit, rout_id)
				end
				forth
			end
		end

feature -- Incrementality

	equiv (other: like Current): BOOLEAN is
			-- Incrementality test on the select table in second pass.
		require
			good_argument: other /= Void
		local
			f2: FEATURE_I
		do
			if other.count = count then
					-- At least the counts should be the same.
				from
					start
					Result := True
				until
					after or else not Result
				loop
					f2 := other.item (key_for_iteration)
					if f2 = Void then
						Result := False
					else
						check
							item_for_iteration.feature_name.is_equal (f2.feature_name)
						end
						Result := item_for_iteration.select_table_equiv (f2);					
					end
					forth
				end
			end
		end

feature -- Generation

	descriptors (c: CLASS_C): DESC_LIST is
			-- Descriptors of class types associated
			-- with class `c'
		require
			c_not_void: c /= Void
		do
			create Result.make (c, count)
			if c.has_invariant then
				Result.put_invariant (c.invariant_feature)
			end

			from
				start
			until
				after
			loop
				Result.put (key_for_iteration, item_for_iteration)
				forth
			end
		end

	generate (c: CLASS_C) is
			-- Generate descriptor C tables of class 
			-- types associated with class `c'.
		require
			c_not_void: c /= Void
		local
			desc_list: DESC_LIST
			desc: DESCRIPTOR
		do
			from
				desc_list := descriptors (c)
				desc_list.start
			until
				desc_list.after
			loop
				desc := desc_list.item
				if desc.class_type.is_modifiable then
					desc.generate
				end
				desc_list.forth
			end
		end

feature -- Melting

	melt (c: CLASS_C) is
			-- Melt descriptors of class types
			-- associated with class `c'.
			--| (The result is put in the melted 
			--| descriptor server).
		require
			c_not_void: c /= Void
		do
			descriptors (c).melt
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

end -- class SELECT_TABLE
