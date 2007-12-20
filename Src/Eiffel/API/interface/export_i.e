indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class EXPORT_I

inherit

	PART_COMPARABLE;
	COMPILER_EXPORTER

feature -- Properties

	is_none: BOOLEAN is
			-- Is the current object an instance of EXPORT_NONE_I ?
		do
			-- Do nothing
		end;

	is_set: BOOLEAN is
			-- Is the current object an instance of EXPORT_SET_I ?
		do
			-- Do nothing
		end;

	is_all: BOOLEAN is
			-- Is the current object an instance of EXPORT_ALL_I ?
		do
			-- Do nothing
		end;

feature -- Access

	is_exported_to (c: CLASS_C): BOOLEAN is
			-- Is current exported to `c'?
		require
			good_argument: c /= Void;
		do
			Result := valid_for (c)
		end;

feature -- Comparison

	infix "<" (other: EXPORT_I): BOOLEAN is
		deferred
		end;

feature {COMPILER_EXPORTER} -- Queries

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export clause for client `client' ?
		require
			good_argument: client /= Void;
		deferred
		end;

    is_subset (other: EXPORT_I): BOOLEAN is
            -- Is Current a subset or equal to other?
        require
            valid_other: other /= Void
        deferred
        end;

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [since this relation is not symetric, we have to call
			-- something like "old_export_status.equiv (new_export_status)']
		require
			good_argument: other /= Void;
		deferred
		end;

	trace is
			-- Debug purpose
		deferred
		end;

feature {COMPILER_EXPORTER} -- Concatanation of export statuses

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		require
			good_argument: other /= Void
		deferred
		end;

feature -- Incrementality

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void
		deferred
		end;

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
