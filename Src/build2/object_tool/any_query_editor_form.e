indexing
	description: "Form containing a set of query properties used to generate %
				% the corresponding object editor. Used when the returned %
				% is not BOOLEAN."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	ANY_QUERY_EDITOR_FORM
	
	--| FIXME seems to be fairly complete.
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
			label: EV_LABEL
			horizontal_box: EV_HORIZONTAL_BOX
			vertical_box, v1: EV_VERTICAL_BOX
			separator: EV_HORIZONTAL_SEPARATOR
		do
			create v1
			extend (v1)
			create horizontal_box
			v1.extend (horizontal_box)
			create query_label
			horizontal_box.extend (query_label)
			create label.make_with_text ("Procedure:")
			horizontal_box.extend (label)
			create procedure_opt_pull
			procedure_opt_pull.set_minimum_width (150)
			horizontal_box.extend (procedure_opt_pull)
			
			create horizontal_box
			create test_toggle_b.make_with_text ("Precondition test")
			horizontal_box.extend (test_toggle_b)
			create label.make_with_text ("Error message:")
			horizontal_box.extend (label)
			create test_text_field
			horizontal_box.extend (test_text_field)
			v1.extend (horizontal_box)
			
			
			create horizontal_box
			v1.extend (horizontal_box)
			
			create vertical_box
			horizontal_box.extend (vertical_box)
			create label.make_with_text ("Select through:")
			vertical_box.extend (label)
			create field_toggle_b.make_with_text ("Field")
			vertical_box.extend (field_toggle_b)
			create menu_toggle_b.make_with_text ("Menu")
			vertical_box.extend (menu_toggle_b)
			create field_and_menu_toggle_b.make_with_text ("Field + menu")
			vertical_box.extend (field_and_menu_toggle_b)
			
			create vertical_box
			horizontal_box.extend (vertical_box)
			create add_menu_label.make_with_text ("Menu entry")
			vertical_box.extend (add_menu_label)
			create menu_choice_label.make_with_text ("Menu choices")
			vertical_box.extend (menu_choice_label)
			create delete_button.make_with_text ("Delete")
			delete_button.select_actions.extend (agent delete_button_selected)
			vertical_box.extend (delete_button)

			
			create vertical_box
			horizontal_box.extend (vertical_box)
			create menu_text_field
			vertical_box.extend (menu_text_field)
			create menu_choice_sc_l
			vertical_box.extend (menu_choice_sc_l)
			menu_choice_sc_l.select_actions.extend (agent menu_choice_sc_selected)
			menu_choice_sc_l.disable_sensitive
			menu_choice_sc_l.select_actions.extend (agent delete_button.enable_sensitive)
			menu_choice_sc_l.deselect_actions.extend (agent delete_button.disable_sensitive)
			delete_button.disable_sensitive
			vertical_box.disable_item_expand (menu_text_field)
			menu_text_field.return_actions.extend (agent menu_text_field_return)
			
			create separator
			v1.extend (separator)
			v1.disable_item_expand (separator)
			
			field_toggle_b.select_actions.extend (agent any_radio_fired)
			field_and_menu_toggle_b.select_actions.extend (agent any_radio_fired)
			test_toggle_b.select_actions.extend (agent any_radio_fired)
			menu_toggle_b.select_actions.extend (agent any_radio_fired)
			
			if test_preconditions then
				test_toggle_b.enable_select
			end

			set_values
		end

	set_values is
			-- Set values for GUI elements.
		do
			field_toggle_b.enable_select
			deactivate_menu_fields
		end

	update_interface is
			-- Update the interface after setting `query'.
		local
			error_message: STRING
		do
			query_label.set_text (query.value)
			create error_message.make (0)
			error_message.append ("Incorrect `")
			error_message.append (query.query_name)
			error_message.append ("' field.")
			test_text_field.set_text(error_message)
			update_procedure_opt_pull
		end

feature {NONE} -- GUI attributes

	query_label: EV_LABEL
			-- Query label

	menu_choice_label,
			-- Menu choice when selecting `menu_toggle_b'
	add_menu_label: EV_LABEL
			-- 'Add menu' label

	test_text_field: EV_TEXT_FIELD
			-- Text field used to add the precondition test

	menu_text_field: EV_TEXT_FIELD
			-- Text field used to add a new menu

	test_toggle_b: EV_CHECK_BUTTON
			-- Precondition test field

	field_toggle_b,
			-- 'Field' field

	menu_toggle_b,
			-- 'Menu' field

	field_and_menu_toggle_b: EV_RADIO_BUTTON
--			-- 'Field+Menu' field

	menu_choice_sc_l: EV_LIST
			-- List of choice when selecting `menu_toggle_b'

	delete_button: EV_BUTTON
			-- Delete button

feature -- GUI attributes

	procedure_opt_pull: EV_COMBO_BOX
			-- Option pull used to select the procedure used
			-- to set `query'.

feature {NONE} -- Heuristic

	update_procedure_opt_pull is
			-- Display a list of compatible procedure in
			-- `procedure_opt_pull'.
		local
			menu_entry: APPLICATION_METHOD_PUSH_B
			temp_application_command: APPLICATION_COMMAND
		do
			if not query.possible_commands.empty then
				from 
					query.possible_commands.finish
				until
					query.possible_commands.before
				loop
					temp_application_command := query.possible_commands.item
					create menu_entry.make (query.possible_commands.item, procedure_opt_pull)
					query.possible_commands.back
				end
				menu_entry.enable_select
			end
		end

feature -- Execution

	menu_text_field_return is
			-- Return has been pressed in `menu_text_field', so
			-- handle this event.
		local
			a_menu_choice: STRING_SCROLLABLE_ELEMENT
		do
			if not (menu_text_field.text = Void) then
				create a_menu_choice.make (0)
					a_menu_choice.set_text (menu_text_field.text)
					a_menu_choice.append (menu_text_field.text)
					menu_choice_sc_l.extend (a_menu_choice)
					menu_text_field.remove_text	
			end
		end
		
	delete_button_selected is
			-- Delete button has been selected so handle this.
		local
			selected_items: DYNAMIC_LIST [EV_LIST_ITEM]
			removed: BOOLEAN
		do
			if menu_choice_sc_l.selected_items.count > 0 
				then
					selected_items := menu_choice_sc_l.selected_items
					if not selected_items.empty then
						from
							selected_items.start
						until
							selected_items.after
						loop
							from
								menu_choice_sc_l.start
								removed := False
							until
								removed or menu_choice_sc_l.after
							loop
								if selected_items.item.text.is_equal (menu_choice_sc_l.item.text) then
									removed := True
									menu_choice_sc_l.remove
								else
									menu_choice_sc_l.forth
								end
							end
							selected_items.forth
						end
					end
				end
		end
		
		menu_choice_sc_selected is
				-- A new menu item has been selected so set the
				-- default choice.
			local
				temp_string: STRING
			do
				if menu_choice_sc_l.selected_items.count > 0 then
				if default_choice /= Void then
					temp_string := default_choice.substring (1, default_choice.count - 10)
					default_choice.wipe_out
					default_choice.append (temp_string)
				end
				default_choice ?= menu_choice_sc_l.selected_item
				check
					default_choice_not_void: default_choice /= Void
				end
				default_choice.append (" <Default>")
				end
			end
			
		any_radio_fired is
				-- Any of the radio buttons have been selected so
				-- respond accordingly.
			do
				if menu_toggle_b.is_selected or field_and_menu_toggle_b.is_selected then
					activate_menu_fields
				else
					deactivate_menu_fields
				end
				
				if test_toggle_b.is_selected then
					test_text_field.enable_sensitive
				else
					test_text_field.disable_sensitive
				end
			end

	deactivate_menu_fields is
			-- Deactivate every field related to the notion of Menu.
		do
			menu_choice_label.disable_sensitive
			menu_choice_sc_l.disable_sensitive
			add_menu_label.disable_sensitive
			menu_text_field.disable_sensitive

		end

	activate_menu_fields is
			-- Activate every field related to the notion of Menu.
		do
			menu_choice_label.enable_sensitive
			menu_choice_sc_l.enable_sensitive
			add_menu_label.enable_sensitive
			menu_text_field.enable_sensitive
		end

feature {NONE} -- Attribute

	default_choice: STRING_SCROLLABLE_ELEMENT
			-- Default choice in the menu entries

feature -- Interface generation

	generate_interface_elements: STRING is
			-- Generate declarations for user interface widgets.
		do
			create Result.make (0)
			if field_toggle_b.is_selected then
				Result.append_string ("%T" + text_field_name + ": EV_TEXT_FIELD%N%N")
			elseif menu_toggle_b.is_selected then
				Result.append_string ("%T" + opt_pull_name + ": EV_COMBO_BOX%N%N")	
			end
		end
		
	build_interface (parent_name: STRING): STRING is
			-- Generate Eiffel code which builds the widgets
			-- for the user interface
		local
			string_scroll: STRING_SCROLLABLE_ELEMENT
		do
			create Result.make (0)
			Result.append_string ("%T%T%Tcreate horizontal_box%N")
			Result.append_string ("%T%T%Tcreate label.make_with_text (%"" + query.query_name + "%")%N")
			Result.append_string ("%T%T%Thorizontal_box.extend (label)%N")
			Result.append_string ("%T%T%T" + parent_name + ".extend (horizontal_box)%N")
			Result.append_string ("%T%T%T" + parent_name + ".disable_item_expand (horizontal_box)%N")
			if field_toggle_b.is_selected then
				Result.append_string ("%T%T%Tcreate " + text_field_name + "%N")
				Result.append_string ("%T%T%Thorizontal_box.extend (" + text_field_name + ")%N")
			elseif menu_toggle_b.is_selected then
				Result.append_string ("%T%T%Tcreate " + opt_pull_name + "%N")
				Result.append_string ("%T%T%Thorizontal_box.extend (" + opt_pull_name + ")%N")

				from
					menu_choice_sc_l.start
				until
					menu_choice_sc_l.after
				loop
					string_scroll ?= menu_choice_sc_l.item
					check
						string_scroll_not_void: string_scroll /= Void
					end
					Result.append_string ("%T%T%Tcreate list_item.make_with_text (%"" + string_scroll.value + "%")%N")
					Result.append_string ("%T%T%T" + opt_pull_name + ".extend (list_item)%N")
					menu_choice_sc_l.forth
				end
			end
		end

	fill_menu (an_opt_pull_c: EV_COMBO_BOX) is
			-- Fill menus for `an_opt_pull_c'.
		local
			list_item: EV_LIST_ITEM
			string_scroll: STRING_SCROLLABLE_ELEMENT
		do
			from
				menu_choice_sc_l.start
			until
				menu_choice_sc_l.after
			loop
				create list_item
				string_scroll ?= menu_choice_sc_l.item
				check
					string_scroll_not_void: string_scroll /= Void
				end
				list_item.set_text (string_scroll)
				menu_choice_sc_l.forth
			end
		end


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
--			if is_both then
--				create arg.session_init (new_text_field_c.type)
--				Result.extend (arg)
--				create arg.session_init (new_opt_pull_c.type)
--				Result.extend (arg)
--			elseif new_text_field_c /= Void then
--				create arg.session_init (new_text_field_c.type)
--				Result.extend (arg)
--			else
--				create arg.session_init (new_opt_pull_c.type)
--				Result.extend (arg)
--			end	
--		end

--	argument_instances: EB_LINKED_LIST [ARG_INSTANCE] is
--		   -- Generated widgets holding the value to set `query'.
--		local
--			arg: ARG_INSTANCE
--		do
--			create Result.make
--			if is_both then
--				create arg.storage_init (new_text_field_c.type, new_text_field_c)
--				Result.extend (arg)
--				create arg.storage_init (new_opt_pull_c.type, new_opt_pull_c)
--				Result.extend (arg)
--			elseif new_text_field_c /= Void then
--				create arg.storage_init (new_text_field_c.type, new_text_field_c)
--				Result.extend (arg)
--			else
--				create arg.storage_init (new_opt_pull_c.type, new_opt_pull_c)
--				Result.extend (arg)
--			end	
--		end

	generate_eiffel_text (argument_namer: LOCAL_NAMER): STRING is
			-- Generate Eiffel text corresponding to the setting
			-- of the query correpsonding to `query'.
		local
			actual_argument: STRING
		do	
			if field_toggle_b.is_selected then
				text_field_name := argument_namer.value
			elseif menu_toggle_b.is_selected then
				opt_pull_name := argument_namer.value		
			end
			create Result.make (0)
			Result.append ("%T%T%T")
			if is_both then
				Result.append ("if not ")
				Result.append (argument_namer.value)
				Result.append (".text.empty then%N%T%T%T")
				create actual_argument.make (0)
				actual_argument.append (argument_namer.value)
				actual_argument.append (".text")
				actual_argument.append (extension_to_add)
				Result.append (eiffel_setting (actual_argument, argument_namer.value + ".text"))
				if test_toggle_b.is_selected and not procedure.precondition_list.empty then
					Result.append ("%N%T%T%T%Telse%N%T%T%T%T%Tdisplay_error_message (%"")
					Result.append (test_text_field.text)
					Result.append ("%", ")
					Result.append (argument_namer.value)
					Result.append (".parent)%N%T%T%T%Tend%N")
				end	
				Result.append ("%T%T%Telse%N%T%T%T%T")
				argument_namer.next
				create actual_argument.make (0)
				actual_argument.append (argument_namer.value)
				actual_argument.append (".selected_item.text")
				actual_argument.append (extension_to_add)
				Result.append (eiffel_setting (actual_argument, argument_namer.value + ".text"))
				if test_toggle_b.is_selected and not procedure.precondition_list.empty then
					Result.append ("%N%T%T%T%Telse%N%T%T%T%T%Tdisplay_error_message (%"")
					Result.append (test_text_field.text)
					Result.append ("%", ")
					Result.append (argument_namer.value)
					Result.append (".parent)%N%T%T%T%Tend%N")
				end	
				Result.append ("%T%T%Tend%N")
			elseif text_field_name /= Void then
				create actual_argument.make (0)
				actual_argument.append (argument_namer.value)
				actual_argument.append (".text")
				actual_argument.append (extension_to_add)
				Result.append (eiffel_setting (actual_argument, argument_namer.value + ".text"))
			else
				create actual_argument.make (0)
				actual_argument.append (argument_namer.value)
				actual_argument.append (".text")
				actual_argument.append (extension_to_add)
				Result.append (eiffel_setting (actual_argument, argument_namer.value + ".text"))
			end
			if test_toggle_b.is_selected and not procedure.precondition_list.empty and not is_both then
				Result.append ("%T%T%Telse%N%T%T%T%Tdisplay_error_message (%"")
				Result.append (test_text_field.text)
				Result.append ("%", ")
				Result.append (argument_namer.value)
				Result.append (".parent)%N%T%T%Tend%N")
				Result.append ("%T%T%Telse%N")
				Result.append ("%T%T%T%Tdisplay_error_message (%"" + test_text_field.text + "%", ")
				Result.append (argument_namer.value + ".parent)%N")
				Result.append ("%T%T%Tend%N")
			end
		end

	eiffel_setting (actual_argument: STRING; part_argument: STRING): STRING is
			-- Generate the setting of the query using `argument'.
		local
			preconditions: LINKED_LIST [APPLICATION_PRECONDITION]
		do
			create Result.make (0)
			if test_toggle_b.is_selected and not procedure.precondition_list.empty then 
				Result.append ("if " + part_argument + " /= Void then%N")
			
				Result.append ("%T%T%Tprecondition := True%N")
				preconditions := procedure.precondition_list
				from
					preconditions.start
				until
					preconditions.after
				loop
					Result.append ("%T%T%Tprecondition := precondition and then ")
					Result.append (preconditions.item.generated_text_for_command (procedure.argument_name, actual_argument))
					Result.append ("%N")
					preconditions.forth
				end		
				Result.append ("%N%T%T%Tif precondition then%N%T%T%T%T")
			end
			Result.append ("target.")
			Result.append (procedure.command_name)
			Result.append (" (")
			Result.append (actual_argument)
			Result.append (")%N")
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

	text_field_name: STRING 
			-- Internal name of the text field holding the value
			-- used to set `query'.

	opt_pull_name: STRING 
			-- Internal name of the option pull holding the value
			-- used to set `query'.

	is_both: BOOLEAN 
			-- Does the interface use both a text field and 
			-- an option pull.

end -- class ANY_QUERY_EDITOR_FORM
