indexing
	description: "class that supports Eiffel generation";
	date: "$Date$";
	revision: "$Revision$"

class
	LAUNCH_GENE_COM

inherit
	CLOSE_WINDOW_COM
		redefine
			execute
		end

	CONSTANTS

	ONCES

creation
	make

feature

	make ( ace: like ace_window ) is
	do
		ace_window := ace
	end

	ace_window: EC_ACE_WINDOW

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			--change_re_path: CHANGE_RE_PATH_U;
			--generate_classes_html : GENERATE_CLASSES_HTML
			cluster_selected	: CLUSTER_DATA
		do
			system.set_error_occured (false)
			System.init_counter
			if ace_window.has_cluster then
				System.set_total ( ace_window.entity)
				cluster_selected	:= ace_window.entity
				cluster_selected.generate_code_for_cluster_root_for_generation
			else
				System.set_total ( System.root_cluster)
				System.generate_to_eiffel_project (ace_window)
			end
			System.init_counter
				-- this is to avoid to re-enter set_class_label
				-- and set_class_cluster in other context
				-- that Eiffel generation in files
	
			if not system.error_occured then
				-- The generation did not encounter any problem
				windows_manager.popup_message ("Mai", "", ace_window)
			end 
		end

end -- class LAUNCH_GENE_COM
