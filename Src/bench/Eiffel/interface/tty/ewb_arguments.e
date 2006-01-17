indexing

	description: 
		"Representation of arguments entered by the user%
		%while in the loop of the batch compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ARGUMENTS

inherit
	ARRAY [STRING]
		rename
			wipe_out as na_wipe_out
		redefine
			force
		end

create

	make

feature -- Properties

	argument_position: INTEGER;
			-- Current position of argument

	argument_count: INTEGER;
			-- Number of arguments

feature -- Access

	current_item: STRING is
			-- Current argument string at `argument_position'
		do
			Result := item (argument_position);
			argument_position := argument_position + 1;
		end;

	more_arguments: BOOLEAN is
			-- Are there more arguments?
		do
			Result := argument_position <= argument_count
		end

feature -- Update

	force (s: STRING; i: INTEGER) is
			-- Force string `s' at position `i'.
		do
			Precursor {ARRAY} (s, i);
			if i > argument_count then
				argument_count := i
			end;
		end;

	wipe_out is
			-- Clear arguments.
		do
			make (lower, upper);
			argument_position := 1;
			argument_count := 1;
		end;

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

end -- class EWB_ARGUMENTS
