indexing
	description	: "[
					Describes a breakpoint's key. It is by its `body_index' 
				  	and its `breakable_line_number' (line number in stop points view).
				  ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BREAKPOINT_KEY

inherit
	BREAKPOINT_KEY_I
		redefine
			hash_code
		end

create
	make,
	make_hidden

feature {NONE} -- Creation

	make (a_location: BREAKPOINT_LOCATION) is
			-- Create a breakpoint at location `a_location'
		require
			valid_location: 	a_location /= Void and then
								not a_location.is_corrupted
		do
			location := a_location
		end

	make_hidden (a_location: BREAKPOINT_LOCATION) is
			-- Create a hidden breakpoint at location `a_location'
		do
			is_hidden := True
			make (a_location)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to `Current'?
			-- `other' equals to `Current' if they represent
			-- the same physical breakpoint, in other words they
			-- have the same `body_index' and `offset'.
			-- We use 'body_index' because it does not change after
			-- a recompilation
		do
			Result := location.is_equal (other.location) and (is_hidden = other.is_hidden)
		end

feature -- Properties

	is_hidden: BOOLEAN
			-- Is hidden breakpoint ?

	location: BREAKPOINT_LOCATION
			-- Location of the breakpoint.

feature -- Access

	hash_code: INTEGER is
			-- Hash code for breakpoint.
		do
			Result := Precursor
			if is_hidden then
				Result := Result | 1
			end
		end

	is_corrupted: BOOLEAN
			-- False unless there was a problem at initialization (no feature).
		do
			Result := location.is_corrupted
		end

	routine: E_FEATURE
			-- Feature where this breakpoint is situated.
		do
			Result := location.routine
		end

	breakable_line_number: INTEGER
			-- Line number of the breakpoint in the stoppoint view under $EiffelGraphicalCompiler$.
		do
			Result := location.breakable_line_number
		end

	body_index: INTEGER
			-- `body_index' of the feature where this breakpoint is situated
		do
			Result := location.body_index
		end

invariant
	location_not_void: location /= Void

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
