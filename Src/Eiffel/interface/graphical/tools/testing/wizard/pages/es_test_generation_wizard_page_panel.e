note
	description: "Summary description for {ES_TEST_GENERATION_WIZARD_PAGE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_GENERATION_WIZARD_PAGE_PANEL

inherit
	ES_TEST_WIZARD_PAGE_PANEL
		rename
			make as make_panel
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR

create
	make

feature {NONE} -- Initialization

	make (a_composition: like composition; a_use_temp_types: BOOLEAN)
			-- Initialize `Current'.
		do
			use_temporary_types := a_use_temp_types
			make_panel (a_composition)
		end

	build_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_frame: EV_FRAME
			l_hbox: EV_HORIZONTAL_BOX
		do
			if use_temporary_types then
				create l_frame.make_with_text (locale.translation (temp_types_text))
			else
				create l_frame.make_with_text (locale.translation (types_text))
			end
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_hbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			l_frame.extend (l_hbox)
			extend_no_expand (a_widget, l_frame)
			build_types_interface (l_hbox)

			create l_frame.make_with_text (locale.translation (options_text))
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_hbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			l_frame.extend (l_hbox)
			extend_no_expand (a_widget, l_frame)
			build_options_interface (l_hbox)
		end

	build_types_interface (a_widget: EV_HORIZONTAL_BOX)
			-- Build interface for entering types.
		local
			l_textfield: EV_TEXT_FIELD
			l_label: EV_LABEL
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_dialog: EV_DIALOG
			l_button: EV_BUTTON
		do
			create type_list
			type_list.set_minimum_width (dialog_unit_to_pixels (150))
			type_list.set_minimum_height (dialog_unit_to_pixels (120))
			type_list.select_actions.extend (agent on_selection_change)
			type_list.deselect_actions.extend (agent on_selection_change)
			type_list.key_press_actions.extend (agent (a_key: EV_KEY)
				do
					if a_key.code = {EV_KEY_CONSTANTS}.key_delete then
						on_remove_types
					end
				end)
			a_widget.extend (type_list)

			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			create l_label.make_with_text (locale_formatter.translation (b_new_type))
			l_label.align_text_left
			extend_no_expand (l_vbox, l_label)

			create add_type_button
			add_type_button.set_minimum_width (dialog_unit_to_pixels (35))
			create remove_type_button
			remove_type_button.set_minimum_width (dialog_unit_to_pixels (35))

			create l_textfield
			l_dialog := composition.window.dialog
			l_button := l_dialog.default_push_button
			l_textfield.focus_in_actions.extend (agent l_dialog.set_default_push_button (add_type_button))
			l_textfield.focus_out_actions.extend (agent l_dialog.set_default_push_button (l_button))

			create type_field.make (l_textfield, agent on_validate_type)
			extend_no_expand (l_vbox, type_field)

			create l_hbox

			l_hbox.extend (create {EV_CELL})
			add_type_button.set_text (locale_formatter.translation (b_add_type))
			add_type_button.select_actions.extend (agent on_add_type)
			l_hbox.extend (add_type_button)
			l_hbox.disable_item_expand (add_type_button)

			remove_type_button.set_text (locale_formatter.translation (b_remove_type))
			remove_type_button.select_actions.extend (agent on_remove_types)
			l_hbox.extend (remove_type_button)
			l_hbox.disable_item_expand (remove_type_button)

			extend_no_expand (l_vbox, l_hbox)

			a_widget.extend (l_vbox)
		end

	build_options_interface (a_widget: EV_HORIZONTAL_BOX)
			-- Build interface for options.
		local
			l_vbox: EV_VERTICAL_BOX
		do
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create timeout_field
			timeout_field.value_range.resize_exactly (0, {INTEGER_32}.max_value)
			timeout_field.align_text_right

			create test_count_field
			test_count_field.value_range.resize_exactly (0, {INTEGER_32}.max_value)
			test_count_field.align_text_right

			create proxy_time_out
			proxy_time_out.value_range.resize_exactly (1, {INTEGER_32}.max_value)
			proxy_time_out.align_text_right

			create seed
			seed.set_minimum_width (dialog_unit_to_pixels (90))
			seed.value_range.resize_exactly (0, {INTEGER_32}.max_value)
			seed.align_text_right

			append_option (l_vbox, b_timeout, timeout_field)
			append_option (l_vbox, b_test_count, test_count_field)
			append_option (l_vbox, b_proxy_timeout, proxy_time_out)
			append_option (l_vbox, b_seed, seed)

			extend_no_expand (a_widget, l_vbox)

			extend_no_expand (a_widget, create {EV_VERTICAL_SEPARATOR})

			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create ddmin_checkbox.make_with_text (locale.translation (b_ddmin))
			create slicing_checkbox.make_with_text (locale.translation (b_slicing))
			create html_output.make_with_text (locale.translation (b_html_output))

			extend_no_expand (l_vbox, slicing_checkbox)
			extend_no_expand (l_vbox, ddmin_checkbox)
			extend_no_expand (l_vbox, html_output)

			extend_no_expand (a_widget, l_vbox)
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_global_session, l_session: SESSION_I
			l_list: LIST [STRING]
			l_value: ANY
		do
			initialize_type_field

			l_global_session := a_service.retrieve (False)
			l_session := a_service.retrieve (True)

			if use_temporary_types then
				l_value := l_session.value_or_default ({TEST_SESSION_CONSTANTS}.temporary_types,
					{TEST_SESSION_CONSTANTS}.temporary_types_default)
			else
				l_value := l_session.value_or_default ({TEST_SESSION_CONSTANTS}.types,
					{TEST_SESSION_CONSTANTS}.types_default)
			end
			if
				attached {STRING} l_value as l_types
			then
				l_list := l_types.split (',')
				from
					l_list.start
				until
					l_list.after
				loop
					add_type (l_list.item_for_iteration)
					l_list.forth
				end
			end

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.time_out,
					{TEST_SESSION_CONSTANTS}.time_out_default) as l_timeout
			then
				timeout_field.set_value (l_timeout.as_integer_32)
			end

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.invocation_count,
					{TEST_SESSION_CONSTANTS}.invocation_count_default) as l_count
			then
				test_count_field.set_value (l_count.as_integer_32)
			end

			if
				attached {BOOLEAN} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.enable_slicing,
					{TEST_SESSION_CONSTANTS}.enable_slicing_default) as l_enable
			then
				if l_enable then
					slicing_checkbox.enable_select
				else
					slicing_checkbox.disable_select
				end
			end

			if
				attached {BOOLEAN} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.enable_html_statistics,
					{TEST_SESSION_CONSTANTS}.enable_html_statistics_default) as l_enable
			then
				if l_enable then
					html_output.enable_select
				else
					html_output.disable_select
				end
			end

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.proxy_time_out,
					{TEST_SESSION_CONSTANTS}.proxy_time_out_default) as l_timeout
			then
				proxy_time_out.set_value (l_timeout.as_integer_32)
			end

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.seed,
					{TEST_SESSION_CONSTANTS}.seed_default) as l_seed
			then
				seed.set_value (l_seed.as_integer_32)
			end

			on_selection_change
			ddmin_checkbox.disable_sensitive
		end

	initialize_type_field
			-- Initialize `type_field'.
		do
			type_field.set_entry_formatter (agent {attached STRING_32}.as_upper)
			type_field.set_entry_validation (
				agent (a_string: STRING_32): BOOLEAN
					local
						i: INTEGER
						nb: INTEGER
						c: CHARACTER
					do
						from
							i := 1
							Result := True
							nb := a_string.count
						until
							i > a_string.count or not Result
						loop
							c := a_string.item (i).to_character_8
							if not c.is_alpha_numeric then
								inspect c
								when '[' then
								when ']' then
								when '!' then
								when '?' then
								when '_' then
								when ' ' then
								when ',' then
								else
									Result := False
								end
							end
							i := i + 1
						end
					end)
		end

feature {NONE} -- Access

	type_list: EV_LIST
			-- List showing types entered so far

	type_field: ES_VALIDATING_WRAPPED_WIDGET
			-- Field for entering new types to test

	add_type_button: EV_BUTTON
	remove_type_button: EV_BUTTON
			-- Buttons for adding/removing types

	timeout_field: EV_SPIN_BUTTON
			-- Text field containing time out

	test_count_field: EV_SPIN_BUTTON
			-- Text field containing maximum number of routine invokations

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

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Status report

	use_temporary_types: BOOLEAN
			-- Should the temporary types be used?

feature {NONE} -- Events

	on_validate_type (a_input: STRING_32): TUPLE [valid: BOOLEAN; error: detachable STRING_32]
			-- Called when input of `types' has to be validated.
		local
			l_types: STRING
			l_system: SYSTEM_I
			l_root: detachable SYSTEM_ROOT
			l_root_group: detachable CONF_GROUP
			l_root_class, l_class: detachable CLASS_C
			l_root_feature: detachable FEATURE_I
			l_type_as: detachable TYPE_AS
			l_type_a: detachable TYPE_A
			i: INTEGER
			l_level: NATURAL
		do
			Result := [True, Void]
			if not a_input.is_empty then
				l_types := a_input.to_string_8
				l_types.to_upper
				if not (l_types.has ('!') or l_types.has ('?')) then
					type_parser.parse_from_string ("type " + l_types, Void)
					error_handler.wipe_out
					l_type_as := type_parser.type_node
					if l_type_as /= Void then
						if test_suite.is_service_available then
							l_system := etest_suite.project_access.project.system.system
							if not l_system.root_creators.is_empty then
								from
									l_system.root_creators.start
								until
									l_system.root_creators.off
								loop
									l_root := l_system.root_creators.item_for_iteration
									if l_root.cluster.is_internal then
										l_system.root_creators.go_i_th (0)
									else
										l_system.root_creators.forth
									end
								end
								l_root_group := l_root.cluster
								l_root_class := l_root.root_class.compiled_class
								if l_root_class /= Void then
									l_root_feature := l_root_class.feature_named (l_root.procedure_name)
								end
							end
							if l_root_class /= Void and l_root_group /= Void and l_root_feature /= Void then
								if attached {CLASS_TYPE_AS} l_type_as as l_class_type then
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

	on_selection_change
			-- Called when selection of `type_list' changes.
		do
			adjust_sensitivity (remove_type_button, not type_list.selected_items.is_empty)
		end

	on_add_type
			-- Called when `add_type_button' is pressed.
		do
			if not type_field.text.is_empty and type_field.is_valid then
				add_type (type_field.text)
				type_field.set_text ("")
			end
		end

	on_remove_types
			-- Called when `remove_type_button' is called.
		local
			l_list: DYNAMIC_LIST [EV_LIST_ITEM]
		do
			l_list := type_list.selected_items
			from
				l_list.start
			until
				l_list.after
			loop
				type_list.prune (l_list.item_for_iteration)
				l_list.forth
			end
		end

feature {ES_TEST_WIZARD_PAGE} -- Basic operations

	store_to_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_global_session: SESSION_I
			l_session: SESSION_I
			l_types: STRING
		do
			l_global_session := a_service.retrieve (False)
			l_session := a_service.retrieve (True)

			create l_types.make (type_list.count*15)
			from
				type_list.start
			until
				type_list.after
			loop
				l_types.append_string_general (type_list.item_for_iteration.text)
				type_list.forth
				if not type_list.after then
					l_types.append_character (',')
				end
			end
			if use_temporary_types then
				l_session.set_value (l_types, {TEST_SESSION_CONSTANTS}.temporary_types)
			else
				l_session.set_value (l_types, {TEST_SESSION_CONSTANTS}.types)
			end

			l_global_session.set_value (timeout_field.value.as_natural_32, {TEST_SESSION_CONSTANTS}.time_out)
			l_global_session.set_value (test_count_field.value.as_natural_32, {TEST_SESSION_CONSTANTS}.invocation_count)
			l_global_session.set_value (slicing_checkbox.is_selected, {TEST_SESSION_CONSTANTS}.enable_slicing)
			l_global_session.set_value (html_output.is_selected, {TEST_SESSION_CONSTANTS}.enable_html_statistics)
			l_global_session.set_value (proxy_time_out.value.as_natural_32, {TEST_SESSION_CONSTANTS}.proxy_time_out)
			l_global_session.set_value (seed.value.as_natural_32, {TEST_SESSION_CONSTANTS}.seed)
		end

feature {NONE} -- Basic operations

	add_type (a_type: STRING_32)
			-- Add `a_tag' to `tag_list' if not already added.
		local
			l_item: EV_LIST_ITEM
			l_comp: INTEGER
		do
			if not a_type.is_empty then
				from
					type_list.start
					l_comp := -1
				until
					l_comp >= 0
				loop
					if type_list.after then
						l_comp := 1
					else
						l_comp := type_list.item_for_iteration.text.as_lower.three_way_comparison (a_type.as_lower)
						if l_comp = -1 then
							type_list.forth
						end
					end
				end
				if l_comp = 1 then
					create l_item.make_with_text (a_type)
					type_list.put_left (l_item)
				end
			end
		end

	append_option (a_parent: EV_BOX; a_name: STRING; a_widget: EV_WIDGET)
			-- Append option to container.
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

feature {NONE} -- Constants

	b_add_type: STRING = "+"
	b_remove_type: STRING = "-"

feature {NONE} -- Internationalization

	types_text: STRING = "Default types to test"
	temp_types_text: STRING = "Types to test"
	options_text: STRING = "Options"

	b_timeout: STRING = "Cutoff (minutes)"
	b_test_count: STRING = "Cutoff (invocations)"
	b_proxy_timeout: STRING = "Routine timeout (seconds)"
	b_seed: STRING = "Random seed"
	b_ddmin: STRING = "DDMin for minimization"
	b_slicing: STRING = "Slice minimization"
	b_html_output: STRING = "HTML statistics"
	b_new_type: STRING = "Class or type name"

	e_no_valid_type_name: STRING = "$1 is not a valid type name"
	e_unable_to_check_compiled_classes: STRING = "Unable to check if types or valid, please recompile and start again"
	e_class_not_compiled: STRING = "$1 is not a compiled type"
	e_attachment_marks_not_supported: STRING = "Attachment marks are not supported"
	e_no_expanded_types: STRING = "AutoTest is not able to test expanded types"
	e_invalid_type_definition: STRING = "$1 is not a valid type definition AutoTest can use"
	e_type_unkown: STRING = "$1 contains uncompiled types"
	e_type_contains_invalid_generic: STRING = "$1 contains invalid generic parameters"
	e_multiple_constrains_not_supported: STRING = "Type $1 can not be tested since it contains open generic parameters with multiple constraints. Please be more specific."
	e_recursive_generics_not_supported: STRING = "Type $1 can not be used for testing since it contains open recursive generic parameters. Please be more specific."

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
