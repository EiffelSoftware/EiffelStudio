indexing
	description: "Open The Ace Window with the whole System";
	date: "$Date$";
	revision: "$Revision$"

class
	DISPLAY_GENE_COM

inherit
	MAIN_PANEL_COM

creation
	make

feature -- Creation

	make (m: like main_window) is
		do
			main_window := m
		end

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		do
		end;

	main_window: MAIN_WINDOW

feature -- Execution (work)

	work (not_used: ANY) is
			-- Display the Generate Eiffel window (creating it if 
			-- necessary). 
		local
		--	ace_window: EC_ACE_WINDOW
		--	cluster_data: CLUSTER_DATA
		do
		--	if system.project_initialized then
		---		cluster_data := main_window.entity
		--		cluster_data.set_is_root_for_generation (true)
		--		!! ace_window.make (main_window)
		--		ace_window.set_has_cluster ( FALSE )
		--		ace_window.show
		--	else
		--		windows_manager.popup_message ("Mg","", main_window)
		--	end
		end;



end -- class DISPLAY_GENE_COM
