indexing
	description: "Server for storing FEATURE_I objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_SERVER

inherit
	COMPILER_SERVER [FEATURE_I]
		redefine
			has, item, remove
		end

create
	make

feature -- Access

	cache: CACHE [FEATURE_I] is
			-- Cache for features
		once
			create Result.make
		end

	has (an_id: INTEGER): BOOLEAN is
			-- Has the current server or the associated temporary
			-- server an item of id `an_id'.
		do
			Result := tmp_feature_server.has (an_id) or else Precursor (an_id)
		end;

	item (an_id: INTEGER): FEATURE_I is
			-- Feature table of id `an_id'. Look first in the temporary
			-- feature table server. It not present, look in itself.
		do
			Result := tmp_feature_server.item (an_id)
			if Result = Void then
				Result := Precursor (an_id)
			end
		end

	remove (an_id: INTEGER_32) is
			-- <Precursor>
		do
			tmp_feature_server.remove (an_id)
			Precursor (an_id)
		end

feature -- Server size configuration

	Chunk: INTEGER is 5000;
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
