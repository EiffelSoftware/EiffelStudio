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
	HASHABLE
		redefine
			is_equal
		end

create
	make

feature -- Creation

	make (a_feature: E_FEATURE; a_breakable_index: INTEGER) is
			-- Create a breakpoint in the feature `a_feature'
			-- at the line `a_breakable_index'.
		require
			valid_breakpoint: 	a_feature /= Void and then
								a_breakable_index > 0 and then
								a_feature.body_index /= 0
		do
			if not is_corrupted then
				breakable_line_number := a_breakable_index
				routine := a_feature
				body_index := routine.body_index
			end
		rescue
			is_corrupted := True
			retry
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
			Result := (other.breakable_line_number = breakable_line_number) and (other.body_index = body_index)
		end

feature -- Access

	is_corrupted: BOOLEAN
			-- False unless there was a problem at initialization (no feature).

	hash_code: INTEGER is
			-- Hash code for breakpoint.
		do
			Result := body_index * 1000 + breakable_line_number
				-- here we take the absolute value of the
				-- result if an overflow occurred
			if Result < 0 then
				Result := - Result
			end
		end

feature {BREAKPOINTS_MANAGER} -- Change

	set_is_corrupted (b: like is_corrupted) is
			-- Set `is_corrupted' to `b'
		do
			is_corrupted := b
		end

	set_breakable_line_number (i: like breakable_line_number) is
			-- Set `breakable_line_number' to `i'
		require
			i_positive: i > 0
		do
			breakable_line_number := i
		end

	update_routine_version is
			-- Set `routine' to the updated_version of `routine'
		require
			routine_not_void: routine /= Void
		do
			routine := routine.updated_version
		end

feature -- Properties

	routine: E_FEATURE
			-- Feature where this breakpoint is situated.

	breakable_line_number: INTEGER
			-- Line number of the breakpoint in the stoppoint view under $EiffelGraphicalCompiler$.

	body_index: INTEGER;
			-- `body_index' of the feature where this breakpoint is situated

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
