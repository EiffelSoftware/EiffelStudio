indexing

	description: "Exiting the application.";
	date: "$Date$";
	revision: "$Revision$"

class EXIT

inherit

	EC_COMMAND;
	ONCES;
	WARNING_CALLER;
	CONSTANTS;
	SHARED_FILE_SERVER;

creation
	make

feature -- Creation

	make (m: like main_window) is
		do
			main_window := m
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Popup warnign dialog to quit project or if
			-- has not been saved popup warnign dialog to ask
			-- user to save before exiting
		do
--			if system.project_initialized and then not system.saved
--			then
--				to_save := True;
--				Windows_manager.popup_warning(Message_keys.save_proj_wa, Void, main_window)
--			else
--				to_save := False;
--				Windows_manager.popup_warning (Message_keys.quit_proj_wa, Void, main_window)
--			end
--		ensure then
--			to_save: to_save implies Windows.main_graph_window.project_initialized and then
--							not Windows.main_graph_window.saved
		end;

feature -- Properties

	main_window: MAIN_WINDOW
				
feature {WARNING_WINDOW} -- Implementation

	to_save: BOOLEAN;
			-- Save project to disk before existing?

	ok_action is
			-- If `to_save' then save project and then
			-- popup warning dialog and question user to exit.
			-- Otherwize, cleanup system and exit eiffelcase.
		local
			store: STORE
		do
--			if to_save then
--				to_save := False;
--	!! store;
--	store.execute (Void)
--				Windows.warning (Windows.main_graph_window, 
--					Message_keys.quit_proj_wa, Void, Current)
--			else
--				Temporary_system_file_server.remove_tmp_files;
--				Class_content_server.delete_classes_not_in_system;
--				--discard_license;
--				Windows.exit
--			end
--		ensure then
--			to_save_is_false: not to_save
		end;

	cancel_action is
			-- If `to_save' then popup warning dialog 
			-- to quit project.	
		do
--			if to_save then
--				to_save := False;
--				Windows.warning (Windows.main_graph_window, 
--					Message_keys.quit_proj_wa, Void, Current)
--			end
--		ensure then
--			to_save_is_false: not to_save
		end;

end -- class EXIT
