indexing
	description: "[
			Dialogs that are created by the Vision2 docking mechanism when
			an EV_DOCKABLE_SOURCE is dropped while not over a valid EV_DOCKABLE_TARGET.
			The transported component will be inserted into `Current', and when `Current'
			is destroyed, it will be restored back to its original position before the
			transport began.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DOCKABLE_DIALOG
	
inherit
	EV_DIALOG
		export
			{ANY} close_request_actions, implementation
		end

feature -- Access

	original_parent: EV_CONTAINER
			-- Original parent of `item' before it was
			-- dragged out.
			
	original_parent_index: INTEGER
			-- Original index of `item' in parent before it was
			-- dragged out.
			
	expansion_was_disabled: BOOLEAN
		-- Was `item' originally disabled in `original_parent'? This
		-- may only be True if `original_parent' is an EV_BOX.

feature -- Implementation

	set_original_parent (an_original_parent: EV_CONTAINER) is
			-- Assign `an_original_parent' to `original_parent'.
		do
			original_parent := an_original_parent
		end
		
	set_original_parent_index (an_index: INTEGER) is
			-- Assign `an_index' to `original_parent_index'.
		do
			original_parent_index := an_index
		end
		
	set_expansion_was_disabled is
			-- Assign `True' to `expansion_was_disabled'.
		do
			expansion_was_disabled := True
		end
		
	enable_closeable is
		do
			implementation.enable_closeable
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

end -- class ES_DOCKABLE_DIALOG
