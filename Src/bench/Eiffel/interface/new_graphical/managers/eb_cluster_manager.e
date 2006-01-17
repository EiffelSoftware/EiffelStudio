indexing
	description: "Facade to access, manipulate, organize, .. the clusters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLUSTER_MANAGER

inherit
	EB_CONSTANTS

	EB_SHARED_WINDOW_MANAGER

	SHARED_EIFFEL_PROJECT

	EB_CLUSTER_MANAGER_OBSERVER
		redefine
			on_project_loaded,
			on_project_unloaded,
			refresh
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_window: EB_TOOL_MANAGER) is
			-- Initialize `Current' as dependent of `a_window'.
		do
			development_window ?= a_window
		end

feature -- Status setting

	go_to (a_class: CLASS_I) is
			-- `a_class' has been selected, the associated class
			-- window should load the class corresponding to `a_class'.
		local
			class_stone: CLASSI_STONE
		do
			create class_stone.make (a_class)
			development_window.set_stone (class_stone)
		end

feature -- Observer pattern

	on_project_loaded is
			-- Project has been loaded or re-loaded.
		do
			manager.on_project_loaded
		end

	on_project_unloaded is
			-- Project will soon be unloaded.
		do
			manager.on_project_unloaded
		end

	refresh is
			-- Make `manager' up-to-date.
		do
			manager.refresh
		end

feature -- Load / Save / Reset...

	reset is
			-- Reset the favorites.
		do
--			favorites.wipe_out
		end

	development_window: EB_DEVELOPMENT_WINDOW;
			-- Associated development window.

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

end -- class EB_CLUSTER_MANAGER
