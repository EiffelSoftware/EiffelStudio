indexing
	description:	
		"Popup dialog to enter new arguments and modify existing ones."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_DIALOG

inherit

	EV_DIALOG

	EV_COMMAND
		undefine
			default_create,
			copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end
		
	EB_SHARED_INTERFACE_TOOLS
		undefine
			default_create,
			copy
		end
		
	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end	
		
	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end
		
	LACE_AST_FACTORY
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

creation
	make_default
	
feature -- Initialization

	make_default (cmd: PROCEDURE [ANY, TUPLE]) is
			-- Initialize Current with `par' as parent and
			-- `cmd' as command window.
			--| Use this in conjunction with `make_plain' to
			--| create a shared argument window.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			b: EV_BUTTON
			f: EV_FRAME
		do		
			default_create
			create saved_arguments.make (0)
			saved_arguments.compare_objects
			set_minimum_size (400, 210)
			run := cmd	
			create vb
			vb.extend (execution_frame)
			set_title ("Program Arguments")
			extend (vb)		
			retrieve_arguments
		end

	execution_frame: EV_FRAME is
			-- Frame containing all execution option
		local
			vbox, item_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			b: EV_BUTTON
			cell: EV_CELL
			
			proc: PROCEDURE [ANY, TUPLE[]]
		do
			create Result.make_with_text ("Arguments")
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)

			create label.make_with_text ("Program command line arguments: ")
			label.align_text_left
			create item_box
			item_box.set_padding (Default_item_padding)
			item_box.extend (label)
			item_box.disable_item_expand (label)

			create arguments_edit
			item_box.extend (arguments_edit)
			arguments_edit.set_minimum_size (100, 60)
			arguments_edit.disable_sensitive

			vbox.extend (item_box)

			create label.make_with_text ("Program arguments: ")
			label.align_text_left
			create item_box
			item_box.set_padding (Default_item_padding)
			item_box.extend (label)
			item_box.disable_item_expand (label)

			create hbox
			hbox.set_padding (Layout_constants.Small_padding_size)
			create arguments_list
			arguments_list.disable_edit
			arguments_list.select_actions.extend (agent changed_arguments)
			hbox.extend (arguments_list)
			create delete_button
			delete_button.set_pixmap ((create {EB_SHARED_PIXMAPS}).icon_delete_small.item (1))
			delete_button.select_actions.extend (agent remove_arguments)
			delete_button.disable_sensitive
			hbox.extend (delete_button)
			hbox.disable_item_expand (delete_button)
			item_box.extend (hbox)		
			vbox.extend (item_box)
			vbox.disable_item_expand (item_box)

			create hbox
			hbox.set_padding (Layout_constants.Small_padding_size)		
			create cell
			hbox.extend (cell)
			
			if run /= Void then
				create b.make_with_text ("Add")
				hbox.extend (b)
				b.set_minimum_size (74, 23)
				hbox.disable_item_expand (b)
				b.select_actions.extend (agent add_arguments)
			end
			
			create b.make_with_text ("Apply")
			hbox.extend (b)
			b.set_minimum_size (74, 23)
			hbox.disable_item_expand (b)
			b.select_actions.extend (agent update_arguments)
			create b.make_with_text ("Cancel")
			b.select_actions.extend (agent destroy)
			hbox.extend (b)
			b.set_minimum_size (74, 23)
			hbox.disable_item_expand (b)
			create b.make_with_text ("Run")
			b.select_actions.extend (agent execute (apply_and_run_it))
			hbox.extend (b)
			b.set_minimum_size (74, 23)
			hbox.disable_item_expand (b)

			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

			Result.extend (vbox)
		end

feature -- Properties

	arguments_edit: EV_TEXT
			-- Editable area for select arguments list

	arguments_list: EV_COMBO_BOX
			-- List of all arguments that can be given to current program execution.
			-- Selected one is active.
			
	delete_button: EV_BUTTON
			-- Button to delete a selected argument
			
	arg_pos: INTEGER
			-- Position of argument currently undergoing editing

feature -- Actions

	update_arguments is
			-- Action performed when a new argument is entered.
		do	
			if arg_pos = 0 then
				arg_pos := 1
			end
			arguments_list.enable_edit
			arguments_list.go_i_th (arg_pos)
			arguments_list.i_th (arg_pos).enable_select
			arguments_list.item.set_text (arguments_edit.text)
			arguments_list.disable_edit
			arguments_list.set_focus
			store_arguments
		end		

	add_arguments is
			-- Action performed when a new argument is entered or previous one is edited
		do
			arguments_list.put_front (create {EV_LIST_ITEM}.make_with_text (""))
			arguments_list.i_th (1).enable_select
			arguments_edit.set_focus
		end	

	remove_arguments is
			-- Remove the selected argument from the list
		do
			arguments_list.go_i_th (arg_pos)
			arguments_list.remove
			if arguments_list.count > 0 then
				arguments_list.i_th (1).enable_select
			end
			arguments_edit.set_text ("")
		end

	changed_arguments is
			-- Action performed when changing the selected item in `arguments_list'
		local
			selected: EV_LIST_ITEM
		do
			selected := arguments_list.selected_item
			if selected /= Void then	
				if selected.text.is_equal ("(No Argument)") then
					if delete_button.is_sensitive then
						delete_button.disable_sensitive
					end
					if arguments_edit.is_sensitive then
						arguments_edit.disable_sensitive
					end
				else
					if not delete_button.is_sensitive then
						delete_button.enable_sensitive
					end
					if not arguments_edit.is_sensitive then
						arguments_edit.enable_sensitive
					end
				end
				arguments_edit.set_text (selected.text)
				arguments_edit.set_focus
				arg_pos := arguments_list.index_of (arguments_list.selected_item, 1)
			end
		end

feature {NONE} -- Properties

	apply_and_run_it: ANY is
			-- Arguments for the command
		once
			create Result
		end

	run: PROCEDURE [ANY, TUPLE]

feature {NONE} -- Implementation

	execute (arg: ANY) is
		do
			hide
			if arg /= Void then
				if arg = Apply_and_run_it then
					store_arguments
					io.putstring (current_cmd_line_argument)
					io.read_line
					run.call ([])
				end
			end
		end

	root_ast: ACE_SD
			-- Ace file
		
	retrieve_arguments is
			-- Check content of Ace file and if valid set retrieve arguments.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			d_opt: D_OPTION_SD
			opt: OPTION_SD
			val: OPT_VAL_SD
			argument_value: STRING
			free_option: FREE_OPTION_SD
		do
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
							if argument_value.is_empty or else 
								argument_value.is_equal (" ") or else
								argument_value.has ('%U')
							then
								argument_value := "(No Argument)"
							end
							if argument_position (argument_value) = 0 then
								arguments_list.extend (create {EV_LIST_ITEM}.make_with_text (argument_value))
								saved_arguments.extend (argument_value)
							end
							defaults.remove
							defaults.back
						else
							-- Do nothing
						end
						end
						defaults.forth
					end
				end
			end
		end
		
	store_arguments is
			-- Store content of `arguments' into `root_ast'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			argument_text, current_text: STRING
			free_option: FREE_OPTION_SD
			val: OPT_VAL_SD
			d_option: D_OPTION_SD
			opt: OPTION_SD
		do
			if root_ast = Void then
				root_ast := retrieve_ace				
			end

			if Workbench.system_defined then
				Lace.argument_list.put_front (arguments_list.text)
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

			if arguments_list.count > 0 then
				defaults.extend (new_d_option (clone (arguments_list.selected_item.text)))
				from
					arguments_list.start
				until
					arguments_list.after
				loop
					if arguments_list.item.text = Void or else arguments_list.item.text.is_empty or else 
						arguments_list.item.text.is_equal ("(No Argument)") then
							arguments_list.prune (arguments_list.item)
					elseif arguments_list.item = arguments_list.selected_item then
					else
						defaults.extend (new_d_option (clone (arguments_list.item.text)))
					end
					arguments_list.forth
				end
				save_ace
			end
		end	
		
	new_d_option (a_string: STRING): D_OPTION_SD is
			-- Create a new D_OPTION_SD to add to Ace
		local
			free_option: FREE_OPTION_SD
			val: OPT_VAL_SD
			opt: OPTION_SD
		do
			a_string.replace_substring_all ("%%", "%%%%")
			a_string.replace_substring_all ("%"", "%%%"")
			create free_option.make (feature {FREE_OPTION_SD}.arguments)
			create val.make (new_id_sd (a_string, True))
			create Result.initialize (free_option, val)
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
			
	save_ace is
			-- Save the arguments to the Ace file
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
		
	argument_position (argument_text: STRING): INTEGER is
			-- One-indexed Position of `argument_text' in `arguments', or zero if
			-- `argument_text' is not present in `arguments'.
		require
			argument_text_not_void: argument_text /= Void
		local
			i: INTEGER
		do
			if arguments_list.count > 0 then
				from
					arguments_list.start
				until
					(Result /= 0) or else arguments_list.after
				loop
					if argument_text.is_equal (arguments_list.item.text) then
						Result := i + 1
					end
					i := i + 1
					arguments_list.forth
				end
			end
		end

	saved_arguments: ARRAYED_LIST [STRING]
			-- List of arguments BEFORE any new ones have been added

feature {NONE} -- Constants

	Default_item_padding: INTEGER is 2
			-- Padding for items (label + textfield/combo)

end -- class EB_ARGUMENT_DIALOG
