indexing
	description	: "Observer for EB_WINDOW_MANAGER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_CLUSTER_MANAGER_OBSERVER

feature -- Updates

	on_class_added (a_class: CLASS_I) is
			-- `a_class' has been added.
		require
			a_class_not_void: a_class /= Void
		do
		end

	on_class_changed (a_class: CLASS_I) is
			-- `a_class' has changed. Should not happen.
		require
			a_class_not_void: a_class /= Void
		do
		end

	on_class_removed (a_class: CLASS_I) is
			-- `a_class' has been removed. 
		require
			a_class_not_void: a_class /= Void
		do
		end

	on_class_moved (a_class: CLASS_I; old_cluster: CLUSTER_I) is
			-- `a_class' has been moved away from `old_cluster'.
		require
			a_class_not_void: a_class /= Void
			old_cluster_not_void: old_cluster /= Void
		do
		end

	on_cluster_added (a_cluster: EB_SORTED_CLUSTER) is
			-- `a_cluster' has been added.
		require
			valid_cluster: a_cluster /= Void
		do
		end

	on_cluster_changed (a_cluster: CLUSTER_I) is
			-- `a_cluster' was renamed. 
		require
			valid_cluster: a_cluster /= Void
		do
		end

	on_cluster_removed (a_cluster: EB_SORTED_CLUSTER) is
			-- `a_cluster' has been removed. 
		require
			valid_cluster: a_cluster /= Void
		do
		end

	on_cluster_moved (moved_cluster: EB_SORTED_CLUSTER; old_parent: CLUSTER_I) is
			-- `a_cluster' has been removed. 
		require
			valid_cluster: moved_cluster /= Void
		do
		end

	on_project_loaded is
			-- A new project has been loaded.
		do
		end

	on_project_unloaded is
			-- Current project has been closed.
		do
		end

	refresh is
			-- Refresh the display.
		do
		end

	manager: EB_CLUSTERS is
			-- manager `Current' is associated to.
		once
			create Result
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

end -- class EB_CLUSTER_MANAGER_OBSERVER
