indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RESOURCE_BENCH_SECOND_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	TABLE_OF_SYMBOLS

	ERROR_HANDLING

	INTERFACE_MANAGER

	EXECUTION_ENVIRONMENT
		rename
			command_line as ex_command_line
		end

	TDS_DEFINE_TABLE

	RB_DATA
		rename
			title as rb_title
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
				local
			browse_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
			root_node, first_dialog_node: EV_TREE_NODE
		do 
			do_analyze
--			tree_view.set_minimum_height (300)
			tree_view.set_minimum_width (90)
			create h1
--			h1.set_minimum_height (300)
			h1.extend (tree_view)
			h1.disable_item_expand (tree_view)
			choice_box.extend (h1)

			create client_window.make (Current)

			tree_view.select_actions.extend (~on_tree_item_selection)

			h1.extend (client_window.properties_dialog)

			root_node:= tree_view.first
			root_node.start
			dialog_node:= root_node.item
			dialog_node.start
			first_dialog_node:= dialog_node.item

			first_dialog_node.enable_select

			set_updatable_entries(<<tree_view.select_actions, tree_view.deselect_actions>>)
--			client_window.properties_dialog.show
		end

	proceed_with_current_info is 
		local
			first_dialog_node: EV_TREE_NODE
		do
			client_window.change_and_display

			if check_inherited_class then
				wizard_information.set_root_dialog_name (root_dialog_name)
				Precursor
				proceed_with_new_state(Create {WIZARD_THIRD_STATE}.make(wizard_information))
			else
				Precursor
				proceed_with_new_state(Create {WIZARD_ERROR_RESSOURCE_BENCH}.make(wizard_information))	
			end
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor
		end

feature {NONE} -- Implementation

	on_tree_item_selection (a_item: EV_TREE_ITEM) is
		do
			client_window.set_new_resource (tds.access_tree_view_item (a_item))
			client_window.change_and_display
		end

	display_state_text is
		do
			title.set_text ("DIALOGS SETTING")
			message.set_text ("Choose the options to be generated for each dialogs.%N")
		end


feature -- Process

	check_inherited_class: BOOLEAN is
		local
			current_dialog: TDS_DIALOG
			no_error, main_class_found: BOOLEAN
		do
			from 
				dialog_node.start
				no_error:= True
				main_class_found:= False
			until
				dialog_node.after or not no_error
			loop
				current_dialog ?= tds.access_tree_view_item (dialog_node.item)
				if current_dialog.inherited_class.is_equal ("WEL_MAIN_DIALOG") then
					if main_class_found then
						no_error:= False
					else
						main_class_found:= True
						root_dialog_name:= current_dialog.class_name
						root_dialog_name.to_upper
					end
				end
				dialog_node.forth
			end
			Result:= no_error and main_class_found
		end

	do_analyze is 
			-- Analyze a resource script `a_filename'.
		local
			filename: STRING
		do
			create_tree_view_control (wizard_information.rc_location)
		end

	create_tree_view_control (a_filename: STRING) is
			-- Create the tree view control corresponding to the analyzed resource script `filename'.
		require
			a_filename_exists: a_filename /= Void and then a_filename.count > 0
		local
			tv_item: EV_TREE_ITEM
		do
			interface.display_text (std_out, "Creating the tree view control...")

			if (tree_view /= Void) then -- and then (tree_view.exists) then
				tree_view.destroy
			end

			create tree_view

			create tv_item.make_with_text (a_filename)

			tree_view.extend (tv_item)
			tds.generate_tree_view (tv_item)
		end

	client_window: CLIENT_WINDOW

	tree_view: EV_TREE

	dialog_node: EV_TREE_NODE

	root_dialog_name: STRING

end -- class WIZARD_RESOURCE_BENCH_SECOND_STATE
