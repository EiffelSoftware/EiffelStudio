note

	description:
			"Abstract description for the supplier type set of a %
			%class. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SUPPLIERS_AS

feature -- Access

	supplier_ids: detachable SEARCH_TABLE [ID_AS]
			-- Set of supplier class names

	light_supplier_ids: detachable SEARCH_TABLE [ID_AS]
			-- Set of supplier class names which don't need the class to be compiled and in the system.

feature -- Insertion

	insert_supplier_id (id: ID_AS)
			-- Insert a new supplier name in `supplier_ids', if
			-- not already present.
		require
			good_argument: id /= Void
		local
			l_suppliers: like supplier_ids
		do
			l_suppliers := supplier_ids
			if l_suppliers = Void then
				create l_suppliers.make (5)
				supplier_ids := l_suppliers
			end
			l_suppliers.put (id)
		end

	insert_light_supplier_id (id: ID_AS)
			-- Insert a new supplier name in `light_supplier_ids', if
			-- not already present.
		require
			good_argument: id /= Void
		local
			l_suppliers: like light_supplier_ids
		do
			l_suppliers := light_supplier_ids
			if l_suppliers = Void then
				create l_suppliers.make (5)
				light_supplier_ids := l_suppliers
			end
			l_suppliers.put (id)
		end;

	merge (other: like Current)
			-- Merge other in Current.
		local
			l_suppliers: like supplier_ids
		do
			if attached other.light_supplier_ids as l_other_light_supplier_ids then
				l_suppliers := light_supplier_ids
				if l_suppliers = Void then
					create l_suppliers.make (l_other_light_supplier_ids.count)
					light_supplier_ids := l_suppliers
				end
				l_suppliers.merge (l_other_light_supplier_ids)
			end
			if attached other.supplier_ids as l_other_supplier_ids then
				l_suppliers := supplier_ids
				if l_suppliers = Void then
					create l_suppliers.make (l_other_supplier_ids.count)
					supplier_ids := l_suppliers
				end
				l_suppliers.merge (l_other_supplier_ids)
			end
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class SUPPLIERS_AS
