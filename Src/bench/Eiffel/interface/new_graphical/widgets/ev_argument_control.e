indexing
	description: 	"Abstraction of an control allowing adding, removal and in-place editing of%
					%project-wide and user customised program arguments"
	author: ""
	date: "08/05/2002"
	revision: "1.0"

class
	EB_ARGUMENT_CONTROL

inherit

	EV_VERTICAL_BOX
	
	EB_CONSTANTS
		undefine
			default_create, copy, is_equal
		end

	PROJECT_CONTEXT
		undefine
			default_create,	copy, is_equal
		end

	LACE_AST_FACTORY
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_INTERFACE_TOOLS
		rename
			mode as text_mode
		undefine
			default_create, copy, is_equal
		end
	
	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create 
	make
	
feature {NONE} -- Initialization

	make (a_parent: EV_WINDOW) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
		do
			default_create
			parent_window := a_parent
			set_padding (Layout_constants.Default_padding_size)
			extend (execution_frame)
			update
		end
		
feature {NONE} -- Retrieval		
		
	retrieve_ace_arguments is
			-- Check content of Ace file and if valid set retrieve arguments.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			d_opt: D_OPTION_SD
			opt: OPTION_SD
			val: OPT_VAL_SD
			argument_value: STRING
			free_option: FREE_OPTION_SD
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			ace_arguments_list.wipe_out
			ace_combo.wipe_out
			create l_row
			ace_arguments_list.extend (l_row)
			l_row.put_front (no_arg_string)
			ace_combo.extend (create {EV_LIST_ITEM}.make_with_text (no_arg_string))
			set_mode (Ace_mode)
			root_ast := retrieve_ace
			if root_ast /= Void then
				defaults := root_ast.defaults
				if defaults /= Void then
					from
						defaults.start
					until
						defaults.after
					loop
						d_opt := defaults.item
						opt := d_opt.option
						val := d_opt.value
						if opt.is_free_option then
							free_option ?= opt
							inspect 
								free_option.code
							when feature {FREE_OPTION_SD}.arguments then
								argument_value := val.value
								if 
									not (argument_value.is_empty or else
									argument_value.is_equal (no_arg_string) or else
									argument_value.is_equal (" "))
								then
										-- Add argument to list.
									create l_row
									ace_arguments_list.extend (l_row)
									l_row.put_front (argument_value)
										-- Add argument to combo.
									ace_combo.extend (create {EV_LIST_ITEM}.make_with_text (argument_value))
								end					
								defaults.remove
								defaults.back
							when feature {FREE_OPTION_SD}.working_directory then
								defaults.remove
								defaults.back
								set_working_directory (val.value)
							else
								-- Do nothing
							end
						end
						defaults.forth
					end
				end
			end
		end
		
	retrieve_user_arguments is
			-- Retrieve and initialize the user specific arguments from 'arguments.wb'.
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do	
			user_arguments_list.wipe_out
			user_combo.wipe_out
			create l_row
			user_arguments_list.extend (l_row)
			l_row.put_front (no_arg_string)
			user_combo.extend (create {EV_LIST_ITEM}.make_with_text (no_arg_string))
			set_mode (User_mode)
			create arguments_file.make (Arguments_file_name)
			if not arguments_file.exists then
				-- Create new arguments file.
				arguments_file.create_read_write
			end
			if not arguments_file.is_empty then
				from
					arguments_file.open_read
					arguments_file.start
				until
					arguments_file.end_of_file
				loop
					arguments_file.read_line
					if 
						arguments_file.last_string /= Void and 
						not (arguments_file.last_string.is_empty or else
							arguments_file.last_string.is_equal (no_arg_string) or else
							arguments_file.last_string.is_equal (" "))
					then
							-- Add argument to list.
						create l_row
						user_arguments_list.extend (l_row)
						l_row.put_front (clone (arguments_file.last_string))
							-- Add argument to combo.
						user_combo.extend (create {EV_LIST_ITEM}.make_with_text (arguments_file.last_string))
					end
				end
				arguments_file.close	
			end
		end
		
	retrieve_ace: ACE_SD is
			-- Retrieve the current lace file
		local
			l_file_name: STRING
			l_file: PLAIN_TEXT_FILE
		do
			l_file_name := Eiffel_ace.file_name
			create l_file.make (l_file_name)
			if l_file.exists and then l_file.is_readable then
				Result := Eiffel_ace.Lace.parsed_ast
			end
		end

feature -- Storage

	store_arguments (a_root_ast: ACE_SD) is
			-- Store the current arguments to their corresponding files and set current 
			-- arguments for system execution.
		local
			l_arg: STRING
		do
			if current_argument.text.is_equal (no_arg_string) then
				l_arg := " "
			else
      			l_arg := current_argument.text	
      		end
			if Workbench.system_defined then
      			Lace.argument_list.put_front (l_arg)
      		else
      			saved_argument := l_arg
           	end
			save_ace_arguments (a_root_ast)
			save_custom_arguments
			synch_with_others
		end

feature {NONE} -- Storage

	save_ace_arguments (a_root_ast: ACE_SD) is
         	-- Store content of `ace_arguments_list' into `root_ast'.
 		local
          	defaults: LACE_LIST [D_OPTION_SD]
            free_option: FREE_OPTION_SD
            val: OPT_VAL_SD
            d_option: D_OPTION_SD
            opt: OPTION_SD
            wd, argument_text: STRING
     	do
         	if root_ast = Void then
            	root_ast := retrieve_ace
            elseif a_root_ast /= Void then
            	root_ast := a_root_ast
           	end

            defaults := root_ast.defaults
            
            from
            	defaults.start
           	until
             	defaults.after
           	loop
            	d_option := defaults.item
             	opt := d_option.option
             	val := d_option.value
          	if opt.is_free_option then
             	free_option ?= opt
	         	inspect
	            	free_option.code
	          	when feature {FREE_OPTION_SD}.arguments then
	             	defaults.remove
				 	defaults.back
	           	else 
          		end
         	end
            	defaults.forth
           	end
            
            if ace_arguments_list.count > 0 then
 				from
             		ace_arguments_list.start
             	until
            		ace_arguments_list.after
             	loop
             		argument_text := escape_argument (ace_arguments_list.item.i_th (1))
             		defaults.extend (new_d_option (argument_text))
			    	ace_arguments_list.forth
             	end
             end
            
            	-- Save working directory. 
            wd := working_directory_path
			if not wd.is_empty then
				defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.working_directory, wd, True))
			end
			if Workbench.system_defined then
				Lace.set_application_working_directory (wd)
			end
			save_ace
     	end	

	save_custom_arguments is
			-- Save user custom arguments to 'arguments.wb'.	
		require
			file_exists: arguments_file.exists
			file_not_open: arguments_file.is_closed
		local
			argument_text: STRING
		do
			from
				arguments_file.wipe_out
				arguments_file.open_write
				arguments_file.start
				user_arguments_list.start
			until
				user_arguments_list.after
			loop
				argument_text := clone (escape_argument (user_arguments_list.item.i_th (1)))
				arguments_file.putstring (argument_text)
				arguments_file.new_line
				user_arguments_list.forth
			end
			arguments_file.close
		end

	save_ace is
			-- Save the arguments to the Ace file.
		local
			ast: ACE_SD
			ace_file: PLAIN_TEXT_FILE
			st: GENERATION_BUFFER
		do
			ast := root_ast.duplicate
			create st.make (2048)
			ast.save (st)
			if Eiffel_ace.file_name = Void then
				Eiffel_ace.set_file_name ("Ace.ace")
			end
			create ace_file.make (Eiffel_ace.file_name)
			if not ace_file.exists or else ace_file.is_writable then
				ace_file.open_write
				ace_file.put_string (st)
				ace_file.close
			end
			ast := Eiffel_ace.Lace.parsed_ast
		end	

feature {NONE} -- GUI

	execution_frame: EV_VERTICAL_BOX is
			-- Frame widget containing argument controls.
		local
			vbox, vbox2: EV_VERTICAL_BOX
			l_frame: EV_FRAME
		do
				-- Create all widgets.
			create working_directory.make_with_text_and_parent ("Working directory: ", parent_window)
			create argument_list.make (parent_window)
			create argument_combo
			create current_argument
			create ace_arguments_list.make (parent_window)
			create ace_combo
			create ace_current_arg_text
			create user_arguments_list.make (parent_window)
			create user_combo
			create user_current_arg_text
			create notebook
			create Result
			
			
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
				-- Working directory.
			create l_frame.make_with_text ("Working Directory")
			l_frame.extend (vbox)
			vbox.extend (working_directory)
			Result.extend (l_frame)
			Result.disable_item_expand (l_frame)
			
				-- Ace file arguments tab.
			set_mode (Ace_mode)
			create project_args_tab
			populate_by_template (project_args_tab)
			notebook.extend (project_args_tab)
			notebook.set_item_text (project_args_tab, "Project Arguments")
			
				-- My Arguments tab.
			set_mode (User_mode)
			create user_args_tab
			populate_by_template (user_args_tab)
			notebook.extend (user_args_tab)
			notebook.set_item_text (user_args_tab, "My Arguments")
				
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			create l_frame.make_with_text ("Arguments")
			create argument_check.make_with_text ("Enable arguments")
			l_frame.extend (vbox)
			vbox.extend (argument_check)
			vbox.extend (notebook)
			Result.extend (l_frame)
			
			ace_arguments_list.set_all_editable
			user_arguments_list.set_all_editable
			ace_combo.disable_edit
			user_combo.disable_edit
			
				-- Global actions.
			pointer_leave_actions.extend (agent synch_with_others)
			
				-- Check button actions
			argument_check.select_actions.extend (agent arg_check_selected)
			
				-- Notebook actions.
			notebook.selection_actions.extend (agent on_tab_changed)
			
				-- List actions.
			ace_arguments_list.focus_in_actions.force_extend (agent refresh)
			user_arguments_list.focus_in_actions.force_extend (agent refresh)
			ace_arguments_list.select_actions.force_extend (agent argument_selected (ace_arguments_list))
			user_arguments_list.select_actions.force_extend (agent argument_selected (user_arguments_list))
			ace_arguments_list.end_edit_actions.extend (agent on_list_edited)
			user_arguments_list.end_edit_actions.extend (agent on_list_edited)
			
				-- Combo actions.
			ace_combo.select_actions.force_extend (agent argument_selected (ace_combo))
			user_combo.select_actions.force_extend (agent argument_selected (user_combo))
		end

	populate_by_template (a_vbox: EV_VERTICAL_BOX) is
			-- Populate 'a_vbox' with widgets and associated events.
		require
			a_box_not_void: a_vbox /= Void
		local
			l_horizontal_box: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_label: EV_LABEL
			add_button, 
			remove_button: EV_BUTTON
		do				
			a_vbox.set_border_width (Layout_constants.Small_border_size)
			a_vbox.set_padding (Layout_constants.Small_padding_size)
	
				-- Argument combo box.
			a_vbox.extend (argument_combo)
			a_vbox.disable_item_expand (argument_combo)
	
				-- Argument list box.
			a_vbox.extend (argument_list)
			argument_list.set_minimum_size (400, 50)
			a_vbox.disable_item_expand (argument_list)
			
			create l_horizontal_box
			l_horizontal_box.set_padding (Layout_constants.Default_padding_size)
			
			create l_label.make_with_text ("Current Argument")
			l_label.align_text_left
			a_vbox.extend (l_label)
			a_vbox.disable_item_expand (l_label)

			a_vbox.extend (current_argument)
			current_argument.set_minimum_height (50)
			
			create l_cell
			l_horizontal_box.extend (l_cell)
			
			create add_button.make_with_text_and_action ("Add", agent add_argument)
			l_horizontal_box.extend (add_button)
			l_horizontal_box.disable_item_expand (add_button)
			add_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
			
			create remove_button.make_with_text_and_action ("Remove", agent remove_argument)
			l_horizontal_box.extend (remove_button)
			l_horizontal_box.disable_item_expand (remove_button)
			remove_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
			
			create l_cell
			l_horizontal_box.extend (l_cell)
			
			a_vbox.extend (l_horizontal_box)
			a_vbox.disable_item_expand (l_horizontal_box)
		end

feature -- Access

	working_directory_path: STRING is
			-- Path of 'working_directory'.
		do
			Result := working_directory.path
		end		

feature -- Status Setting
	
	synch_with_others is
			-- Synchronize other open controls due to changes in Current.
		local
			mem: MEMORY
			l_control: EB_ARGUMENT_CONTROL
			l_controls_list: SPECIAL [ANY]
			l_counter: INTEGER
		do
			create mem
			l_controls_list := mem.objects_instance_of (Current)
			from
				l_counter := 1
			until
				l_counter = l_controls_list.count
			loop
				if l_controls_list.item (l_counter) /= Current then
					l_control ?= l_controls_list.item (l_counter)
					l_control.update
				end
				l_counter := l_counter + 1
			end
		end
	
	update is
			-- Update all elements after changes.
		do
			retrieve_ace_arguments
			retrieve_user_arguments
			current_new_arg_text := Void
				-- Determine last argument run and set mode and argument to this.
				-- If not use Ace mode as default.
			if
				workbench.system_defined and 
				not lace.argument_list.is_empty and then
				not lace.argument_list.first.is_empty and then
				not lace.argument_list.first.is_equal (" ")
			then
				current_new_arg_text := lace.argument_list.first
			elseif 
				saved_argument /= Void and then
				not saved_argument.is_empty and then
				not saved_argument.is_equal (" ")
			then
				current_new_arg_text := saved_argument
			end
			
			if current_new_arg_text /= Void then
				if ace_arguments_list.there_exists (agent row_duplicate (?)) then
					notebook.select_item (notebook.i_th (1))
					ace_arguments_list.select_item (current_new_arg_text, 1)
					select_combo_item (current_new_arg_text)
					set_mode (Ace_mode)					
				elseif user_arguments_list.there_exists (agent row_duplicate (?)) then
					notebook.select_item (notebook.i_th (2))
					user_arguments_list.select_item (current_new_arg_text, 1)
					select_combo_item (current_new_arg_text)
					set_mode (User_mode)
				else
					notebook.select_item (notebook.i_th (1))
					set_mode (Ace_mode)
				end			
			else
				notebook.select_item (notebook.i_th (1))
				set_mode (Ace_mode)
			end		
			refresh
		end

	set_working_directory (a_path: STRING) is
			-- Set 'working directory' path to 'a_path'.
		require
			path_not_void: a_path /= Void
		do
			working_directory.set_path (a_path)
		end

feature {NONE} -- Status Setting

	set_mode (a_mode: INTEGER) is
			-- Set the current mode to 'a_mode'.
		require
			a_mode_is_valid: a_mode = 1 or a_mode = 2 
		do
			mode := a_mode
			initialize_mode
		end
		
	new_d_option (a_string: STRING): D_OPTION_SD is
			-- Create a new D_OPTION_SD to add to Ace.
		local
			free_option: FREE_OPTION_SD
			val: OPT_VAL_SD
		do
			a_string.replace_substring_all ("%%", "%%%%")
			a_string.replace_substring_all ("%"", "%%%"")
			create free_option.make (feature {FREE_OPTION_SD}.arguments)
			create val.make (new_id_sd (a_string, True))
			create Result.initialize (free_option, val)
		end
		
	new_special_option_sd (type_id: INTEGER; a_name: STRING; flag: BOOLEAN): D_OPTION_SD is
			-- Create new `D_OPTION_SD' node corresponding to a free
			-- option clause. If `a_name' Void then it is `free_option (flag)'.
		require
			valid_type_id: type_id > 0
			type_id_big_enough: type_id < feature {FREE_OPTION_SD}.free_option_count
		local
			argument_sd: FREE_OPTION_SD
			v: OPT_VAL_SD
		do
			create argument_sd.make (type_id)
			if a_name /= Void then
				create v.make (new_id_sd (a_name, True))
			else
				if flag then
					create v.make_yes
				else
					create v.make_no
				end
			end
			create Result.initialize (argument_sd, v)
		ensure
			result_not_void: Result /= Void
		end
		
feature {NONE} -- Element Change

	initialize_mode is
			-- Initialize or reinitialize the current mode.
		do
			inspect mode
				when Ace_mode then
					argument_list := ace_arguments_list
					argument_combo := ace_combo
					current_argument := ace_current_arg_text
				when User_mode then
					argument_list := user_arguments_list
					argument_combo := user_combo
					current_argument := user_current_arg_text
				else
			end
			argument_list.hide_title_row	
		end

	update_arguments is
			-- Update the arguments lists due to changes.
		do
			inspect mode 
				when Ace_mode then
					ace_arguments_list := argument_list
				when User_mode then
					user_arguments_list := argument_list
				else
			end
			store_arguments (root_ast)
			synch_with_others
		end
		
	escape_argument (argument_text: STRING): STRING is
   			-- Turn `argument_text' into a string that can be safely added to
        	-- the ace file. Escape all special characters.
    	do
			if 
				argument_text = Void or else 
				argument_text.is_empty
			then
				Result := " "
            else
            	Result := clone (argument_text)
            	Result.replace_substring_all ("%N", " ")
            	Result.replace_substring_all ("  ", " ")
            	Result.replace_substring_all ("%%", "%%%%")
            	Result.replace_substring_all ("%"", "%%%"")
            end
     	ensure
        	valid_result: Result /= Void
      	end
	
feature {NONE} -- GUI Properties

	working_directory: EV_PATH_FIELD
			-- Directory from where user wants to launch its application.

	notebook: EV_NOTEBOOK
			-- The notebook containing project and user argument tabs.

	argument_check: EV_CHECK_BUTTON
			-- Check button to determine of arguments used or not.

	argument_list: EV_EDITABLE_LIST
			-- The current list with focus (either 'ace_arguments_list' or 'custom_arguments_list').
			
	argument_combo: EV_COMBO_BOX
			-- The current list of arguments (either 'ace_combo' or 'custom_combo').
			
	current_argument: EV_TEXT
			-- The current argument (either 'ace_current_arg_text' or 'user_current_arg_text').

	ace_arguments_list: EV_EDITABLE_LIST
			-- Widget displaying arguments from Ace file.
			
	ace_combo: EV_COMBO_BOX
			-- Widget displaying arguments from Ace file.
	
	user_arguments_list: EV_EDITABLE_LIST
			-- Widget displaying arguments from user specific file.
			
	user_combo: EV_COMBO_BOX
			-- Widget displaying arguments from user specific file.

	ace_current_arg_text: EV_TEXT
			-- Widget displaying current program argument from ace file.

	user_current_arg_text: EV_TEXT
			-- Widget displaying current program argument from user file.
			
	project_args_tab: EV_VERTICAL_BOX 
			-- Widget containing project-wide argument settings.
		
	user_args_tab: EV_VERTICAL_BOX
			-- Widget containing user specific argument settings.

feature {NONE} -- Actions

	on_tab_changed is
			-- Action to be taken when user has changed mode.
		local
			l_arg: STRING
		do
			if mode = 1 then
				set_mode (2)
			elseif mode = 2 then
				set_mode (1)
			end
			if saved_argument /= Void then
				if not saved_argument.is_empty then
						-- Retrieve previous argument for new mode.
					l_arg := current_argument.text
					current_argument.set_text (saved_argument)
					saved_argument := l_arg
				end
			end
			refresh
		end

	arg_check_selected is
			-- Argument check box has been selected.
		do
			if argument_check.is_selected then
				notebook.disable_sensitive				
			else
				notebook.enable_sensitive
			end

		end

	on_list_edited is
			-- Action to be performed when list row argument has been in-place edited.
		do
			if argument_combo.selected_item /= Void then
				argument_combo.go_i_th (argument_combo.index_of (argument_combo.selected_item, 1))
				argument_combo.replace (create {EV_LIST_ITEM}.make_with_text (argument_list.selected_item.i_th (1)))
				argument_combo.item.enable_select
				update_arguments
			end
		end

	add_argument is
			-- Action to take when user chooses to add a new argument.
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_argument: STRING
		do	
			if not current_argument.text.is_empty then
				l_argument := escape_argument (current_argument.text)
				create l_row
				l_row.put_front (l_argument)
				current_new_arg_text := l_argument
				if not argument_list.there_exists (agent row_duplicate (?))  then
					argument_list.extend (l_row)
					argument_combo.extend (create {EV_LIST_ITEM}.make_with_text (current_new_arg_text))
					argument_list.last.enable_select
					argument_combo.last.enable_select
				end
				update_arguments
			end
		end
		
	current_new_arg_text: STRING
			-- Text of mostly recently added argument.
		
	row_duplicate (a_row: EV_MULTI_COLUMN_LIST_ROW): BOOLEAN is
			-- Does text in 'a_row' already exist in row in the list?
		do
			Result := a_row.first.is_equal (current_new_arg_text)
		end

	remove_argument is
			-- Action to take when user chooses to remove an existing argument.
		do
			if 
				argument_list.selected_item /= Void and then
				not argument_list.selected_item.i_th (1).is_equal (no_arg_string)
			then
				argument_list.prune (argument_list.selected_item)
				argument_combo.prune (argument_combo.selected_item)
				if not argument_combo.is_empty then
					argument_combo.first.enable_select
					current_argument.set_text (argument_combo.selected_item.text)
				else
					argument_combo.wipe_out
					current_argument.set_text ("")
				end
				update_arguments
			end
		end

	argument_selected (a_widget: EV_WIDGET) is
			-- An argument was chosen in 'a_widget'
		local
			l_list: EV_EDITABLE_LIST
			l_combo: EV_COMBO_BOX
		do
			l_list ?= a_widget
			l_combo ?= a_widget
			if l_list /= Void then
				-- List argument was selected.
				if argument_list.selected_item /= Void then
					argument_combo.i_th (argument_list.index_of (argument_list.selected_item, 1)).enable_select
				end
			elseif l_combo /= Void then
				-- Combo argument was selected.
				if argument_combo.selected_item /= Void then
					argument_list.i_th (argument_combo.index_of (argument_combo.selected_item, 1)).enable_select
				end
			end
			refresh
		end
		
	refresh is
			-- Refresh control since it has been resized.
		do
			argument_list.set_column_width (argument_list.width - 15, 1)
			if not argument_list.is_empty then
				if argument_list.selected_item /= Void then
					current_argument.set_text (argument_list.selected_item.i_th (1))
				end
			else
				current_argument.set_text ("")
			end	
		ensure
			column_is_full_width: argument_list.column_width (1) = argument_list.width
		end

	select_combo_item (a_string: STRING) is
			-- Select in the 'argument_combo' first item matching text 'a_string'.
			-- Used for synchronization with other controls.
		local
			done: BOOLEAN
		do
			from
				argument_combo.start
			until
				argument_combo.after or done
			loop
				if argument_combo.item.text.is_equal (a_string) then
					argument_combo.item.enable_select
					done := True
				end
				argument_combo.forth
			end
		end

feature {NONE} -- Implementation

	arguments_file: RAW_FILE
			-- File containing user specific arguments.

	mode: INTEGER
			-- Mode of control (can be ace or user mode).
		
	saved_argument: STRING
			-- The argument last used in opposite 'mode'
			
	root_ast: ACE_SD
			-- Ace file.
			
	parent_window: EV_WINDOW
			-- Parent window.

feature {NONE} -- Constants

	Ace_mode: INTEGER is 1
			-- Ace mode constant.
			
	User_mode: INTEGER is 2
			-- User mode constant.
			
	No_arg_string: STRING is "(No Argument)"

invariant
	parent_not_void: parent_window /= Void

end -- class EB_ARGUMENT_CONTROL
