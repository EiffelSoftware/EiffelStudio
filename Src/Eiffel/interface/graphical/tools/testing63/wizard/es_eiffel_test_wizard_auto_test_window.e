indexing
	description: "Summary description for {ES_EIFFEL_TEST_WIZARD_AUTO_TEST_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_AUTO_TEST_WINDOW

inherit
	ES_EIFFEL_TEST_WIZARD_FINAL_WINDOW
		redefine
			make_window
		end

create
	make_window

feature {NONE} -- Initialization

	make_window (a_development_window: like development_window; a_wizard_info: like wizard_information)
			-- <Precursor>
		do
			Precursor (a_development_window, a_wizard_info)
			create splitter.make_with_separators (" ")
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
			build_class_tree (l_hbox)
			build_options (l_hbox)
			l_parent.extend (l_hbox)

			on_after_initialize
		end

	build_class_tree (a_parent: EV_BOX)
			-- Build class tree for selecting classes to test.
		local
			l_list: ?DS_ARRAYED_LIST [CLASS_I]
			l_item: EV_LIST_ITEM
			l_class: CLASS_I
		do
			create class_list
			class_list.enable_multiple_selection
			class_list.set_minimum_width (200)
			a_parent.extend (class_list)

			if test_suite.is_service_available then
				if test_suite.service.is_project_initialized then
					create l_list.make_from_linear(test_suite.service.eiffel_project.universe.all_classes)
				end
			end
			if l_list /= Void then
				l_list.sort (create {DS_QUICK_SORTER [CLASS_I]}.make (create {KL_COMPARABLE_COMPARATOR [CLASS_I]}.make))
				from
					l_list.start
				until
					l_list.after
				loop
					l_class := l_list.item_for_iteration
					create l_item.make_with_text (l_class.name)
					l_item.set_pixmap (pixmaps.icon_pixmaps.class_normal_icon)
					class_list.extend (l_item)
					if wizard_information.class_names.has (l_class.name.as_attached) then
						l_item.enable_select
					end
					l_list.forth
				end
			end
			class_list.select_actions.extend (agent on_class_select_change)
			class_list.deselect_actions.extend (agent on_class_select_change)
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
			append_option (l_vbox, "", seed)
			append_option (l_vbox, b_slicing, slicing_checkbox)
			append_option (l_vbox, b_ddmin, ddmin_checkbox)
			append_option (l_vbox, b_html_output, html_output)
			append_option (l_vbox, b_benchmark, benchmark_checkbox)

			create l_cell
			l_vbox.extend (l_cell)
			l_vbox.disable_item_expand (l_cell)

			a_parent.extend (l_vbox)
		end

	append_option (a_parent: EV_BOX; a_name: !STRING; a_widget: EV_WIDGET)
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create l_hbox
			create l_label.make_with_text (local_formatter.translation (a_name))
			l_label.align_text_left
			l_hbox.extend (l_label)
			l_hbox.extend (a_widget)
			l_hbox.disable_item_expand (a_widget)
			a_parent.extend (l_hbox)
			a_parent.disable_item_expand (l_hbox)
		end

	on_after_initialize
			-- Called after all widgets have been created
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
		end

feature {NONE} -- Access

	splitter: ST_SPLITTER
			-- Splitter for `arguments'

	factory_type: !TYPE [EIFFEL_TEST_FACTORY_I]
			-- <Precursor>
		do
			Result := generator_factory_type
		end

	class_list: EV_LIST
			-- Tree showing all classes in the system

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

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := not wizard_information.class_names.is_empty
		end

feature {NONE} -- Events

	on_class_select_change (a_item: EV_LIST_ITEM)
		do
			if a_item.is_selected then
				wizard_information.class_names.force_last (a_item.text.to_string_8.as_attached)
			else
				wizard_information.class_names.remove (a_item.text.to_string_8.as_attached)
			end
			update_next_button_status
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

end
