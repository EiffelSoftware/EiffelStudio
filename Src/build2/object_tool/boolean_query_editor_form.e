indexing
	description: "Form containing a set of query properties used to generate %
			% the corresponding object editor. Used when the returned %
			% is BOOLEAN."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BOOLEAN_QUERY_EDITOR_FORM
	
	--| FIXME
	--| The radio buttons are not yet supported. Add this.
	--| Preconditions seem not to be added unless `procedure' is not Void. Why
	--| is this the case? It appears that this may have been the case in Build.
	--| Not enough time has been spent testing this, so
	--| some real testing needs to be undertaken before this
	--| is released.

inherit

	QUERY_EDITOR_FORM

creation
	make

feature {NONE}

	create_interface (test_preconditions: BOOLEAN) is
			-- Create interface.
		local
			v1, v2: EV_VERTICAL_BOX
			h1, horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			separator: EV_HORIZONTAL_SEPARATOR
		do
			create v1
			extend (v1)
			create query_label
			v1.extend (query_label)
			create horizontal_box
			create test_toggle_b.make_with_text ("Precondition test")
			horizontal_box.extend (test_toggle_b)
			create label.make_with_text ("Error message")
			horizontal_box.extend (label)
			create test_text_field
			horizontal_box.extend (test_text_field)
			v1.extend (horizontal_box)
			
			create horizontal_box
			v1.extend (horizontal_box)
			create v2
			horizontal_box.extend (v2)
			create one_procedure_toggle_b.make_with_text ("One procedure")
			v2.extend (one_procedure_toggle_b)
			create two_procedure_toggle_b.make_with_text ("Two procedures")
			v2.extend (two_procedure_toggle_b)

			create v2
			horizontal_box.extend (v2)
			create h1
			v2.extend (h1)
			create label.make_with_text ("with boolean argument:")
			h1.extend (label)
			create procedure_opt_pull
			h1.extend (procedure_opt_pull)
			
			create h1
			create label.make_with_text ("set True:")
			h1.extend (label)
			create true_opt_pull
			h1.extend (true_opt_pull)
			create label.make_with_text ("set False:")
			h1.extend (label)
			create false_opt_pull
			h1.extend (false_opt_pull)
			v2.extend (h1)

			create select_label.make_with_text ("Select through:")
			v1.extend (select_label)		
			create horizontal_box
			v1.extend (horizontal_box)
			
			create v2
			horizontal_box.extend (v2)
			create check_toggle_b.make_with_text ("Check box")
			v2.extend (check_toggle_b)
			create radio_toggle_b.make_with_text ("radio_toggle_b")
			v2.extend (radio_toggle_b)
			create menu_toggle_b.make_with_text ("Menu")
			v2.extend (menu_toggle_b)
			
			create v2
			horizontal_box.extend (v2)
			create h1
			v2.extend (h1)
			create label.make_with_text ("Label:")
			h1.extend (label)
			create check_field
			h1.extend (check_field)

			create h1
			v2.extend (h1)
			create label.make_with_text ("True label")
			h1.extend (label)
			create radio_true_field
			h1.extend (radio_true_field)
			create label.make_with_text ("False label")
			h1.extend (label)
			create radio_false_field
			h1.extend (radio_false_field)
			
			create h1
			v2.extend (h1)
			create label.make_with_text ("True entry:")
			h1.extend (label)
			create menu_true_field
			h1.extend (menu_true_field)
			create label.make_with_text ("False entry")
			h1.extend (label)
			create menu_false_field
			h1.extend (menu_false_field)
			
			create separator
			v1.extend (separator)
			
			procedure_opt_pull.set_minimum_width (150)
			true_opt_pull.set_minimum_width (150)
			false_opt_pull.set_minimum_width (150)
			
			test_toggle_b.select_actions.extend (agent any_toggle_b_fired)
			menu_toggle_b.select_actions.extend (agent any_toggle_b_fired)
			check_toggle_b.select_actions.extend (agent any_toggle_b_fired)
			radio_toggle_b.select_actions.extend (agent any_toggle_b_fired)
			one_procedure_toggle_b.select_actions.extend (agent any_toggle_b_fired)
			two_procedure_toggle_b.select_actions.extend (agent any_toggle_b_fired)

			if test_preconditions then
				test_toggle_b.enable_select
			end
			
			set_values
		end

	set_values is
			-- Set values for GUI elements.
		do
			true_opt_pull.disable_sensitive
			false_opt_pull.disable_sensitive	
			desactivate_all_fields
			radio_true_field.set_text ("True")
		
			radio_false_field.set_text ("False")
		
			menu_true_field.set_text ("Yes")
		
			menu_false_field.set_text ("No")
		end

	update_interface is
			-- Update the interface after setting `query'.
		local
			error_message, label: STRING
		do
			query_label.set_text (query.value)
			create label.make (0)
			label.append (query.query_name)
			label.append (" ?")
			check_field.set_text (label)
			create error_message.make (0)
			error_message.append ("Incorrect `")
			error_message.append (query.query_name)
			error_message.append ("' field.")
			test_text_field.set_text (error_message)
			update_procedures_list
		end

feature {NONE} -- GUI attributes

	query_label: EV_LABEL
			-- Query label
			
	set_false_label,
			-- Set false label	
	check_label,
			--Label when selecting `menu_toggle_b' and `check_toggle_b'

	radio_true_label,
			-- True value

	radio_false_label,
			-- False value

	menu_true_label,
			-- True value

	menu_false_label,
			-- False value

	select_label: EV_LABEL
			-- "Select through" label

	test_text_field: EV_TEXT_FIELD
			-- Text field used to add the precondition test

	check_field,
			-- Text field used to set the label

	menu_true_field,
			-- Text field used to set the true value

	menu_false_field,
			-- Text field used to set the false value

	radio_true_field,
			-- Text field used to set the true value

	radio_false_field: EV_TEXT_FIELD
			-- Text field used to set the false value
	
	one_procedure_toggle_b,
			-- One procedure with attribute

	two_procedure_toggle_b,
			-- Two procedures without argument

	check_toggle_b,
			-- 'Check_box' field

	menu_toggle_b,
			-- 'Menu' field

	radio_toggle_b: EV_RADIO_BUTTON
			-- 'Radio_box' field
			
	test_toggle_b: EV_CHECK_BUTTON
			-- Precondition test field

feature -- Option pull used to select the procedure used to set `query'

	procedure_opt_pull,

	true_opt_pull,

	false_opt_pull: EV_COMBO_BOX

feature {NONE} -- Heuristic

	update_procedures_list is
			-- Display a list of compatible procedures.
		local
			menu_entry, menu_entry_bis: APPLICATION_METHOD_PUSH_B
			procedure_empty: BOOLEAN
		do
			if not query.possible_commands.empty then
				from 
					query.possible_commands.finish
				until
					query.possible_commands.before
				loop
					create menu_entry.make (query.possible_commands.item, procedure_opt_pull)
					procedure_opt_pull.extend (menu_entry)
					query.possible_commands.back
				end
				menu_entry.enable_select
			else
				procedure_opt_pull.disable_sensitive
				two_procedure_toggle_b.enable_select
				one_procedure_toggle_b.disable_sensitive
				procedure_empty := True
			end

			if not query.possible_routines.empty then
				from 
					query.possible_routines.finish
				until
					query.possible_routines.before
				loop
					create menu_entry.make (query.possible_routines.item, true_opt_pull)
					create menu_entry_bis.make (query.possible_routines.item, false_opt_pull)
					query.possible_routines.back
				end
				menu_entry.enable_select
				menu_entry_bis.enable_select
			else
				true_opt_pull.disable_sensitive
				false_opt_pull.disable_sensitive
				if not procedure_empty then
					one_procedure_toggle_b.enable_select
				end
				two_procedure_toggle_b.disable_sensitive
			end	
		end

feature -- Execution

	any_toggle_b_fired is
			-- Any of the radio buttons have been selected.
			-- Update the interface accordingly.
		do
			if radio_toggle_b.is_selected then 
				check_field.disable_sensitive
				radio_true_field.enable_sensitive
				radio_false_field.enable_sensitive
				menu_true_field.disable_sensitive
				menu_false_field.disable_sensitive
			else
				check_field.enable_sensitive
				desactivate_all_fields
				if menu_toggle_b.is_selected then
					menu_true_field.enable_sensitive
					menu_false_field.enable_sensitive
				end
			end
			
			if one_procedure_toggle_b.is_selected then
				procedure_opt_pull.enable_sensitive
				true_opt_pull.disable_sensitive
				false_opt_pull.disable_sensitive
			elseif two_procedure_toggle_b.is_selected then
				procedure_opt_pull.disable_sensitive
				true_opt_pull.enable_sensitive
				false_opt_pull.enable_sensitive
			end

			if test_toggle_b.is_selected then
				test_text_field.enable_sensitive
			else
				test_text_field.disable_sensitive
			end
		end

	desactivate_all_fields is
			-- Desactivate all the fields
		do
			radio_true_field.disable_sensitive
			radio_false_field.disable_sensitive
			menu_true_field.disable_sensitive
			menu_false_field.disable_sensitive
		end

feature {NONE} -- Attribute

	default_choice: STRING_SCROLLABLE_ELEMENT
			-- Default choice in the menu entries

feature -- Command generation

	--| FIXME These are not currently used, but have been
	--| left here for now until sure they are redundent.
	--| Used in released version of build (4.5).

--	arguments: EB_LINKED_LIST [ARG] is
--		   -- Generated widgets holding the value to set `query'.
--		local
--			arg: ARG
--		do
--			create Result.make
--			if new_toggle_b_c /= Void then
--				create arg.session_init (new_toggle_b_c.type)
--				Result.extend (arg)
--			elseif true_toggle_b_c /= Void then
--				create arg.session_init (true_toggle_b_c.type)
--				Result.extend (arg)
--			else
--				create arg.session_init (new_opt_pull_c.type)
--				Result.extend (arg)
--			end	
--		end
--
--	argument_instances: EB_LINKED_LIST [ARG_INSTANCE] is
--		   -- Generated widgets holding the value to set `query'.
--		local
--			arg: ARG_INSTANCE
--		do
--			create Result.make
--			if new_toggle_b_c /= Void then
--				create arg.storage_init (new_toggle_b_c.type, new_toggle_b_c)
--				Result.extend (arg)
--			elseif true_toggle_b_c /= Void then
--				create arg.storage_init (true_toggle_b_c.type, true_toggle_b_c)
--				Result.extend (arg)
--			else
--				create arg.storage_init (new_opt_pull_c.type, new_opt_pull_c)
--				Result.extend (arg)
--			end	
--		end
--
		
	generate_interface_elements: STRING is
			-- Generate declarations for user interface widgets.
		do
			create Result.make (0)
			if check_toggle_b.is_selected then
				Result.append_string ("%T" + check_box_name + ": EV_CHECK_BUTTON%N%N")
			elseif menu_toggle_b.is_selected then
				Result.append_string ("%T" + opt_pull_name + ": EV_COMBO_BOX%N%N")
			end
		end
		
	build_interface (parent_name: STRING): STRING is
			-- Generate Eiffel code which builds the widgets
			-- for the user interface.
		do
			create Result.make (0)
			Result.append_string ("%T%T%Tcreate horizontal_box%N")
			Result.append_string ("%T%T%Tcreate label.make_with_text (%"" + query.query_name + "%")%N")
			Result.append_string ("%T%T%Thorizontal_box.extend (label)%N")
			Result.append_string ("%T%T%T" + parent_name + ".extend (horizontal_box)%N")
			Result.append_string ("%T%T%T" + parent_name + ".disable_item_expand (horizontal_box)%N")
			if check_toggle_b.is_selected then
				Result.append_string ("%T%T%Tcreate " + check_box_name + "%N")
				Result.append_string ("%T%T%Thorizontal_box.extend (" + check_box_name + ")%N")		
			elseif menu_toggle_b.is_selected then
				Result.append_string ("%T%T%Tcreate " + opt_pull_name + "%N")
				Result.append_string ("%T%T%Thorizontal_box.extend (" + opt_pull_name + ")%N")
				Result.append_string ("%T%T%Tcreate list_item.make_with_text (%"" + menu_true_field.text + "%")%N")
				Result.append_string ("%T%T%T" + opt_pull_name + ".extend (list_item)%N")
				Result.append_string ("%T%T%Tcreate list_item.make_with_text (%"" + menu_false_field.text + "%")%N")
				Result.append_string ("%T%T%T" + opt_pull_name + ".extend (list_item)%N")
			end
		end
		
	generate_eiffel_text (argument_namer: LOCAL_NAMER): STRING is
			-- Generate Eiffel text corresponding to the setting
			-- of the query corresponding to `query'.
		do
			if check_toggle_b.is_selected then
				check_box_name := argument_namer.value
			elseif menu_toggle_b.is_selected then
				opt_pull_name := argument_namer.value
			end
			if check_toggle_b.is_selected then
				create Result.make (0)
 				Result.append ("%T%T%T")
				Result.append ("if ")
				Result.append (argument_namer.value)
				Result.append (".is_selected then%N%T%T%T%T")
				Result.append (eiffel_setting ("True"))
				Result.append ("%N%T%T%Telse%N%T%T%T%T")
				Result.append (eiffel_setting ("False"))
				Result.append ("%N%T%T%Tend%N")
			elseif menu_toggle_b.is_selected then
				create Result.make (0)
				Result.append ("%T%T%T")
				Result.append ("if ")
				Result.append (argument_namer.value)
				Result.append (".selected_item.text.is_equal (%"" + menu_true_field.text + "%") then%N%T%T%T")
				Result.append (eiffel_setting ("True"))
				Result.append ("%N%T%T%Telse%N%T%T%T%T")
				Result.append (eiffel_setting ("False"))
				Result.append ("%N%T%T%Tend%N")
			end
		end

	eiffel_setting (actual_argument: STRING): STRING is
			-- Generate the setting of the query using `argument'.
		local
			preconditions: LINKED_LIST [APPLICATION_PRECONDITION]
		do
 			create Result.make (0)
 			if test_toggle_b.is_selected and then one_procedure_toggle_b.is_selected and then not procedure.precondition_list.empty then 
 				Result.append ("precondition := True%N")
 
 				preconditions := procedure.precondition_list
 				from
 					preconditions.start
 				until
 					preconditions.after
 				loop
 					Result.append ("%T%T%T%Tprecondition := precondition and then ")
 					Result.append (preconditions.item.generated_text_for_command (procedure.argument_name, actual_argument))
 					Result.append ("%N")
 					preconditions.forth
 				end		
 				Result.append ("%N%T%T%T%Tif precondition then%N%T%T%T%T")
 			end
 			Result.append ("target.")
			if one_procedure_toggle_b.is_selected then
				Result.append (procedure.command_name)
				Result.append (" (")
				Result.append (actual_argument)
				Result.append (")")
			else
				if actual_argument.is_equal ("True") then
					Result.append (procedure_true.routine_name)
				elseif actual_argument.is_equal ("False") then
					Result.append (procedure_false.routine_name)
				end
			end
		end

	procedure: APPLICATION_COMMAND is
			-- Procedure chosen to set `query'
		require
			item_selected: procedure_opt_pull.selected_item /= Void
		local
			application_method_button: APPLICATION_METHOD_PUSH_B
		do
			application_method_button ?= procedure_opt_pull.selected_item
			Result ?= application_method_button.application_method
		end

	procedure_true: APPLICATION_ROUTINE is
			-- Procedure chosen to set true `query'
		require
			item_selected: true_opt_pull.selected_item /= Void
		local
			application_method_button: APPLICATION_METHOD_PUSH_B
		do
			application_method_button ?= true_opt_pull.selected_item
			Result ?= application_method_button.application_method
		end

	procedure_false: APPLICATION_ROUTINE is
			-- Procedure chosen to set false `query'
		require
			item_selected: false_opt_pull.selected_item /= Void
		local
			application_method_button: APPLICATION_METHOD_PUSH_B
		do
			application_method_button ?= false_opt_pull.selected_item
			Result ?= application_method_button.application_method
		end

	check_box_name, 
			-- Internal name of the check box holding the value
			-- used to set `query'.

	radio_box_name,
			-- Internal name of radio box holding the value used
			-- to set `query'
	
	true_toggle_b_name,
			-- Internal name of `toggle_b' holding the value used
			-- to set `query'

	false_toggle_b_name,
			-- Internal name of `toggle_b' holding the value used
			-- to set `query'

	opt_pull_name: STRING 
			-- Internal name of the option pull holding the value
			-- used to set `query'.

end -- class BOOLEAN_QUERY_EDITOR_FORM
