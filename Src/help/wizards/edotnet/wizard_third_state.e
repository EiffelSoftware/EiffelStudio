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
			up_box, down_box: EV_HORIZONTAL_BOX
			add_button_box: EV_VERTICAL_BOX
			remove_button_box: EV_VERTICAL_BOX
			padding_cell: EV_CELL
		do 
			create references_to_add
			references_to_add.set_column_titles (<< "Name", "Version", "Path" >>)
			references_to_add.set_column_widths (<<100, 60, 135>>)
			references_to_add.set_minimum_height (120)
			references_to_add.select_actions.extend (agent update_buttons_state)
			references_to_add.deselect_actions.extend (agent update_buttons_state)
			
			create added_references
			added_references.set_column_titles (<< "Name", "Version", "Path" >>)
			added_references.set_column_widths (<<100, 60, 135>>)
			added_references.set_minimum_height (60)
			added_references.select_actions.extend (agent update_buttons_state)
			added_references.deselect_actions.extend (agent update_buttons_state)
			fill_lists
			
			create add_button.make_with_text ("Add")
			add_button.select_actions.extend (agent select_assembly)
			set_default_size_for_button (add_button)
			
			create remove_button.make_with_text ("Remove")
			remove_button.select_actions.extend (agent unselect_assembly)
			set_default_size_for_button (remove_button)
			
			create add_button_box
			add_button_box.extend (add_button)
			add_button_box.disable_item_expand (add_button)
			add_button_box.extend (create {EV_CELL})
			create remove_button_box
			remove_button_box.extend (remove_button)
			remove_button_box.disable_item_expand (remove_button)
			remove_button_box.extend (create {EV_CELL})

			create label.make_with_text ("Selected assemblies")
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
			
			if not references_to_add.is_empty then
				references_to_add.first.enable_select
			end
			update_buttons_state (Void)

			set_updatable_entries(<<add_button.select_actions,
									remove_button.select_actions>>)
		end

	proceed_with_current_info is 
		local
			next_window: WIZARD_FINAL_STATE
		do
			Precursor
			message_box.show
			create next_window.make (wizard_information)
			proceed_with_new_state (next_window)
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor
		end


feature {NONE} -- Vision2 controls

	references_to_add: EV_MULTI_COLUMN_LIST

	added_references: EV_MULTI_COLUMN_LIST

	add_button: EV_BUTTON

	remove_button: EV_BUTTON
	
feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Project Location")
			subtitle.set_text ("Where should the Eiffel project be created?")
			message_box.hide
		end

	fill_lists is
			-- Fill 
		local
			assemblies: LIST [ASSEMBLY_INFORMATION]
		do
			assemblies := wizard_information.available_assemblies
			from
				assemblies.start
			until
				assemblies.after
			loop
				references_to_add.extend (build_list_row_from_assembly (assemblies.item))
				assemblies.forth
			end

			assemblies := wizard_information.selected_assemblies
			from
				assemblies.start
			until
				assemblies.after
			loop
				added_references.extend (build_list_row_from_assembly (assemblies.item))
				assemblies.forth
			end
		end
		
	select_assembly is
			-- Add the selected assembly in `selected_assemblies'
		local
			selected_item: EV_MULTI_COLUMN_LIST_ROW
			assembly_info: ASSEMBLY_INFORMATION
		do
			selected_item := references_to_add.selected_item
			if selected_item /= Void then
					-- Modify the multi-column lists
				references_to_add.prune_all (selected_item)
				added_references.extend (selected_item)
				
					-- Modify the internal data
				assembly_info ?= selected_item.data
				check
					assembly_info_not_void: assembly_info /= Void 
				end
				wizard_information.available_assemblies.prune_all (assembly_info)
				wizard_information.selected_assemblies.extend (assembly_info)
			end
		end
		
	unselect_assembly is
			-- Check and remove the selected assembly from `selected_assemblies'
		local
			selected_item: EV_MULTI_COLUMN_LIST_ROW
			assembly_info: ASSEMBLY_INFORMATION
			warning_dialog: EV_CONFIRMATION_DIALOG
		do
			selected_item := added_references.selected_item
			if selected_item /= Void then
				assembly_info ?= selected_item.data
				check
					assembly_info_not_void: assembly_info /= Void 
				end
				
				if assembly_info.name.is_equal ("mscorlib") then
					create warning_dialog.make_with_text (
						"The assembly `mscorlib' contains the Eiffel# kernel and must not be removed.%N%
						% %N%
						%Are you sure you want to remove it?")
					warning_dialog.show_modal_to_window (first_window)
					if warning_dialog.selected_button.is_equal ("OK") then
						remove_assembly (selected_item)
					end
				else
					remove_assembly (selected_item)
				end
			end
		end

	remove_assembly (a_list_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Remove the selected assembly from `selected_assemblies'
		local
			assembly_info: ASSEMBLY_INFORMATION
		do
				-- Modify the multi-column lists
			added_references.prune_all (a_list_item)
			references_to_add.extend (a_list_item)
			
				-- Modify the internal data
			assembly_info ?= a_list_item.data
			check
				assembly_info_not_void: assembly_info /= Void 
			end
			wizard_information.selected_assemblies.prune_all (assembly_info)
			wizard_information.available_assemblies.extend (assembly_info)
		end
		
	update_buttons_state (a_row: EV_MULTI_COLUMN_LIST_ROW)is
			-- Update the state of `Add' and `Remove' buttons
		do
			synchronize_button_state_with_list_selection (add_button, references_to_add)
			synchronize_button_state_with_list_selection (remove_button, added_references)
		end
		
	synchronize_button_state_with_list_selection (a_button: EV_BUTTON; a_list: EV_MULTI_COLUMN_LIST) is
			-- Synchronize `a_button' state with selected state of `a_list'.
		local
			selected_item: EV_MULTI_COLUMN_LIST_ROW
			button_sensitive: BOOLEAN
		do
			selected_item := a_list.selected_item
			button_sensitive := a_button.is_sensitive
			if selected_item = Void and then button_sensitive then
				a_button.disable_sensitive
			elseif selected_item /= Void and then not button_sensitive then
				a_button.enable_sensitive
			end
		end
		
	build_list_row_from_assembly (an_assembly_info: ASSEMBLY_INFORMATION): EV_MULTI_COLUMN_LIST_ROW is
			-- Create an EV_MULTI_COLUMN_LIST_ROW object representing `an_assembly_info'.
		require
			valid_assembly_info: an_assembly_info.valid_assembly
		do
			create Result
			Result.extend (an_assembly_info.name)
			Result.extend (an_assembly_info.version)
			Result.extend (an_assembly_info.path)
			
			Result.set_data (an_assembly_info)
		end

end -- class WIZARD_THIRD_STATE
