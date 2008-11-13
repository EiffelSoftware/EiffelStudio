indexing
	description: "Summary description for {ES_TEST_WIZARD_AUTO_TEST_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_AUTO_TEST_WINDOW

inherit
	ES_TEST_WIZARD_FINAL_WINDOW
		redefine
			make_window
		end

	CLASS_TYPE_NAME_SYNTAX_CHECKER
		export
			{NONE} all
		end

create
	make_window

feature {NONE} -- Initialization

	make_window (a_development_window: like development_window; a_wizard_info: like wizard_information)
			-- <Precursor>
		do
			Precursor (a_development_window, a_wizard_info)
		end

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
			l_parent := initialize_container (choice_box)
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			build_types (l_hbox)
			build_options (l_hbox)
			l_parent.extend (l_hbox)

			on_after_initialize
		end

	build_options (a_parent: EV_BOX)
			-- Build widget containing configuration options
		local
			l_vbox: EV_VERTICAL_BOX
			l_cell: EV_CELL
		do
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create timeout_field
			timeout_field.disable_edit
			timeout_field.value_range.resize_exactly (1, {INTEGER_32}.max_value)
			timeout_field.change_actions.extend (agent on_timeout_change)

			create proxy_time_out
			proxy_time_out.disable_edit
			proxy_time_out.value_range.resize_exactly (1, {INTEGER_32}.max_value)
			proxy_time_out.change_actions.extend (agent on_proxy_timeout_change)

			create seed
			seed.disable_edit
			seed.set_minimum_width (170)
			seed.change_actions.extend (agent on_seed_change)

			create benchmark_checkbox
			benchmark_checkbox.select_actions.extend (agent on_benchmark_change)

			create ddmin_checkbox
			ddmin_checkbox.select_actions.extend (agent on_ddmin_change)

			create slicing_checkbox
			slicing_checkbox.select_actions.extend (agent on_slicing_change)

			create html_output
			html_output.select_actions.extend (agent on_html_output_change)

			append_option (l_vbox, b_timeout, timeout_field)
			append_option (l_vbox, b_proxy_timeout, proxy_time_out)
			append_option (l_vbox, b_seed, create {EV_CELL})
			append_option (l_vbox, " ", seed)
			append_option (l_vbox, b_slicing, slicing_checkbox)
			append_option (l_vbox, b_ddmin, ddmin_checkbox)
			append_option (l_vbox, b_html_output, html_output)
			append_option (l_vbox, b_benchmark, benchmark_checkbox)

			create l_cell
			l_vbox.extend (l_cell)
			l_vbox.disable_item_expand (l_cell)

			a_parent.extend (l_vbox)
		end

	build_types (a_parent: EV_BOX)
			-- Create `types' widget.
		local
			l_textfield: EV_TEXT_FIELD
			l_label: EV_LABEL

			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create type_list
			type_list.set_minimum_width (200)
			type_list.select_actions.extend (agent on_selection_change)
			type_list.deselect_actions.extend (agent on_selection_change)
			type_list.key_press_actions.extend (agent on_type_list_key_press)
			l_vbox.extend (type_list)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_label.make_with_text (locale_formatter.translation (b_new_type))
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)

			create l_textfield
			l_textfield.return_actions.extend (agent on_add_type)
			create type_field.make (l_textfield, agent on_validate_type)
			l_hbox.extend (type_field)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			l_hbox.extend (create {EV_CELL})

			create add_type_button
			add_type_button.set_text (locale_formatter.translation (b_add_type))
			add_type_button.select_actions.extend (agent on_add_type)
			l_hbox.extend (add_type_button)
			l_hbox.disable_item_expand (add_type_button)

			create remove_type_button
			remove_type_button.set_text (locale_formatter.translation (b_remove_type))
			remove_type_button.select_actions.extend (agent on_remove_type)
			l_hbox.extend (remove_type_button)
			l_hbox.disable_item_expand (remove_type_button)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

			a_parent.extend (l_vbox)
		end

	append_option (a_parent: EV_BOX; a_name: !STRING; a_widget: EV_WIDGET)
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_label.make_with_text (locale_formatter.translation (a_name))
			l_label.align_text_right
			l_label.align_text_left
			l_hbox.extend (l_label)
			l_hbox.extend (a_widget)
			l_hbox.disable_item_expand (a_widget)
			a_parent.extend (l_hbox)
			a_parent.disable_item_expand (l_hbox)
		end

	on_after_initialize
			-- Called after all widgets have been created
		local
			l_cursor: DS_LINEAR_CURSOR [!STRING]
			l_types: STRING_32
		do
			timeout_field.set_text (wizard_information.time_out.out)
			proxy_time_out.set_text (wizard_information.proxy_time_out.out)
			seed.set_text (wizard_information.seed.out)
			if wizard_information.is_ddmin_enabled then
				ddmin_checkbox.enable_select
			else
				ddmin_checkbox.disable_select
			end
			if wizard_information.is_slicing_enabled then
				slicing_checkbox.enable_select
			else
				slicing_checkbox.disable_select
			end
			if wizard_information.is_benchmarking then
				benchmark_checkbox.enable_select
			else
				benchmark_checkbox.disable_select
			end
			if wizard_information.is_html_output then
				html_output.enable_select
			else
				html_output.disable_select
			end
			update_next_button_status

			from
				l_cursor := wizard_information.types.new_cursor
				l_cursor.start
				create l_types.make (wizard_information.types.count * 25)
			until
				l_cursor.after
			loop
				l_types.append (l_cursor.item)
				l_cursor.forth
				if not l_cursor.after then
					l_types.append (", ")
				end
			end

			wizard_information.types.do_all (
				agent (a_type: !STRING)
					do
						type_list.extend (create {EV_LIST_ITEM}.make_with_text (a_type))
					end)

			type_field.validate
			remove_type_button.disable_sensitive
		end

feature {NONE} -- Access

	factory_type: !TYPE [TEST_CREATOR_I]
			-- <Precursor>
		do
			Result := generator_factory_type
		end

feature {NONE} -- Access: widgets

	timeout_field: EV_SPIN_BUTTON
			-- Text field containing time out

	proxy_time_out: EV_SPIN_BUTTON
			-- Text field containing proxy time out

	seed: EV_SPIN_BUTTON
			-- Text field containg random number seed

	benchmark_checkbox: EV_CHECK_BUTTON
			-- Check box for benchmarking option

	ddmin_checkbox: EV_CHECK_BUTTON
			-- Check box for ddmin option

	slicing_checkbox: EV_CHECK_BUTTON
			-- Check box for slicing option

	html_output: EV_CHECK_BUTTON
			-- Check box for html output

	type_list: EV_LIST
			-- List showing types entered so far

	type_field: ES_VALIDATION_TEXT_FIELD

	add_type_button: EV_BUTTON

	remove_type_button: EV_BUTTON

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := not wizard_information.types.is_empty
		end

feature {NONE} -- Events

	on_validate_type (a_input: !STRING_32): !TUPLE [valid: BOOLEAN; error: ?STRING_32]
			-- Called when input of `types' has to be validated.
		do
			if a_input.is_empty then
				Result := [True, Void]
			else
				if is_valid_class_type_name (a_input.to_string_8) then
					Result := [True, Void]
				else
					Result := [False, locale_formatter.translation (e_no_valid_type_name)]
				end
			end
			if not a_input.is_empty and Result.valid then
				if not add_type_button.is_sensitive then
					add_type_button.enable_sensitive
				end
			else
				if add_type_button.is_sensitive then
					add_type_button.disable_sensitive
				end
			end
		end

	on_add_type
			-- Called when user presses `add_type' button or hits enter.
		local
			l_new: !STRING
		do
			if not type_field.text.is_empty and type_field.is_valid then
				l_new := type_field.text.to_string_8.as_attached
				wizard_information.types.search (l_new)
				if not wizard_information.types.found then
					wizard_information.types.force_last (l_new)
					type_list.extend (create {EV_LIST_ITEM}.make_with_text (l_new))
				end
				type_field.set_text (create {STRING_32}.make_empty)
				update_next_button_status
			end
		end

	on_remove_type
			-- Called when user presses `remove_type' button
		local
			l_type: !STRING
		do
			if type_list.selected_item /= Void then
				l_type := type_list.selected_item.text.to_string_8.as_attached
				wizard_information.types.remove (l_type)
				type_list.prune (type_list.selected_item)
				update_next_button_status
			end
		end

	on_selection_change (a_item: EV_LIST_ITEM)
			-- Called when selection of `type_list' changes.
		do
			if a_item.is_selected then
				if not remove_type_button.is_sensitive then
					remove_type_button.enable_sensitive
				end
			else
				if remove_type_button.is_sensitive then
					remove_type_button.disable_sensitive
				end
			end
		end

	on_type_list_key_press (a_key: EV_KEY)
			-- Called when key is pressed in `type_list'.
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_delete then
				on_remove_type
			end
		end

	on_timeout_change (a_value: INTEGER_32)
		do
			wizard_information.set_time_out (a_value.to_natural_32)
		end

	on_proxy_timeout_change (a_value: INTEGER_32)
		do
			wizard_information.set_proxy_time_out (a_value.to_natural_32)
		end

	on_seed_change (a_value: INTEGER_32)
		do
			wizard_information.set_seed (a_value.to_natural_32)
		end

	on_benchmark_change
		do
			wizard_information.set_benchmarking (benchmark_checkbox.is_selected)
		end

	on_ddmin_change
		do
			wizard_information.set_ddmin_enabled (ddmin_checkbox.is_selected)
		end

	on_slicing_change
		do
			wizard_information.set_slicing_enabled (slicing_checkbox.is_selected)
		end

	on_html_output_change
		do
			wizard_information.set_html_output (html_output.is_selected)
		end

feature {NONE} -- Constants

	t_title: !STRING = "Generate tests through AutoTest"
	t_subtitle: !STRING = "Define commands to run auto test"

	b_timeout: !STRING = "Duration (minutes)"
	b_proxy_timeout: !STRING = "Routine timeout (seconds)"
	b_seed: !STRING = "Random number generation seed"
	b_benchmark: !STRING = "Enable benchmarking"
	b_ddmin: !STRING = "Use ddmin for minimization"
	b_slicing: !STRING = "Use slicing for minimization"
	b_html_output: !STRING = "Create HTML output"
	b_new_type: !STRING = "Typename"
	b_add_type: !STRING = "+"
	b_remove_type: !STRING = "-"

	e_no_valid_type_name: !STRING = "$1 is not a valid type name"

end
