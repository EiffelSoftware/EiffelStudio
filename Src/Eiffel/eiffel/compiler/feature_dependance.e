indexing
	description: "Dependance between features"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_DEPENDANCE

inherit
	TWO_WAY_SORTED_SET [DEPEND_UNIT]
		export
			{FEATURE_DEPENDANCE} all
			{ANY} cursor, go_to, start, before, after, forth, item, active,
				count, first_element, last_element, object_comparison, sublist,
				extend, prunable, off, readable, valid_cursor, extendible
		redefine
			make, wipe_out, copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

	SHARED_NAMES_HEAP
		undefine
			copy, is_equal
		end

create
	make

create {FEATURE_DEPENDANCE}
	make_sublist

feature {NONE} -- Initialization

	make is
		do
			Precursor {TWO_WAY_SORTED_SET}
			compare_objects
			create suppliers.make
		end

feature -- Access

	suppliers: TWO_WAY_SORTED_SET [INTEGER]
			-- Set of all the syntactical suppliers of the feature

	add_supplier (a_class: CLASS_C) is
			-- Add the class to the list of suppliers
		require
			good_argument: a_class /= Void
		do
			suppliers.extend (a_class.class_id)
		end;

	wipe_out is
		do
			Precursor {TWO_WAY_SORTED_SET}
			suppliers.wipe_out
		end;

	copy (other: like Current) is
		do
			Precursor {TWO_WAY_SORTED_SET} (other)
			set_suppliers (suppliers.twin)
		end

	set_suppliers (new_suppliers: like suppliers) is
		do
			suppliers := new_suppliers
		end;

	feature_name: STRING is
			-- Final name of the feature
		require
			feature_name_id_set: feature_name_id >= 1
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

	feature_name_id: INTEGER
			-- name ID of the feature for which we have the dependances

	set_feature_name_id (id: INTEGER) is
			-- Assign `id' to `feature_name_id'.
		require
			valid_id: Names_heap.valid_index (id)
		do
			feature_name_id := id
		ensure
			feature_name_id_set: feature_name_id = id
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := active = other.active and then after = other.after and then
						before = other.before and then count = other.count and then
						feature_name_id = other.feature_name_id and then
						first_element = other.first_element and then
						last_element = other.last_element and then
						object_comparison = other.object_comparison and then
						sublist = other.sublist
			Result := Result and then equal (suppliers, other.suppliers)
		end

feature -- Incrementality

	has_removed_id: BOOLEAN is
			-- One of the suppliers has been removed from the system?
		local
			l_system: like system
		do
			l_system := system
			from
				suppliers.start
			until
				suppliers.after or else Result
			loop
				if l_system.class_of_id (suppliers.item) = Void then
					Result := True
				end;
				suppliers.forth
			end;
			from
				start
			until
				after or else Result
			loop
				if l_system.class_of_id (item.class_id) = Void then
					Result := True
				end;
				forth
			end;
		end;

feature -- Debug

	trace is
		do
			io.error.put_string("Suppliers%N");
			from
				suppliers.start
			until
				suppliers.after
			loop
				io.error.put_string ("Supplier id: ");
				io.error.put_integer (suppliers.item);
				io.error.put_new_line;
				suppliers.forth
			end;
			from
				start
			until
				after
			loop
				item.trace;
				forth
			end;
		end;

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
