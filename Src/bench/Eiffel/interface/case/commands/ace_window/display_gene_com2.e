indexing
	description: "Open the Ace Window with the Current Cluster";
	date: "$Date$";
	revision: "$Revision$"

class
	DISPLAY_GENE_COM2

inherit
	
	EV_COMMAND

	ONCES

creation

	make

feature

	make (m: like main_window) is
		do
			main_window := m
		end

	main_window: MAIN_WINDOW

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
		--	ace_window: EC_ACE_WINDOW
		--	cluster_data: CLUSTER_DATA
	do
		--	if system.project_initialized then
		--		cluster_data := main_window.entity
		--		cluster_data.set_is_root_for_generation (true)
		--		!! ace_window.make (main_window)
		--		ace_window.set_has_cluster (true)
		--	else
		--		windows_manager.popup_message ("Mg","", main_window)
		--	end
	end

end -- class DISPLAY_GENE_COM2
