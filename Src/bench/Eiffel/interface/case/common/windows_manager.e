indexing
	description: "Class responsible for managing the windows"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOWS_MANAGER

inherit
	CONSTANTS

	ONCES

feature -- Implementation

	first_window: MAIN_WINDOW is
		once
			!! Result.make_top_level
			Result.show
		end

	error_tracks: ERROR_TRACKS is
		once
			!! Result.make
		end
	

feature -- Errors 

	add_error_message (s: STRING) is
		-- Add error message to a file.
		require
			string_possible: s/= Void and then not s.empty
		do
			error_tracks.add_message(s)
		end

feature -- Access

	popup_message(key,extra: STRING; caller: EV_WINDOW) is
		-- Popup a windows with message 's'
		require
			key_not_void: key /= Void
			caller_exists: caller /= Void 
		do
			clear_all_popups
			popup_windows.message(key,extra,caller)		
		end
	
	popup_error(key,extra: STRING;caller: EV_WINDOW) is
		-- Popup a windows with message 's'
		require
			key_not_void: key /= Void
			caller_exists: caller /= Void 
		do
			clear_all_popups
			popup_windows.error(key,extra,caller)		
		end

	warning (key,extra: STRING;caller: EV_WINDOW): EV_WARNING_DIALOG is
		-- Popup a windows with message 's'
		require
			key_not_void: key /= Void
			caller_exists: caller /= Void 
		local
			message: STRING
		do
			clear_all_popups
			Result := popup_windows.warning_window (caller)			

			if Result /= Void then
				message := popup_windows.result_string (key, extra, popup_windows.warnings)
				Result.set_message (message)
			end
		end

feature -- Clearances ...

	clear_all_popups is
		-- Close all popup windows before
		-- opening a new one.
		do
			popup_windows.clear_all
		end

	clear_all_windows is
			-- Clear all windows exept the main one.
		do
			clear_all_popups
			from
				editor_list.start
			until
				editor_list.after
			loop
				editor_list.item.destroy
				editor_list.forth
			end
			editor_list.wipe_out
		end

feature -- Implementation

	editor_list: LINKED_LIST [ EC_EDITOR_WINDOW [ ANY ] ] is
		once
			!! Result.make
		end
		
	report_list: LINKED_LIST [ REPORT_WINDOW ] is
		once
			!! Result.make
		end

	html_list: LINKED_LIST [ HTML_WINDOW ] is
		once
			!! Result.make
		end

	--generator_list: LINKED_LIST [ GENERATOR_WINDOW [ ANY ] ] is
	--	once
	--		!! Result.make
	--	end

	--configurator_list: LINKED_LIST [ CONFIGURATOR_WINDOW [ ANY ] ] is
	--	once
	--		!! Result.make
	--	end

feature -- Adding/Removing

	update_all is
		do
			if System.root_cluster /= Void then

				-- All the list must be Updated
				--main_window.update_from(System.root_cluster)
			end
		end

	add_editor(ed: EC_EDITOR_WINDOW[ANY]) is
			-- Add the editor 'ed' to the list of editors
		do
			editor_list.extend(ed)
		end

	remove_editor(ed: EC_EDITOR_WINDOW[ANY]) is
			-- Remove 'ed' from the list of editors
		require
			editor_destroyed: ed.destroyed
		do
			if editor_list.has(ed) then
				editor_list.prune(ed)
			end
		end

	find_editor(entity: ANY): LINKED_LIST [ EC_EDITOR_WINDOW [ ANY ] ] is
		-- Find the editors currently editing 'entity'
		do
			from
				!! Result.make
				editor_list.start
			until
				editor_list.after
			loop
				if editor_list.item.entity /= Void then
				--		and then editor_list.item.entity.same_as(entity) then
				--	Result.extend(editor_list.item)
				end
				editor_list.forth
			end				
		end

feature -- Browsers

	open_file_browser (w: EV_WINDOW) : EV_FILE_OPEN_DIALOG is
		do
			!! Result.make (w)
		end

	directory_selector (w: EV_WINDOW) : EV_DIRECTORY_DIALOG is
		do
			!! Result.make (w)
		end
end -- class WINDOWS_MANAGER
