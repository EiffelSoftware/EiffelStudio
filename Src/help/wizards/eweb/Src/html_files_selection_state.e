indexing
	description: "Page which allows the user to select the files he wants%
				  % to deal with."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FILES_SELECTION_STATE


inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			h1: EV_HORIZONTAL_BOX
		do 
			Create h1
			h1.extend(Create {EV_BUTTON}.make_with_text_and_action("Add File",
				~popup_selector(Create {EV_FILE_OPEN_DIALOG})))
			h1.extend(Create {EV_BUTTON}.make_with_text_and_action("Add Directory",
				~popup_selector(Create {EV_DIRECTORY_DIALOG})))
			choice_box.extend(h1)
			choice_box.disable_child_expand(h1)
			Create selected_files
			choice_box.extend(selected_files)
			Create h1
			h1.extend(Create {EV_BUTTON}.make_with_text_and_action("Remove Selected Files",~remove_selected_files))
			h1.extend(Create {EV_BUTTON}.make_with_text_and_action("Reset",~reset))
			choice_box.extend(h1)
			choice_box.disable_child_expand(h1)
		end

	remove_selected_files is
		do

		end

	reset is 
		do

		end

	popup_selector(dialog: EV_STANDARD_DIALOG) is
		do
			dialog.ok_actions.extend(~add_files(dialog))
			dialog.show_modal
		end

	add_files(dialog: EV_STANDARD_DIALOG) is
		local
			fi: EV_FILE_DIALOG
			di: EV_DIRECTORY_DIALOG
			it: EV_LIST_ITEM
			s,s1,s2,dir: STRING
			direc: DIRECTORY
			fin: FILE_NAME
		do
			fi ?= dialog
			if fi /= Void then
				if fi.file_name /= Void then 
					Create it.make_with_text(fi.file_name)
					it.set_data(fi.file_name)
					selected_files.extend(it)
				end
			else
				di ?= dialog
				check
					dialog_is_directory_selector: di /= Void
				end
				if di.directory /= Void then
					dir := di.directory
					-- Let's find all the files.
					Create direc.make_open_read(dir)
					from
						direc.start
						direc.readentry
					until
						direc.lastentry = Void
					loop
						s := direc.lastentry
						if not s.item(1).is_equal('.') and then not (s.count<5) then
							if s.count>5 then
								s1 := s.substring(s.count-4,s.count)
							else
								s1 := ""
							end
							s2 := s.substring(s.count-3,s.count)
							s1.to_upper
							s2.to_upper
							if s1.is_equal(".HTML") or else s2.is_equal(".HTM") then
								Create it.make_with_text(s)
								Create fin.make_from_string(dir)
								fin.extend(s)
								it.set_data(fin)
								selected_files.extend(it)
							end
						end
						direc.readentry
					end
					direc.close
				end
			end
		end
	
	update_state_information is
			-- Check User Entries
		do
			Precursor
		end

	proceed_with_current_info is 
			-- Proceed, go to next state.
		local
			dir: DIRECTORY
		do
			Precursor
			proceed_with_new_state(Create {FINAL_STATE}.make(wizard_information))
		end

feature -- Access

	selected_files: EV_LIST

feature {NONE} -- Implementation

	pixmap_location: STRING is "small_essai.bmp"

	title: STRING is "HTML Forms selection"

	message: STRING is "Please select the HTML files you wish to add%N%
						%to your repository."

end -- class HTML_FILES_SELECTION_STATE
