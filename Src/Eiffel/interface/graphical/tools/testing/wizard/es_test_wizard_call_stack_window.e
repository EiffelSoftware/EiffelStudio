indexing
	description: "Summary description for {ES_TEST_WIZARD_CALL_STACK_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_CALL_STACK_WINDOW

inherit
	ES_TEST_WIZARD_FINAL_WINDOW

create
	make_window

feature {NONE} -- Initialization

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_vb: EV_VERTICAL_BOX
		do
			l_parent := initialize_container (choice_box)

			create grid
			grid.enable_multiple_row_selection
			grid.enable_resize_column (feature_column_index)
			--grid.enable_resize_column (position_column_index)

			grid.set_column_count_to (4)
			grid.column (Feature_column_index).set_title (locale_formatter.translation (h_feature))
			grid.column (Feature_column_index).set_width (120)
			grid.column (Position_column_index).set_title (" @") --Interface_names.t_Position)
			grid.column (Position_column_index).set_width (40)
			grid.column (Dtype_column_index).set_title (locale_formatter.translation (h_dtype))
			grid.column (Dtype_column_index).set_width (130)
			grid.column (Stype_column_index).set_title (locale_formatter.translation (h_stype))
			grid.column (Stype_column_index).set_width (130)

			grid.enable_auto_size_best_fit_column (feature_column_index)


			create l_vb
			l_vb.set_border_width (1)
			l_vb.set_background_color (unsensitive_color)
			l_vb.extend (grid)
			l_parent.extend (l_vb)

			on_after_initialize
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		local
			l_stack: ?EIFFEL_CALL_STACK
			i: INTEGER
			l_reg: TEST_PROCESSOR_REGISTRAR_I
		do
			if test_suite.is_service_available then
				l_reg := test_suite.service.processor_registrar
				if l_reg.is_valid_type (extractor_factory_type, test_suite.service) then
					if {l_extractor: like extractor} test_suite.service.factory (extractor_factory_type) then
						extractor := l_extractor
					end
				end
			end
			if debugger_manager.application_is_executing then
				if debugger_manager.application_is_stopped then
					l_stack := debugger_manager.application_status.current_call_stack
				end
			end
			wizard_information.call_stack_elements.wipe_out
			if l_stack /= Void and then not l_stack.is_empty then
				from
					l_stack.start
					grid.insert_new_rows (l_stack.count, 1)
					i := 1
				until
					l_stack.after
				loop
					if {l_row: !EV_GRID_ROW} grid.row (i) and {l_cse: !CALL_STACK_ELEMENT} l_stack.item then
						populate_row (l_row, l_cse)
					end
					l_stack.forth
					i := i + 1
				end
			end
		end

feature {NONE} -- Access

	factory_type: !TYPE [TEST_CREATOR_I]
			-- <Precursor>
		do
			Result := extractor_factory_type
		end

	grid: !ES_GRID
			-- Grid showing call stack

	extractor: ?TEST_EXTRACTOR_I
			-- Extractor instance

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := not wizard_information.call_stack_elements.is_empty
		end

feature {NONE} -- Query

	populate_row (a_row: !EV_GRID_ROW; a_cse: !CALL_STACK_ELEMENT)
			-- Populate row items with information from call stack element
			--
			--| Note: this code is a modified version of {ES_CALL_STACK_TOOL_PANEL}.compute_stack_grid_row
		local
			dc, oc: CLASS_C
			l_tooltip: STRING_32
			l_nb_stack: INTEGER
			l_feature_name: STRING
			l_is_melted: BOOLEAN
			l_has_rescue: BOOLEAN
			l_class_info: STRING
			l_orig_class_info: STRING_GENERAL
			l_same_name: BOOLEAN
			l_breakindex_info: STRING
			l_obj_address_info: STRING
			l_extra_info: STRING
			gclab: EV_GRID_CHECKABLE_LABEL_ITEM
			glab: EV_GRID_LABEL_ITEM
			app_exec: APPLICATION_EXECUTION
			l_sensitive, l_selected: BOOLEAN
		do
			if extractor /= Void then
				l_sensitive := extractor.is_valid_call_stack_element (a_cse.level_in_stack)
			end

			create l_tooltip.make (10)

				--| Class name
			l_class_info := a_cse.class_name
			if l_class_info /= Void then
				l_tooltip.append ("{" + l_class_info + "}.")
			end

				--| Break Index
			l_breakindex_info := a_cse.break_index.out

				--| Routine name
			l_feature_name := a_cse.routine_name
			if l_feature_name /= Void then
				l_feature_name := l_feature_name.twin
			else
				create l_feature_name.make_empty
			end
--| Decide later, if we want the  "@bp-index" visible
--				if l_feature_name /= Void then
--					l_feature_name.append (" @" + l_breakindex_info.out)
--				end

			l_tooltip.append (l_feature_name)

				--| Object address
			l_obj_address_info := a_cse.object_address.output

			if {e_cse: EIFFEL_CALL_STACK_ELEMENT} a_cse then
					--| Origin class
				dc := e_cse.dynamic_class
				oc := e_cse.written_class

				if l_sensitive and then {l_ec: EIFFEL_CLASS_C} dc then
					l_selected := a_cse.level_in_stack = 1 or not (l_ec.cluster.is_used_in_library and l_ec.cluster.is_readonly)
				end

				if oc /= Void then
					l_orig_class_info := oc.name_in_upper
					l_same_name := dc /= Void and then oc.same_type (dc) and then oc.is_equal (dc)
					if not l_same_name then
						l_tooltip.prepend_string (interface_names.l_from_class (l_orig_class_info))
					end
				else
					l_orig_class_info := Interface_names.l_Same_class_name
				end

					--| Routine name
				l_has_rescue := e_cse.has_rescue
				if l_has_rescue then
					l_tooltip.append_string (interface_names.l_feature_has_rescue_clause)
				end
				l_is_melted := e_cse.is_melted
				if l_is_melted then
					l_tooltip.append_string (interface_names.l_compilation_equal_melted)
				end

				if
					{dotnet_cse: CALL_STACK_ELEMENT_DOTNET} e_cse
					and then dotnet_cse.dotnet_module_name /= Void
				then
					l_tooltip.append_string (interface_names.l_module_is (dotnet_cse.dotnet_module_name))
				end
			else --| It means, this is an EXTERNAL_CALL_STACK_ELEMENT
				l_orig_class_info := ""
				if {ext_cse: EXTERNAL_CALL_STACK_ELEMENT} a_cse then
					l_extra_info := ext_cse.info
				end
			end

			check debugger_manager.application_is_executing end
			app_exec := Debugger_manager.application
				--| Tooltip addition
			l_nb_stack := app_exec.status.current_call_stack.count
			l_tooltip.prepend_string ((a_cse.level_in_stack).out + "/" + l_nb_stack.out + ": ")
			l_tooltip.append_string (interface_names.l_break_index_is (l_breakindex_info))
			l_tooltip.append_string (interface_names.l_address_is (l_obj_address_info))
			if l_extra_info /= Void then
				l_tooltip.append_string ("%N    + " + l_extra_info)
			end

				--| Fill columns
			create gclab.make_with_text (" " + l_feature_name)
			gclab.set_data (a_cse)
			gclab.checked_changed_actions.extend (agent on_selection_change)
			gclab.set_tooltip (l_tooltip)
			a_row.set_item (Feature_column_index, gclab)
			if l_sensitive then
				gclab.enable_sensitive
				if l_selected then
					gclab.toggle_is_checked
				end
			else
				gclab.set_foreground_color (unsensitive_color)
				gclab.disable_sensitive
			end

				--| Position
			create glab.make_with_text (a_cse.break_index.out)
			if not l_sensitive then
				glab.set_foreground_color (unsensitive_color)
			end
			a_row.set_item (Position_column_index, glab)

				--| Dynamic Type
			create glab.make_with_text (l_class_info)
			if not l_sensitive then
				glab.set_foreground_color (unsensitive_color)
			end
			glab.set_tooltip (l_class_info)
			a_row.set_item (Dtype_column_index, glab)

				--| Origine Type
			create glab.make_with_text (l_orig_class_info)
			if l_same_name or not l_sensitive then
				glab.set_foreground_color (unsensitive_color)
			end
			glab.set_tooltip (l_orig_class_info)
			a_row.set_item (Stype_column_index, glab)
		end

feature {NONE} -- Events

	on_selection_change (a_item: EV_GRID_CHECKABLE_LABEL_ITEM)
			-- Called when item is check box changes.
		local
			l_index: INTEGER
		do
			if {l_cse: !CALL_STACK_ELEMENT} a_item.data then
				l_index := l_cse.level_in_stack
				if a_item.is_checked then
					wizard_information.call_stack_elements.force (l_index)
				else
					wizard_information.call_stack_elements.remove (l_index)
				end
			end
			update_next_button_status
		end

feature {NONE} -- Internationalization

	t_title: !STRING = "Extract application state"
	t_subtitle: !STRING = "Chose features on call stack for which test should be created"

	h_feature: STRING = "Feature"
	h_dtype: STRING = "In Class"
	h_stype: STRING = "From Class"

feature {NONE} -- Constants

	feature_column_index: INTEGER = 1
	position_column_index: INTEGER = 4
	dtype_column_index: INTEGER = 2
	stype_column_index: INTEGER = 3

	unsensitive_color: EV_COLOR
		once
			Result := (create {EV_STOCK_COLORS}).grey
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
