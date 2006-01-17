indexing
	description: "Comment server for a class indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CLASS_COMMENTS_SERVER

inherit
	COMPILER_SERVER [CLASS_COMMENTS]

create
	make

feature -- Access

	id (t: CLASS_COMMENTS): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	Cache: CACHE [CLASS_COMMENTS] is
			-- No caching machanism
			-- (Returns void)
		do
		end

feature {NONE} -- Implementation

	Size_limit: INTEGER is 200
			-- Size of the CLASS_COMMENTS_SERVER file (200 Ko)

	Chunk: INTEGER is 500;
			-- Size of a HASH_TABLE block

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

end
