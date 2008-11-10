indexing
	description: "Description of the supplier of a class: each feature%
				%name written in the associated class is associated to%
				%a supplier list (list of ids), indexed by body index."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_DEPENDANCE

inherit
	HASH_TABLE [FEATURE_DEPENDANCE, INTEGER]
		redefine
			remove, put, force
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		undefine
			is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

create
	make

feature

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (class_id)
		end

	put (f: ?FEATURE_DEPENDANCE; bindex: INTEGER) is
			-- We must update the correspondance table in the server
		do
			System.depend_server.add_correspondance (bindex, class_id)
			Precursor {HASH_TABLE} (f, bindex)
		end

	force (f: ?FEATURE_DEPENDANCE; bindex: INTEGER) is
			-- We must update the correspondance table in the server
		do
			System.depend_server.add_correspondance (bindex, class_id)
			Precursor {HASH_TABLE} (f, bindex)
		end

	remove (bindex: INTEGER) is
			-- we must update the correspondance table in the server
		do
			System.depend_server.remove_correspondance (bindex)
			Precursor {HASH_TABLE} (bindex)
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
