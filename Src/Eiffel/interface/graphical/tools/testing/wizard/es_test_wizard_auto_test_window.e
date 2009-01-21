note
	description: "Summary description for {ES_TEST_WIZARD_AUTO_TEST_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_AUTO_TEST_WINDOW

inherit
	ES_TEST_WIZARD_FINAL_WINDOW
		redefine
			make_window,
			conf,
			has_valid_conf,
			update_state_information
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
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
			timeout_field.value_range.resize_exactly (1, {INTEGER_32}.max_value)

			create proxy_time_out
			proxy_time_out.value_range.resize_exactly (1, {INTEGER_32}.max_value)

			create seed
			seed.set_minimum_width (170)
			seed.value_range.resize_exactly (1, {INTEGER_32}.max_value)
			create ddmin_checkbox
			create slicing_checkbox
			create html_output

			append_option (l_vbox, b_timeout, timeout_field)
			append_option (l_vbox, b_proxy_timeout, proxy_time_out)
			append_option (l_vbox, b_seed, create {EV_CELL})
			append_option (l_vbox, " ", seed)
			append_option (l_vbox, b_slicing, slicing_checkbox)
			append_option (l_vbox, b_ddmin, ddmin_checkbox)
			append_option (l_vbox, b_html_output, html_output)

			create l_cell
			l_vbox.extend (l_cell)
			l_vbox.disable_item_expand (l_cell)

			a_parent.extend (l_vbox)
			a_parent.disable_item_expand (l_vbox)
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

			create add_type_button
			create remove_type_button

			create l_textfield
			l_textfield.focus_in_actions.extend (
				agent
					do
						first_window.set_default_push_button (add_type_button)
					end)
			l_textfield.focus_out_actions.extend (
				agent
					do
						first_window.reset_default_push_button
					end)

			create type_field.make (l_textfield, agent on_validate_type)
			l_hbox.extend (type_field)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			l_hbox.extend (create {EV_CELL})

			add_type_button.set_text (locale_formatter.translation (b_add_type))
			add_type_button.select_actions.extend (agent on_add_type)
			l_hbox.extend (add_type_button)
			l_hbox.disable_item_expand (add_type_button)

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
			timeout_field.set_text (conf.time_out_cache.out)
			proxy_time_out.set_text (conf.proxy_time_out_cache.out)
			seed.set_text (conf.seed_cache.out)
			if conf.is_ddmin_enabled_cache then
				ddmin_checkbox.enable_select
			else
				ddmin_checkbox.disable_select
			end
			if conf.is_slicing_enabled_cache then
				slicing_checkbox.enable_select
			else
				slicing_checkbox.disable_select
			end
			if conf.is_html_output_cache then
				html_output.enable_select
			else
				html_output.disable_select
			end
			update_next_button_status

			from
				l_cursor := conf.types_cache.new_cursor
				l_cursor.start
				create l_types.make (conf.types_cache.count * 25)
			until
				l_cursor.after
			loop
				l_types.append (l_cursor.item)
				l_cursor.forth
				if not l_cursor.after then
					l_types.append (", ")
				end
			end

			conf.types_cache.do_all (
				agent (a_type: !STRING)
					do
						type_list.extend (create {EV_LIST_ITEM}.make_with_text (a_type))
					end)

			type_field.validate
			remove_type_button.disable_sensitive
		end

feature {NONE} -- Access

	conf: TEST_GENERATOR_CONF
			-- <Precursor>
		do
			Result := wizard_information.generator_conf
		end

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
			Result := not conf.types_cache.is_empty
		end

	has_valid_conf (a_wizard_info: like wizard_information): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_wizard_info) and a_wizard_info.is_generator_conf
		end

feature {NONE} -- Events

	on_validate_type (a_input: !STRING_32): !TUPLE [valid: BOOLEAN; error: ?STRING_32]
			-- Called when input of `types' has to be validated.
		local
			l_types: STRING
			l_system: SYSTEM_I
			l_root: ?SYSTEM_ROOT
			l_root_group: ?CONF_GROUP
			l_root_class, l_class: ?CLASS_C
			l_root_feature: ?FEATURE_I
			l_type_as: ?TYPE_AS
			l_type_a: ?TYPE_A
			i: INTEGER
			l_level: NATURAL
		do
			Result := [True, Void]
			if not a_input.is_empty then
				l_types := a_input.to_string_8
				l_types.to_upper
				if not (l_types.has ('!') or l_types.has ('?')) then
					type_parser.parse_from_string ("type " + l_types)
					error_handler.wipe_out
					l_type_as := type_parser.type_node
					if l_type_as /= Void then
						if test_suite.is_service_available and then test_suite.service.is_project_initialized then
							l_system := test_suite.service.eiffel_project.system.system
							if not l_system.root_creators.is_empty then
								l_root := l_system.root_creators.first
								l_root_group := l_root.cluster
								l_root_class := l_root.root_class.compiled_class
								if l_root_class /= Void then
									l_root_feature := l_root_class.feature_named (l_root.procedure_name)
								end
							end
							if l_root_class /= Void and l_root_group /= Void and l_root_feature /= Void then
								if {l_class_type: CLASS_TYPE_AS} l_type_as then
									l_type_a := type_a_generator.evaluate_type_if_possible (l_type_as, l_root_class)
									if l_type_a /= Void and l_class_type.generics = Void then
										l_class := l_type_a.associated_class
										check l_class /= Void end
										if l_class.is_expanded then
											Result.valid := False
											Result.error := locale_formatter.translation (e_no_expanded_types)
										elseif l_class.is_generic then
											from
												i := 1
											until
												not l_class.is_valid_formal_position (i) or not Result.valid
											loop
												if l_class.generics [i].is_multi_constrained (l_class.generics) then
													Result.valid := False
													Result.error := locale_formatter.formatted_translation (e_multiple_constrains_not_supported, [l_types])
												elseif l_class.constrained_type (i).has_formal_generic then
													Result.valid := False
													Result.error := locale_formatter.formatted_translation (e_recursive_generics_not_supported, [l_types])
												end
												i := i + 1
											end
										end
									elseif l_type_a /= Void then
										l_level := error_handler.error_level
										type_a_checker.init_for_checking (l_root_feature, l_root_class, Void, error_handler)
										l_type_a := type_a_checker.check_and_solved (l_type_a, l_type_as)
										type_a_checker.check_type_validity (l_type_a, l_type_as)
										if error_handler.error_level /= l_level then
											Result.valid := False
											Result.error := locale_formatter.formatted_translation (e_type_contains_invalid_generic, [l_types])
											l_type_a := Void
											error_handler.wipe_out
										end
									end
									if l_type_a = Void and Result.valid then
										Result.valid := False
										Result.error := locale_formatter.formatted_translation (e_type_unkown, [l_types])
									end
								else
									Result := [False, locale_formatter.formatted_translation (e_invalid_type_definition, [l_types])]
								end
							else
								Result := [False, locale_formatter.translation (e_unable_to_check_compiled_classes)]
							end
						else
							Result := [False, locale_formatter.translation (e_service_not_available)]
						end
					else
						Result := [False, locale_formatter.formatted_translation (e_no_valid_type_name, [l_types])]
					end
				else
					Result := [False, locale_formatter.translation (e_attachment_marks_not_supported)]
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
			l_new: STRING
		do
			if not type_field.text.is_empty and type_field.is_valid then
				l_new := type_field.text.to_string_8
				check l_new /= Void end
				conf.types_cache.search (l_new)
				if not conf.types_cache.found then
					conf.types_cache.force_last (l_new)
					type_list.extend (create {EV_LIST_ITEM}.make_with_text (l_new))
				end
				type_field.set_text (create {STRING_32}.make_empty)
				update_next_button_status
			end
		end

	on_remove_type
			-- Called when user presses `remove_type' button
		local
			l_type: STRING
		do
			if type_list.selected_item /= Void then
				l_type := type_list.selected_item.text.to_string_8
				check l_type /= Void end
				conf.types_cache.remove (l_type)
				type_list.prune (type_list.selected_item)
				update_next_button_status
			end
		end

	on_selection_change
			-- Called when selection of `type_list' changes.
		local
			l_item: EV_LIST_ITEM
		do
			l_item := type_list.selected_item
			if l_item /= Void and then l_item.is_selected then
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

feature {NONE} -- Basic operations

	update_state_information
			-- <Precursor>
		local
			l_conf: like conf
		do
			l_conf := conf
			l_conf.time_out_cache := timeout_field.value.to_natural_32
			l_conf.proxy_time_out_cache := proxy_time_out.value.to_natural_32
			l_conf.seed_cache := seed.value.to_natural_32
			l_conf.is_ddmin_enabled_cache := ddmin_checkbox.is_selected
			l_conf.is_slicing_enabled_cache := slicing_checkbox.is_selected
			l_conf.is_html_output_cache := html_output.is_selected
		end

feature {NONE} -- Internationalization

	t_title: !STRING = "Generate tests through AutoTest"
	t_subtitle: !STRING = "Define commands to run auto test"

	b_timeout: !STRING = "Duration (minutes)"
	b_proxy_timeout: !STRING = "Routine timeout (seconds)"
	b_seed: !STRING = "Random number generation seed"
	b_ddmin: !STRING = "Use ddmin for minimization"
	b_slicing: !STRING = "Use slicing for minimization"
	b_html_output: !STRING = "Create HTML output"
	b_new_type: !STRING = "Typename"

	e_no_valid_type_name: !STRING = "$1 is not a valid type name"
	e_unable_to_check_compiled_classes: !STRING = "Unable to check if types or valid, please recompile and start again"
	e_class_not_compiled: !STRING = "$1 is not a compiled type"
	e_attachment_marks_not_supported: !STRING = "Attachment marks are not supported"
	e_no_expanded_types: !STRING = "AutoTest is not able to test expanded types"
	e_invalid_type_definition: !STRING = "$1 is not a valid type definition AutoTest can use"
	e_type_unkown: !STRING = "$1 contains uncompiled types"
	e_type_contains_invalid_generic: !STRING = "$1 contains invalid generic parameters"
	e_multiple_constrains_not_supported: !STRING = "Type $1 can not be tested since it contains open generic parameters with multiple constraints. Please be more specific."
	e_recursive_generics_not_supported: !STRING = "Type $1 can not be used for testing since it contains open recursive generic parameters. Please be more specific."

feature {NONE} -- Constants

	b_add_type: !STRING = "+"
	b_remove_type: !STRING = "-"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
