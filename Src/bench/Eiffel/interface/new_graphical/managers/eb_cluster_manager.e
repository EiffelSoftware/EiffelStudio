indexing
	description: "Facade to access, manipulate, organize, .. the clusters."
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

creation
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

	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window.

end -- class EB_CLUSTER_MANAGER
