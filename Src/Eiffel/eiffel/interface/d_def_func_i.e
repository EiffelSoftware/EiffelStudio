indexing
	description: "Representation of an inherited deferred function which is unselected"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class D_DEF_FUNC_I

inherit
	DEF_FUNC_I
		redefine
			unselected, set_access_in, access_in, replicated, is_unselected, transfer_to, transfer_from, selected
		end

feature

	access_in: INTEGER;
			-- Access class id

	set_access_in (i: INTEGER) is
			-- Assign `i' to `access_in'
		do
			access_in := i
		end;

	replicated (in: INTEGER): FEATURE_I is
			-- Replication
		local
			rep: RD1_DEF_FUNC_I;
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			rep.set_access_in (in)
			Result := rep;
		end; -- replicated

	selected: D_DEF_FUNC_I is
			-- <Precursor>
		do
			create Result
			Result.transfer_from (Current)
		end

	unselected (i: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			rep: RD1_DEF_FUNC_I
		do
			create rep;
			transfer_to (rep);
			rep.set_access_in (i);
			Result := rep
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			Precursor {DEF_FUNC_I}(f);
			f.set_access_in (access_in);
		end;

	transfer_from (f: like Current) is
			-- Data transfer
		do
			Precursor {DEF_FUNC_I}(f);
			set_access_in (f.access_in);
		end;

	is_unselected: BOOLEAN is True;
			-- Is the feature a non-selected one ?

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
