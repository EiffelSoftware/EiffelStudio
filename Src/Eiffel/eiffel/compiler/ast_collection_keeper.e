note
	description: "Keeper for several nested contexts."

class AST_COLLECTION_KEEPER

inherit
	AST_NESTING_KEEPER

create
	make_from_array

feature {NONE} -- Creation

	make_from_array (a: ARRAY [AST_NESTING_KEEPER])
			-- Initialize with a given collection of context keepers.
		require
			a_not_empty: not a.is_empty
		do
			collection := a.area
		ensure
			collection_set: collection = a.area
		end

feature -- Modification

	extend (k: AST_NESTING_KEEPER)
			-- Extend a collection of context keepers with `k'.
		require
			same_level: k.nesting_level = nesting_level
		do
			collection := collection.aliased_resized_area (collection.count + 1)
			collection.extend (k)
		end

feature -- Status report: nesting

	nesting_level: INTEGER
			-- <Precursor>
		do
			Result := collection [0].nesting_level
		end

feature {AST_CONTEXT, AST_VISITOR} -- Modification: nesting

	enter_realm
			-- <Precursor>
		local
			i: like collection.upper
		do
			from
				i := collection.upper + 1
			until
				i <= collection.lower
			loop
				i := i - 1
				collection [i].enter_realm
			end
		end

	update_realm
			-- <Precursor>
		local
			i: like collection.upper
		do
			from
				i := collection.upper + 1
			until
				i <= collection.lower
			loop
				i := i - 1
				collection [i].update_realm
			end
		end

	save_sibling
			-- <Precursor>
		local
			i: like collection.upper
		do
			from
				i := collection.upper + 1
			until
				i <= collection.lower
			loop
				i := i - 1
				collection [i].save_sibling
			end
		end

	update_sibling
			-- <Precursor>
		local
			i: like collection.upper
		do
			from
				i := collection.upper + 1
			until
				i <= collection.lower
			loop
				i := i - 1
				collection [i].update_sibling
			end
		end

	leave_realm
			-- <Precursor>
		local
			i: like collection.upper
		do
			from
				i := collection.upper + 1
			until
				i <= collection.lower
			loop
				i := i - 1
				collection [i].leave_realm
			end
		end

	leave_optional_realm
			-- <Precursor>
		local
			i: like collection.upper
		do
			from
				i := collection.upper + 1
			until
				i <= collection.lower
			loop
				i := i - 1
				collection [i].leave_optional_realm
			end
		end

feature {NONE} -- Storage

	collection: SPECIAL [AST_NESTING_KEEPER]
			-- All the keepers to be handled.

invariant
	synchronized: across collection as x all across collection as y all x.item.nesting_level = y.item.nesting_level end end

note
	date: "$Date$"
	revision: "$Revision$"
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

end
