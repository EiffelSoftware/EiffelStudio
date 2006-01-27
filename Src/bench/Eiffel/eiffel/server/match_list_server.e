indexing
	description: "Match list server for a class indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MATCH_LIST_SERVER

inherit
	COMPILER_SERVER [LEAF_AS_LIST]
		rename
			item as stored_item,
			has as stored_has
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature -- Access

	item (an_id: INTEGER): LEAF_AS_LIST is
			-- Retrieve object.
		local
			l_class: CLASS_C
		do
			if stored_has (an_id) then
				Result := stored_item (an_id)
			end
			l_class := system.class_of_id (an_id)
				-- lazy computation, create match list if needed
			if Result = Void or else Result.generated < l_class.lace_class.date then
				matchlist_scanner.scan_string (l_class.text)
				Result := matchlist_scanner.match_list
				Result.set_class_id (an_id)
				Result.set_generated (l_class.lace_class.date)
				put (Result)
			end
		end

	id (t: LEAF_AS_LIST): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: MATCH_LIST_CACHE is
			-- Cache to speedup
		once
			create Result.make
		end

	has (an_id: INTEGER): BOOLEAN is
			-- Does the server have the matchlist for `an_id'?
		do
			Result := stored_has (an_id)
			if not stored_has (an_id) then
					-- if we don't have it already, check if the class exists, if so, we can compute it.
				Result := system.class_of_id (an_id) /= Void
			end
		end


feature {NONE} -- Implementation

	Size_limit: INTEGER is 200
			-- Size of the `MATCH_LIST_SERVER' file (200 Ko)

	Chunk: INTEGER is 500;
			-- Size of a HASH_TABLE' block

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

end -- class `MATCH_LIST_SERVER'
