indexing
	description: "WEL_CHOOSE_FOLDER_DIALOG which does not need a parent"
	date: "$Date$"
	revision: "$Revision$"

class
	FOLDER_BROWSER_DIALOG

inherit
	WEL_CHOOSE_FOLDER_DIALOG

create
	make

feature -- Basic operations

	activate_without_parent is
			-- Activate the dialog box (modal mode) with no parent.
		local
			id_list: POINTER
		do
			selected := False
			id_list := cwin_sh_browse_for_folder (item)
			if id_list /= default_pointer then
				cwin_sh_get_path_from_id_list (id_list, str_folder_name.item)
				imalloc.free_buffer (id_list)
				if not str_folder_name.string.is_empty then
					selected := True
				end
			else
				str_folder_name.set_string ("")
			end			
		end

end -- class FOLDER_BROWSER_DIALOG
