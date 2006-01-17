indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_FIGURE_LIST_STONE

inherit
	STONE
	
create
	make_with_list
	
feature {NONE} -- Initialization

	make_with_list (a_list: LIST [EIFFEL_CLASS_FIGURE])  is
			-- 
		do
			classes := a_list
		end
		
feature -- Properties

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone.
			-- Default is Void, meaning no cursor is associated with `Current'.
		do
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
			-- Default is Void, meaning no cursor is associated with `Current'.
		do
		end

feature  -- Access

	classes: LIST [EIFFEL_CLASS_FIGURE]
			-- Classes transported with this stone.

	stone_signature: STRING is 
			-- Short string to describe Current
			-- (basically the name of the stoned object).
		do
			Result := "List of classes"
		end

	header: STRING is 
			-- String to describe Current
			-- (as it may be described in the title of a development window).
		do
			Result := stone_signature
		end

	history_name: STRING is 
			-- Name used in the history list,
			-- (By default, it is the stone_signature
			-- and a string to describe the type of stone (Class, feature,...)).
		do
			Result := stone_signature
		end

--	synchronized_stone: STONE is
--			-- Clone of `Current' after a recompilation
--			-- (May be Void if not valid anymore)
--		do
--			if is_valid then
--				Result := Current
--			end
--		ensure
--			valid_stone: Result /= Void implies Result.is_valid
--		end

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

end -- class CLASS_FIGURE_LIST_STONE
