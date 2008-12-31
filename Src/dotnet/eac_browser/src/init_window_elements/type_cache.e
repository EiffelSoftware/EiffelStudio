note
	description: "Last type printed in output"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CACHE

--create
--	make
--	
--feature -- Initialization
--
--	make is
--			--
--		do
--		end

feature -- Access

	factory_display: DISPLAY_TYPE_FACTORY 
			-- type currently displayed.
		do
			Result := internal_factory_display.item
		end

feature -- Status Setting
	
	set_factory_display (a_factory_display: DISPLAY_TYPE_FACTORY)
			-- put `a_factory_display' in `internal_factory_display'.
		require
			non_void_a_factory_display: a_factory_display /= Void
		do
			internal_factory_display.put (a_factory_display)
		ensure
			factory_display_set: factory_display = a_factory_display
		end
		

feature {NONE} -- Initialization

	internal_factory_display: CELL [DISPLAY_TYPE_FACTORY]
			-- Internal representation of `factory_display'.
		once
			create Result.put (Void)
		ensure
			non_void_result: Result /= Void
		end
		
invariant

note
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


end -- class TYPE_CACHE