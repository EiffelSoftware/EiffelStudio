indexing
	description: "Open the Browse to Import a Cluster";
	date: "$Date$";
	revision: "$Revision$"

class 
	LOAD_PROJECT_AUX

inherit
	EV_COMMAND
	ONCES
	WARNING_CALLER

creation
	make

feature -- Creation

	make (m: like main_window) is
		do
			main_window := m
		end

feature -- Properties

	main_window: MAIN_WINDOW

feature
	
	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
		warning: EV_WARNING_DIALOG
		com: EV_ROUTINE_COMMAND
	do
		warning := Windows_manager.warning ( "Wab", "Continue?"	, main_window)
		if warning /= Void then
			warning.show_ok_cancel_buttons
			
			!! com.make (~ok_command)
			warning.add_ok_command (com, Void)
			warning.show
		end
		
	end

ok_action is
	local
	--	import_cluster_box	: FILE_SEL_D
	do
		--import_cluster_box	:= windows.import_cluster_box
	--	import_cluster_box.popup
	end

cancel_action is do end

	ok_command (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			directory_selector: EV_DIRECTORY_DIALOG
			import_cluster: IMPORT_CLUSTER		
		do
			directory_selector := windows_manager.directory_selector (main_window)
			
			if directory_selector /= Void then
				!! import_cluster.make (directory_selector, main_window)
				directory_selector.add_ok_command (import_cluster, Void)
				directory_selector.show
			end
		end


		
end -- class LOAD_PROJECT_AUX
