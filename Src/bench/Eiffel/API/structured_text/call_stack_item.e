indexing

	description: 
		"Text to indicate the start of call stack item"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CALL_STACK_ITEM

inherit

	TEXT_ITEM
		redefine
			image
		end

create
	make,
	make_selected,
	do_nothing

feature -- Initialization

	make (i: INTEGER) is
            -- Initialize `displayed_callstack' to True
            -- with level number `i'.
		require
			positive_i: i > 0
        do
			level_number := i
        end;
	
	make_selected (i: INTEGER) is
			-- Initialize `displayed_callstack' to True
			-- with level number `i'.
		require
			positive_i: i > 0
		do
			displayed_callstack := True;
			level_number := i
		end;
	
feature -- Properties

	level_number: INTEGER;
			-- Level number of call stack

	displayed_callstack: BOOLEAN;
			-- Is the following callstack element going to
			-- display its locals and arguments?

	image: STRING is
			-- Image of stack element
		do
			if displayed_callstack then	
				Result := "-> "
			elseif level_number > 0 then
				Result := ":: "
			else
				Result := "   "
			end
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_call_stack_item (Current)
		end

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

end -- class CALL_STACK_ITEM
