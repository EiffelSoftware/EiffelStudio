indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	wizard_first_state

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	EXECUTION_ENVIRONMENT
		rename
			command_line as cmd_line
		end

create
	make

feature -- Basic Operation

	build is
			-- Build interface 
		local
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
			lab: EV_LABEL
			txt: WIZARD_SMART_TEXT
			cell: EV_CELL
		do 
			create to_precompile_libraries
			create precompilable_libraries
			to_precompile_libraries.set_column_titles (<<"Library name", "Done ?" >>)
			to_precompile_libraries.set_column_widths (<<90, 50>>)
			precompilable_libraries.set_column_titles (<<"Library name", "Done ?" >>)
			precompilable_libraries.set_column_widths (<<90, 50>>)

			create h1

			create v1
			create lab.make_with_text("Compilable libraries")
			v1.extend(lab)
			v1.disable_item_expand(lab)
			v1.extend(precompilable_libraries)
			h1.extend(v1)

		
			create v1

			create add_all_b.make_with_text ("Add all ->")
			add_all_b.select_actions.extend (~add_all_items)
			v1.extend (add_all_b)
			add_all_b.set_minimum_width (25)
			add_all_b.set_minimum_height (23)
			add_all_b.align_text_center
			v1.disable_item_expand (add_all_b)
			v1.extend (create {EV_CELL})

			create add_b.make_with_text ("Add->")
			add_b.select_actions.extend (~add_items)
			v1.extend (add_b)
			add_b.set_minimum_width (15)
			add_b.set_minimum_height (23)
			add_b.align_text_center
			v1.disable_item_expand (add_b)

			create remove_b.make_with_text ("<-Remove")
			remove_b.select_actions.extend (~remove_items)
			v1.extend (remove_b)
			remove_b.set_minimum_width (15)
			remove_b.set_minimum_height (23)
			remove_b.align_text_center
			v1.disable_item_expand (remove_b)
			v1.extend (create {EV_CELL})

			create remove_all_b.make_with_text ("<- Remove all")
			remove_all_b.select_actions.extend (~remove_all_items)
			v1.extend (remove_all_b)
			remove_all_b.set_minimum_width (25)
			remove_all_b.set_minimum_height (23)
			remove_all_b.align_text_center
			v1.disable_item_expand (remove_all_b)

			v1.set_padding (5)
			v1.set_border_width (5)
			h1.extend(v1)


			create v1
			create lab.make_with_text("Libraries to compile")
			v1.extend(lab)
			v1.disable_item_expand(lab)
			v1.extend(to_precompile_libraries)		
			h1.extend(v1)

			precompilable_libraries.enable_multiple_selection
			to_precompile_libraries.enable_multiple_selection
			precompilable_libraries.select_actions.extend (~enable_add_b)
			precompilable_libraries.deselect_actions.extend (~enable_add_b)
			to_precompile_libraries.select_actions.extend (~enable_remove_b)
			to_precompile_libraries.deselect_actions.extend (~enable_remove_b)

			add_b.disable_sensitive
			remove_b.disable_sensitive

			choice_box.extend(h1)

			create add_your_own_b.make_with_text_and_action ("Add your own library...", ~browse)
			create h1
			h1.set_border_width (5)
			create cell
			cell.set_minimum_width (70)
			h1.extend (cell)
			h1.extend (add_your_own_b)
			h1.disable_item_expand (add_your_own_b)

			choice_box.extend (h1)			

			if wizard_information.l_to_precompile /= Void then
				fill_lists_from_previous_state
			else
				fill_lists
			end

			set_updatable_entries(<<precompilable_libraries.select_actions,
									to_precompile_libraries.select_actions>>)

		end

	proceed_with_current_info is 
		do
			Precursor
			if no_lib_selected then
--				proceed_with_new_state(Create {WIZARD_NO_LIB_STATE}.make(wizard_information))
			else
				proceed_with_new_state(Create {WIZARD_FINAL_STATE}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
			-- Update the two lists of precompilable and to_precompile libraries
			-- If no item have been selected, we fill an empty list
		local
			lin_list, lin_list_2: LINEAR [EV_MULTI_COLUMN_LIST_ROW]
			list: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			lin_list:= to_precompile_libraries.linear_representation
			lin_list_2:= precompilable_libraries.linear_representation
			from 
				lin_list.start
				create list.make
			until
				lin_list.after
			loop
				list.extend (lin_list.item)
				lin_list.forth
			end
			if list /= Void then
				wizard_information.set_l_to_precompile (list)
			else
				create list.make
				wizard_information.set_l_to_precompile (list)
				no_lib_selected:= TRUE
			end

			from 
				lin_list_2.start
				create list.make
			until
				lin_list_2.after
			loop
				list.extend (lin_list_2.item)
				lin_list_2.forth
			end
			if list /= Void then
				wizard_information.set_l_precompilable (list)
			else
				create list.make
				wizard_information.set_l_precompilable (list)
			end

			wizard_information.set_es4_location (es4_location)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("CHOOSE LIBRARIES")
			message.set_text ("Choose the libraries you want to precompile. You can even add your own library.")
		end

feature -- Tools

	fill_lists is
			-- Fill the EV_MULTI_COLUMN_LIST for all the compilable libraries
			-- To determine the compilable libraries, we check the $EIFFEL4 directory
			-- This function fill the library from *scratch*
			-- If the user has hit Back, then fill_lists_from_previous_state will be
			-- called
		local
			it: EV_MULTI_COLUMN_LIST_ROW
			eiffel_directory: DIRECTORY
			list_of_preprecompilable_libraries: ARRAYED_LIST [STRING]
			current_lib, eif_4, plat: STRING
		do
			eif_4 := get ("EIFFEL4")
			plat := get ("PLATFORM")

			es4_location := eif_4 + "/bench/spec/" + plat + "/bin/"

			create eiffel_directory.make_open_read (eif_4 + "\precomp\spec\windows")
			if eiffel_directory.exists then
				list_of_preprecompilable_libraries:= eiffel_directory.linear_representation

				from 
					list_of_preprecompilable_libraries.start
				until
					list_of_preprecompilable_libraries.after
				loop
					current_lib:= list_of_preprecompilable_libraries.item
					it:= fill_ev_list_items (eiffel_directory.name + "/" + current_lib, "ace.ace")
					if it /= Void then
						precompilable_libraries.extend (it)
					end
					list_of_preprecompilable_libraries.forth
				end
			end
		end

	fill_ev_list_items (path_lib: STRING; ace_name: STRING): EV_MULTI_COLUMN_LIST_ROW is
			-- retrun an ev_multi_column_list_item with the name of the system for text 
			-- and the path of the ace file for data.
			-- 'dir/lib' is the directory where the ace file should be
			-- for the ISE precompile libraries
		local
			fi: PLAIN_TEXT_FILE
			s: STRING
			sys_name: STRING
			it: EV_MULTI_COLUMN_LIST_ROW
			ind_1, ind_2: INTEGER
			int_dir: DIRECTORY
			list_of_file: ARRAYED_LIST [STRING]
			info_lib: TUPLE [STRING, BOOLEAN]
		do
			it:= Void
			create int_dir.make_open_read (path_lib)
			if int_dir.exists then
				list_of_file:= int_dir.linear_representation
				list_of_file.compare_objects
				if list_of_file.has (ace_name) then
					create fi.make_open_read (path_lib + "/" + ace_name)
					fi.read_stream (fi.count)
					s:= clone (fi.last_string)
					fi.close
					ind_1:= s.substring_index ("system", 1)
					ind_2:= s.substring_index ("root", 1)
					sys_name:= s.substring (ind_1 + 6, ind_2-1)
					sys_name.replace_substring_all (" ", "")
					sys_name.replace_substring_all ("%R", "")
					sys_name.replace_substring_all ("%N", "")
					sys_name.replace_substring_all ("%T", "")

					create it			
					create info_lib.make
					info_lib.put (path_lib + "/" + ace_name, 1)
					if list_of_file.has ("EIFGEN") then
						info_lib.put (True, 2)
						it.extend (sys_name)
						it.extend ("Already")
					else
						info_lib.put (False, 2)
						it.extend (sys_name)
						it.extend ("No")
					end
					it.set_data (info_lib)	
				else
					error_no_ace:= TRUE
				end
			end
			Result:= it			
		end

	fill_lists_from_previous_state is
			-- Fill the MULTI_COLUMN_LIST when the user has previously 
			-- choose its library to precompile.
			-- Can occur only if the user has pushed the Back button
		local
			
		do

			from 
				wizard_information.l_to_precompile.start
			until
				wizard_information.l_to_precompile.after
			loop
				to_precompile_libraries.extend (wizard_information.l_to_precompile.item)
				wizard_information.l_to_precompile.forth
			end

			from 
				wizard_information.l_precompilable.start
			until
				wizard_information.l_precompilable.after
			loop
				precompilable_libraries.extend (wizard_information.l_precompilable.item)
				wizard_information.l_precompilable.forth
			end

		end
	
	add_all_items is
			-- Add all the item from precompilable_libraries to to_precompile_libraries
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			from 
				precompilable_libraries.start
			until
				precompilable_libraries.after
			loop
				it := precompilable_libraries.item
				it.enable_select
				precompilable_libraries.forth
			end
			add_b.disable_sensitive
			add_items
		ensure
			precompilable_libraries.empty
		end

	add_items is
		local
			currently_selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			currently_selected_items := precompilable_libraries.selected_items
			from 
				currently_selected_items.start
			until
				currently_selected_items.after 
			loop
				it := currently_selected_items.item
				precompilable_libraries.prune (it)
				to_precompile_libraries.extend (it)
				currently_selected_items.forth
			end
			add_b.disable_sensitive
		end

	remove_all_items is
			-- Remove all the item from to_precompile_libraries to precompilable_libraries
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			from 
				to_precompile_libraries.start
			until
				to_precompile_libraries.after
			loop
				it:= to_precompile_libraries.item
				it.enable_select
				to_precompile_libraries.forth
			end
			remove_b.disable_sensitive
			remove_items
		ensure
			to_precompile_libraries.empty
		end

	remove_items is
		local
			currently_selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			currently_selected_items := to_precompile_libraries.selected_items
			from 
				currently_selected_items.start
			until
				currently_selected_items.after
			loop
				it := currently_selected_items.item
				to_precompile_libraries.prune (it)
				precompilable_libraries.extend (it)
				currently_selected_items.forth
			end
			remove_b.disable_sensitive
		end

	enable_add_b (it: EV_MULTI_COLUMN_LIST_ROW) is
		do
			if precompilable_libraries.selected_item = Void then
				add_b.disable_sensitive
			else
				add_b.enable_sensitive
			end
		end

	enable_remove_b (it: EV_MULTI_COLUMN_LIST_ROW) is
		do
			if to_precompile_libraries.selected_item = Void then
				remove_b.disable_sensitive
			else
				remove_b.enable_sensitive
			end
		end

	browse is
			-- Launch a computer file Browser.
		local
			file_selector: EV_FILE_OPEN_DIALOG  
		do
			create file_selector
			file_selector.set_filter ("*.ace")
			file_selector.ok_actions.extend(~file_selected(file_selector))
			file_selector.show_modal
		end

	file_selected (file_selector: EV_FILE_OPEN_DIALOG) is
			-- The user selected a directory from the browser. 
			-- It updates the to_precompile_libraries list accordingly.
		require
			selector_exists: file_selector /= Void
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			it:= fill_ev_list_items (file_selector.file_path.substring (1, file_selector.file_path.count - 1), file_selector.file_title)

				to_precompile_libraries.extend (it)
				it.enable_select
				it.disable_select
					 -- enable and disable select such that the set_updatable_entries will react
					-- and update_state_information will be call
		end


feature -- Implementation

	no_lib_selected: BOOLEAN
		-- Is at least a library has been selected by the user

	error_no_ace: BOOLEAN
		-- Is there an ace file "ace.ace" in the library directory

	precompilable_libraries: EV_MULTI_COLUMN_LIST
		-- List of precombilable libraries

	to_precompile_libraries: EV_MULTI_COLUMN_LIST
		-- List of libraries to precompile

	remove_b, add_b, remove_all_b, add_all_b: EV_BUTTON

	add_your_own_b: EV_BUTTON
		-- button to let the user add his own library

	es4_location: STRING
		-- ebench infos

--	wizard_warning: WIZARD_WARNING
		-- Warning box for the wizard


end -- class wizard_first_state
