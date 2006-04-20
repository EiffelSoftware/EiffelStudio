indexing
	description: "Temporary server for melted feature tables indexed by static type id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TMP_M_FEAT_TBL_SERVER 

inherit
	DELAY_SERVER [MELTED_FEATURE_TABLE]

create
	make
	
feature 

	id (t: MELTED_FEATURE_TABLE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.type_id
		end

	cache: M_FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			create Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			create Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 50
			-- Size of the TMP_M_FEAT_TBL_SERVER file (50 Ko)

	Chunk: INTEGER is 50;
			-- Size of a HASH_TABLE block

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
