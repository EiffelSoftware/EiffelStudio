indexing
	description: "List of all breakpoints currently set. %
				 %Breakpoints can be enabled, disabled, or not set. %
				 %(Breakpoints are equal if they represente the same physical %
				 %point in code, that's to say that they share the %
				 %same body_index and line number)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY (aranud@mail.dotcom.fr)"
	date: "$Date$"
	revision: "$Revision$"

class
	BREAK_LIST 

inherit
	HASH_TABLE [BREAKPOINT, BREAKPOINT]
		rename
			make as ht_make
		end

create
	make

feature -- Initialization

	make is
			-- Create an empty list of break points.
		do
			ht_make (50)
		end
			
feature -- Element change

	add_breakpoint (bp: BREAKPOINT) is
			-- Add the new breakpoint `bp' to the list.
			-- If a breakpoint is already held in the
			-- list, the breakpoint is set and activated.
		require else
			bp_exists: bp /= Void
		do
			if not has (bp) then
				put (bp, bp)
			else
				found_item.enable
			end
		end

	append (other: like Current) is
			-- Add breakpoints held in `other' into `Current'.
		require
			other_exists: other /= Void
		do
			from
				other.start
			until
				other.off
			loop
				add_breakpoint (other.item_for_iteration)
				other.forth
			end
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

end -- class BREAK_LIST
	
