indexing
	description	: "Observer for EB_WINDOW_MANAGER"
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

end -- class EB_CLUSTER_MANAGER_OBSERVER
