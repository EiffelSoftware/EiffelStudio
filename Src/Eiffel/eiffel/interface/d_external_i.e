note
	description: "Representation of an inherited external procedure which is unselected"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class D_EXTERNAL_I

inherit
	EXTERNAL_I
		redefine
			access_in,
			is_unselected,
			new_deferred,
			new_deferred_anchor,
			replicated,
			selected,
			set_access_in,
			transfer_from,
			transfer_to,
			unselected
		end

feature

	access_in: INTEGER;
			-- Access class id

	set_access_in (i: INTEGER)
			-- Assign `i' to `access_in'
		do
			access_in := i
		end;

	replicated (in: INTEGER): FEATURE_I
			-- Replication
		local
			rep: RD1_EXTERNAL_I;
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			rep.set_access_in (in)
			Result := rep;
		end; -- replicated

	selected: D_EXTERNAL_I
			-- <Precursor>
		do
			create Result
			Result.transfer_from (Current)
		end

	unselected (i: INTEGER): FEATURE_I
			-- Unselected feature
		local
			rep: RD1_EXTERNAL_I
		do
			create rep;
			transfer_to (rep);
			rep.set_access_in (i);
			Result := rep
		end;

	transfer_to (f: like Current)
			-- Data transfer
		do
			Precursor {EXTERNAL_I} (f);
			f.set_access_in (access_in);
		end;

	transfer_from (f: like Current)
			-- Data transfer
		do
			Precursor {EXTERNAL_I} (f);
			set_access_in (f.access_in);
		end;

	is_unselected: BOOLEAN = True;
			-- Is the feature a non-selected one ?

feature -- Undefinition

	new_deferred_anchor: D_DEF_PROC_I
			-- <Precursor>
		do
			check False then end
		end

	new_deferred: like new_deferred_anchor
			-- <Precursor>
		do
			Result := Precursor
			Result.set_access_in (access_in)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
