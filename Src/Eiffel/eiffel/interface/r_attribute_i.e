indexing
	description: "Representation of a replicated attribute"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class R_ATTRIBUTE_I

inherit
	ATTRIBUTE_I
		redefine
			replicated, code_id, unselected, transfer_to,
			is_replicated, set_code_id, transfer_from, set_access_in, access_in
		end

create
	make

feature

	code_id: INTEGER
			-- Code id

	set_code_id (i: INTEGER) is
			-- Assign `i' to `code_id'.
		do
			code_id := i
		end

	access_in: INTEGER
			-- Access class id

	set_access_in (i: INTEGER) is
			-- Assign `i' to `access_in'.
		do
			access_in := i
		end

	unselected (i: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: RD2_ATTRIBUTE_I
		do
			create unselect.make
			transfer_to (unselect)
			unselect.set_access_in (i)
			Result := unselect
		end

	replicated (in: INTEGER): FEATURE_I is
			-- Replication
		local
			rep: RD2_ATTRIBUTE_I
		do
			create rep.make
			transfer_to (rep)
			rep.set_access_in (in)
			rep.set_code_id (new_code_id)
			Result := rep
		end

	transfer_to (f: like Current) is
			-- Data transfer
		do
			precursor {ATTRIBUTE_I} (f)
			f.set_code_id (code_id)
		end

	transfer_from (f: like Current) is
			-- Data transfer
		do
			precursor {ATTRIBUTE_I} (f)
			set_code_id (f.code_id)
		end

	is_replicated: BOOLEAN is True;
			-- Is Current feature conceptually replicated (True)

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
