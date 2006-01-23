indexing
	description: "Objects that represent tools which have icons."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_ICONABLE_TOOL
	
		-- This class is used to enable all tools to have a common icon
		--  which can be set when they are displayed relative to a window.
		-- This is necessary as on Windows, each relative dialog shares
		-- as icon and there seemed to be no better solution.
		
		-- UPDATE!! The bug on Windows has been fixed so this class is no longer
		-- required. The implementation of `restore_icon' and `set_default_icon' have
		-- been removed so they do nothing. Unless more problems arise, this class
		-- can be removed in the future.

feature -- Access

	icon: EV_PIXMAP is
			-- Standard icon displayed in `Current'.
		deferred
		end
		
feature -- Basic operations

	restore_icon is
			-- Ensure `icon' is displayed as icon of `Current'.
		do
		end
		
	set_default_icon is
			-- Assign a common default icon to `Current'.
		do
		end

feature {NONE} -- Implementation

	set_icon_pixmap (a_pixmap: EV_PIXMAP) is
			-- Ensure that `a_pixmap' is displayed as icon of `Current'.
		deferred
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


end -- class GB_ICONABLE_TOOL
