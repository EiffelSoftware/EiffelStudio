indexing
	description	: "Page in which the user choose where he wants to generate the sources."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_THIRD_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
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
			label: EV_LABEL
			vbox: EV_VERTICAL_BOX
			left_box: EV_VERTICAL_BOX
			right_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			up_box, down_box: EV_HORIZONTAL_BOX
			add_button: EV_BUTTON
			remove_button: EV_BUTTON
			add_button_box: EV_VERTICAL_BOX
			remove_button_box: EV_VERTICAL_BOX
			padding_cell: EV_CELL
		do 
			create references_to_add
			references_to_add.set_column_titles (<< "Name", "Version", "Path" >>)
			references_to_add.set_column_widths (<<100, 60, 135>>)
			references_to_add.set_minimum_height (120)
			fill_lists
			
			create added_references
			added_references.set_column_titles (<< "Name", "Version", "Path" >>)
			added_references.set_minimum_height (60)
			
			create add_button.make_with_text ("Add")
			set_default_size_for_button (add_button)
			create remove_button.make_with_text ("Remove")
			set_default_size_for_button (remove_button)
			create add_button_box
			add_button_box.extend (add_button)
			add_button_box.disable_item_expand (add_button)
			add_button_box.extend (create {EV_CELL})
			create remove_button_box
			remove_button_box.extend (remove_button)
			remove_button_box.disable_item_expand (remove_button)
			remove_button_box.extend (create {EV_CELL})

			create label.make_with_text ("External assemblies")
			label.align_text_left
			
			create up_box
			up_box.set_padding (Small_padding_size)
			up_box.extend (references_to_add)
			up_box.extend (add_button_box)
			up_box.disable_item_expand (add_button_box)
			
			create down_box
			down_box.set_padding (Small_padding_size)
			down_box.extend (added_references)
			down_box.extend (remove_button_box)
			down_box.disable_item_expand (remove_button_box)
			
			create padding_cell
			padding_cell.set_minimum_height (Small_padding_size)
			choice_box.extend (up_box)
			choice_box.extend (padding_cell)
			choice_box.extend (label)
			create padding_cell
			padding_cell.set_minimum_height (Small_border_size)
			choice_box.extend (padding_cell)
			choice_box.extend (down_box)

--			set_updatable_entries(<<location.browse_actions,
--									location.change_actions,
--									to_compile_b.select_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
			dir_name: DIRECTORY_NAME
			next_window: WIZARD_FINAL_STATE
			rescued: BOOLEAN
		do
			Precursor
			create next_window.make (wizard_information)
			proceed_with_new_state (next_window)
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Project Location")
			subtitle.set_text ("Where should the Eiffel project be created?")
--			message.remove_text
			message_box.hide
		end

	references_to_add: EV_MULTI_COLUMN_LIST

	added_references: EV_MULTI_COLUMN_LIST
	
	fill_lists is
			-- 
		local
			cur_filename: FILE_NAME
			assembly_helper: ASSEMBLY_HELPER
			a_row: EV_MULTI_COLUMN_LIST_ROW
			corpath_directory_name: STRING
			corpath_directory: DIRECTORY
			assembly_files: ARRAYED_LIST [STRING]
		do
			corpath_directory_name := execution_environment.get ("CORPATH")
			if corpath_directory_name /= Void then
				if (corpath_directory_name @ corpath_directory_name.count) = Operating_environment.Directory_separator then
					corpath_directory_name := corpath_directory_name.substring (1, corpath_directory_name.count - 1)
				end
				create corpath_directory.make (corpath_directory_name)
				if corpath_directory.exists then
					assembly_files := corpath_directory.linear_representation
					
					from
						assembly_files.start
					until
						assembly_files.after
					loop
						create cur_filename.make_from_string (corpath_directory_name)
						cur_filename.set_file_name (assembly_files.item) -- "mscorlib.dll")
						create assembly_helper.make (cur_filename)
						if assembly_helper.valid_assembly then
							create a_row
							a_row.extend (assembly_helper.name)
							a_row.extend (assembly_helper.version)
							a_row.extend (cur_filename)
							references_to_add.extend (a_row)
						end
						assembly_files.forth
					end
				end
			end
		end

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Shared execution environment object
		once
			create Result
		end		

end -- class WIZARD_THIRD_STATE
