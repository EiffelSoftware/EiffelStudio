note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_CALL_STACK_WIZARD_PAGE_PANEL

inherit
	ES_TEST_EXTRACTION_WIZARD_PAGE_PANEL
		rename
			make as make_panel
		redefine
			is_valid,
			store_to_session,
			build_widget_interface,
			initialize_with_session
		end

create
	make

feature {NONE} -- Initialization

	make (a_composition: like composition; an_app_status: like application_status)
			-- Initialize `Current'.
		do
			application_status := an_app_status
			create call_stack_elements.make (20)
			make_panel (a_composition)
		end

	build_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			build_call_stack_interface (a_widget)
			Precursor (a_widget)
		end

	build_call_stack_interface (a_widget: EV_VERTICAL_BOX)
			-- Build interface for selecting call stack elements.
		local
			l_frame: EV_FRAME
			l_hbox: EV_HORIZONTAL_BOX
			l_vbox: EV_VERTICAL_BOX
		do
			create l_frame.make_with_text (locale.translation (call_stack_text))
			a_widget.extend (l_frame)
			create l_hbox
			l_hbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			create grid
			grid.enable_multiple_row_selection
			grid.enable_resize_column (feature_column_index)

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

			create l_vbox
			l_vbox.set_border_width (1)
			l_vbox.set_background_color (unsensitive_color)
			l_vbox.extend (grid)
			l_hbox.extend (l_vbox)
			l_frame.extend (l_hbox)
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_stack: detachable EIFFEL_CALL_STACK
			i: INTEGER
			l_row: EV_GRID_ROW
			l_cse: CALL_STACK_ELEMENT
			l_stack_frame_count: NATURAL
		do
			Precursor (a_service)

			l_stack_frame_count := stack_frame_count.value.as_natural_32
			l_stack := application_status.current_call_stack
			if l_stack /= Void then
				from
					l_stack.start
					grid.insert_new_rows (l_stack.count, 1)
					i := 1
				until
					l_stack.after
				loop
					l_row := grid.row (i)
					check l_row /= Void end
					l_cse := l_stack.item
					check l_cse /= Void end
					populate_row (l_row, l_cse, l_stack_frame_count)
					l_stack.forth
					i := i + 1
				end
			end
			on_valid_state_change
		end

feature {ES_TEST_CALL_STACK_WIZARD_PAGE} -- Access

	call_stack_elements: SEARCH_TABLE [INTEGER]
			-- Call stack items selected by user

feature {NONE} -- Access

	application_status: APPLICATION_STATUS

	grid: ES_GRID
			-- Grid showing call stack

	selection_count: NATURAL
			-- Number of items selected in `grid'

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and selection_count > 0
		end

feature {NONE} -- Query

	is_valid_call_stack_element (a_index: INTEGER): BOOLEAN
			-- Is stack frame with `a_index' valid to extract?
			--
			-- Note: this is a code duplication from {ETEST_EXTRACTION}.
		local
			l_cs: EIFFEL_CALL_STACK
			l_feature: detachable E_FEATURE
		do
			l_cs := application_status.current_call_stack
			if l_cs /= Void and then l_cs.count >= a_index then
				if attached {EIFFEL_CALL_STACK_ELEMENT} l_cs.i_th(a_index) as l_cse then
					l_feature := l_cse.routine
					if l_feature /= Void and attached {EIFFEL_CLASS_C} l_cse.dynamic_class as l_class then
						if not (l_feature.is_external or l_feature.is_inline_agent) then
							Result := l_feature.export_status.is_all or else
								l_class.creation_feature = l_feature.associated_feature_i or else
								l_class.has_creators and then l_class.has_creator_named_with (l_feature)
						end
					end
				end
			end
		end

feature {NONE} -- Events

	on_selection_change (a_item: EV_GRID_CHECKABLE_LABEL_ITEM)
			-- Called when item is check box changes.
		do
			if a_item.is_checked then
				selection_count := selection_count + 1
			else
				selection_count := selection_count - 1
			end

			on_valid_state_change
		end

feature {ES_TEST_WIZARD_PAGE} -- Basic operations

	store_to_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			i: INTEGER
		do
			Precursor (a_service)
			call_stack_elements.wipe_out
			from
				i := 1
			until
				i > grid.row_count
			loop
				if attached {EV_GRID_CHECKABLE_LABEL_ITEM} grid.row (i).item (1) as l_item then
					if l_item.is_checked and attached {EIFFEL_CALL_STACK_ELEMENT} l_item.data as l_cse then
						call_stack_elements.force (l_cse.level_in_stack)
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Basic operations

	populate_row (a_row: EV_GRID_ROW; a_cse: CALL_STACK_ELEMENT; a_max_select: NATURAL)
			-- Populate row items with information from call stack element
			--
			--| Note: this code is a modified version of {ES_CALL_STACK_TOOL_PANEL}.compute_stack_grid_row
		local
			dc, oc: CLASS_C
			l_tooltip: STRING_32
			l_nb_stack: INTEGER
			l_feature_name: STRING_32
			l_text: STRING_32
			l_is_melted: BOOLEAN
			l_has_rescue: BOOLEAN
			l_class_info: STRING
			l_orig_class_info: STRING_GENERAL
			l_same_name: BOOLEAN
			l_breakindex_info: STRING
			l_obj_address_info: STRING
			l_extra_info: READABLE_STRING_32
			gclab: EV_GRID_CHECKABLE_LABEL_ITEM
			glab: EV_GRID_LABEL_ITEM
			l_sensitive: BOOLEAN
		do
			l_sensitive := is_valid_call_stack_element (a_cse.level_in_stack)

			create l_tooltip.make (10)

				--| Class name
			l_class_info := a_cse.class_name
			if l_class_info /= Void then
				l_tooltip.append ("{" + l_class_info + "}.")
			end

				--| Break Index
			l_breakindex_info := a_cse.break_index.out

				--| Routine name
			l_feature_name := a_cse.routine_name_for_display
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

			if attached {EIFFEL_CALL_STACK_ELEMENT} a_cse as e_cse then
					--| Origin class
				dc := e_cse.dynamic_class
				oc := e_cse.written_class

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
					attached {CALL_STACK_ELEMENT_DOTNET} e_cse as dotnet_cse and then
					attached dotnet_cse.dotnet_module_name as m
				then
					l_tooltip.append_string (interface_names.l_module_is (m))
				end
			else --| It means, this is an EXTERNAL_CALL_STACK_ELEMENT
				l_orig_class_info := ""
				if attached {EXTERNAL_CALL_STACK_ELEMENT} a_cse as ext_cse then
					l_extra_info := ext_cse.info
				end
			end

				--| Tooltip addition
			l_nb_stack := application_status.current_call_stack.count
			l_tooltip.prepend ((a_cse.level_in_stack).out + "/" + l_nb_stack.out + ": ")
			l_tooltip.append (interface_names.l_break_index_is (l_breakindex_info))
			l_tooltip.append (interface_names.l_address_is (l_obj_address_info))
			if attached l_extra_info then
				l_tooltip.append_string_general ("%N    + ")
				l_tooltip.append (l_extra_info)
			end

				--| Fill columns
			create l_text.make_from_string (" ")
			l_text.append (l_feature_name)
			create gclab.make_with_text (l_text)
			gclab.set_data (a_cse)
			gclab.checked_changed_actions.extend (agent on_selection_change)
			gclab.set_tooltip (l_tooltip)
			a_row.set_item (Feature_column_index, gclab)
			if l_sensitive then
				gclab.enable_sensitive
					-- Note: we only select the first 20 stack frames, which should limit the size of the test
					--       case if the user directly hits the create button.
				if selection_count < a_max_select then
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

feature {NONE} -- Internationalization

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

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
