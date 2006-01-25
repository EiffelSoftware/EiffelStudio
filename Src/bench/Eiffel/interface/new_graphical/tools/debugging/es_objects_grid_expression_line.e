indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_EXPRESSION_LINE

inherit

	ES_OBJECTS_GRID_LINE
		rename
			data as expression,
			set_data as set_expression,
			Col_name_index as Col_expression_index,
			Col_type_index as Col_expression_info_index,
			Col_value_index as Col_expression_result_index,
			set_name as set_expression_text,
			set_address as set_expression_result_address,
			set_value as set_expression_result,
			set_type as set_expression_info,
			apply_cell_name_properties_on as apply_cell_expression_text_properties_on
		redefine
			set_expression_text,
			expression,
			apply_cell_expression_text_properties_on,
			recycle,
			refresh
		end

create
	make_with_expression

feature {NONE} -- Initialization

	make_with_expression (exp: EB_EXPRESSION; g: like parent_grid) is
		require
			exp /= Void
		do
			make_with_grid (g)
			set_expression (exp)
			if expression.is_evaluated then
				expression_evaluator := expression.expression_evaluator
				if not expression.error_occurred then
					last_dump_value := expression_evaluator.final_result_value
					if last_dump_value /= Void then
						object_address := last_dump_value.address
					else
						object_address := Void
					end
					object_dynamic_class := expression_evaluator.final_result_type
					if object_dynamic_class /= Void then
						object_is_special_value := object_dynamic_class.is_special
					end
				end
			end
		end

feature -- Recycling

	recycle is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor
			internal_associated_dump_value := Void
			expression_evaluator := Void
			if expression /= Void then
				expression.recycle
			end
			evaluation_requested := False
			refresh_requested := False
		end

feature -- Refresh management

	refresh_requested: BOOLEAN

	request_refresh is
			-- Use this when we don't want to evaluate the expression if the grid is not displayed
		require
			refresh_not_requested: not refresh_requested
		do
			if evaluation_requested then
				refresh_requested := True
				refresh
				refresh_requested := False
			else
				refresh
			end
		ensure
			refresh_not_requested: not refresh_requested
		end

	refresh is
		require else
			has_expression: expression /= Void
		do
			last_dump_value := Void
			object_address := Void
			object_dynamic_class := Void

			if
				not evaluation_requested --| i.e: evaluate only on `grid_display_compute'
				and then expression.is_evaluated
			then
				expression_evaluator := expression.expression_evaluator
				if not expression.error_occurred then
					last_dump_value := expression_evaluator.final_result_value
					if last_dump_value /= Void then
						object_address := last_dump_value.address
					else
						object_address := Void
					end
					object_dynamic_class := expression_evaluator.final_result_type
				end
			end
			Precursor
		end

	request_evaluation (v: BOOLEAN) is
			-- Request an evaluation on next grid display computing
			-- (i.e: evaluate `expression' only if displayed)
		do
			evaluation_requested := v
		end

feature {NONE} -- Refresh implementation

	process_evaluation is
		require
			evaluation_requested
		do
			evaluation_requested := False
			expression.evaluate
			refresh
		ensure
			not evaluation_requested
		end

	evaluation_requested: BOOLEAN
			-- Is evaluation requested ?

feature -- change properties

	apply_cell_expression_text_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		do
			Precursor (a_item)
			if expression.evaluation_disabled then
				a_item.set_foreground_color (parent_grid.disabled_row_fg_color)
			elseif expression.error_occurred then
				a_item.set_foreground_color (parent_grid.error_row_fg_color)
			else
				a_item.set_foreground_color (parent_grid.parent.foreground_color)
			end
		end

feature -- Properties

	expression: EB_EXPRESSION

	expression_evaluator: DBG_EXPRESSION_EVALUATOR

	object_name: STRING is
		do
			if title /= Void then
				Result := title
			elseif expression.expression /= Void then
				Result := expression.expression
			else
				Result := object_address
			end
		end

	object_address: STRING

	object_dynamic_class: CLASS_C

	object_spec_capacity: INTEGER is
		do
			Result := debugged_object_manager.special_object_capacity_at_address (object_address)
		end

feature -- Query

	has_attributes_values: BOOLEAN is
		do
fixme ("find a smarter way to get a valid value")
			Result := True
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			if object_address /= Void then
				Result := debugged_object_manager.sorted_attributes_at_address (object_address, object_spec_lower, object_spec_upper)
			end
		end

	sorted_once_functions: LIST [E_FEATURE] is
		do
			if object_dynamic_class /= Void then
				Result := object_dynamic_class.once_functions
			end
		end

	object_value: STRING is
			-- Full ouput representation for related object
		require
			last_dump_value /= Void
		do
			Result := last_dump_value.output_for_debugger
		end

	object_type_representation: STRING is
			-- Full ouput representation for related object
		require
			last_dump_value /= Void
		do
			Result := last_dump_value.generating_type_representation
		end

	associated_dump_value: DUMP_VALUE is
		do
			Result := internal_associated_dump_value
			if Result = Void then
				Result := Application.dump_value_at_address_with_class (object_address, object_dynamic_class)
				internal_associated_dump_value := Result
			end
		end

	internal_associated_dump_value: like associated_dump_value

feature -- Graphical changes

	set_expression_text (v: STRING) is
		require else
			is_attached_to_row: row /= Void
		local
			gedit: ES_OBJECTS_GRID_EXPRESSION_CELL
			l_provider: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER
			l_class_c: CLASS_C
			l_feature_as: FEATURE_AS
		do
			title := v
			if Col_expression_index > 0 and Col_expression_index <= row.count then
				gedit ?= row.item (Col_expression_index)
			end
			if gedit = Void then
				create gedit
				grid_cell_set_text (gedit, v)

				gedit.pointer_double_press_actions.extend (agent grid_activate_item_if_row_selected (gedit, False, ?,?,?,?,?,?,?,?))
				gedit.pointer_button_press_actions.extend (agent grid_activate_item_if_row_selected (gedit, True, ?,?,?,?,?,?,?,?))
				gedit.deactivate_actions.extend (agent update_expression_on_deactivate (gedit))
				apply_cell_expression_text_properties_on (gedit)

				row.set_item (Col_expression_index, gedit)

				if expression.context_class /= Void then
					l_class_c := expression.context_class
				else
					l_class_c := eb_debugger_manager.debugging_class_c
					l_feature_as := eb_debugger_manager.debugging_feature_as
				end
				if l_class_c /= Void then
					create l_provider.make (l_class_c, l_feature_as, expression.context_class /= Void)
					gedit.set_completion_possibilities_provider (l_provider)
				end
			end
			gedit.set_text (v)
		end

	update_expression_on_deactivate (a_item: ES_OBJECTS_GRID_EXPRESSION_CELL) is
		require
			a_item /= Void
		local
			new_text: STRING
			r: EV_GRID_ROW
		do
			r := a_item.row

			new_text := a_item.text
			if new_text /= Void then
				new_text.left_adjust
				if expression.as_object then
						--| i.e: we just change the "title" of the expression
					if not new_text.is_equal (expression.name) then
						expression.set_name (new_text)
						set_title (expression.name)
					end
				else
					if
						new_text.is_empty
					then
						a_item.set_text (expression.expression)
					elseif not new_text.is_equal (expression.expression) then
						expression.set_expression (new_text)
						if application.is_running and then application.is_stopped then
							request_evaluation (True)
						elseif expression /= Void then
							expression.set_unevaluated
						end
						refresh
					end
				end
			end
			if r /= Void and then r.parent /= Void then
				r.enable_select
			end
		end

	set_error_pixmap (v: EV_PIXMAP) is
		require
			row.count > 0
		local
			gi: EV_GRID_ITEM
		do
			gi := row.item (Col_expression_index)
			grid_cell_set_pixmap (gi, v)
		end

	set_expression_pixmap (v: EV_PIXMAP) is
		require
			row.count > 0
		local
			gi: EV_GRID_ITEM
		do
			gi := row.item (Col_expression_index)
			grid_cell_set_pixmap (gi, v)
		end

	show_error_dialog (txt: STRING) is
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
			l_tag: STRING
		do
			if expression /= Void then
				l_tag := expression.expression.twin
				if l_tag /= Void then
					l_tag.prepend_string ("Error on expression : %"")
					l_tag.append_string ("%"%N")
				end
			end
			create dlg.make (l_tag, txt)
			dlg.set_title_and_label ("Watch tool :: error message", "Error message :")
			dlg.show_modal_to_window (parent_window_from (row.parent.parent))
		end

	grid_activate_item_if_row_selected (a_item: EV_GRID_ITEM;
				check_if_row_selected: BOOLEAN;
				ax, ay, abutton: INTEGER;
				ax_tilt, ay_tilt, apressure: DOUBLE;
				ascreen_x, ascreen_y: INTEGER
			) is
		require
			item_not_void: a_item /= Void
		local
			r: EV_GRID_ROW
		do
			if
				abutton = 1
				and not ev_application.ctrl_pressed
				and not ev_application.shift_pressed
				and not ev_application.alt_pressed
			then
				r := a_item.row
				if
					r /= Void
					and then (not check_if_row_selected or else r.is_selected)
				then
					a_item.activate
				end
			end
		end

	compute_grid_display is
		local
			l_tooltip: STRING
			l_error_message: STRING
			l_error_tag: STRING
			glab: EV_GRID_LABEL_ITEM
			add,res,typ: STRING
			l_exception_dump_value: DUMP_VALUE
		do
			if not compute_grid_display_done and not refresh_requested then
				if evaluation_requested then
					process_evaluation
				elseif row /= Void then
					check
						not evaluation_requested
					end
					compute_grid_display_done := True

					create l_tooltip.make (20)

					if expression.as_object and then expression.context_address /= Void then
						if expression.name /= Void then
							set_title (expression.name)
						else
							set_title (expression.context_address)
						end
						l_tooltip.append_string ("OBJECT NAME: " + title)
					else
						set_expression_text (expression.expression)
						l_tooltip.append_string ("EXPRESSION: " + expression.expression)
					end
					l_tooltip.append_string ("%NCONTEXT: " + expression.context + "%N")

					if expression.evaluation_disabled then
						set_expression_info ("Disabled")
						set_expression_result_address (Void)
						set_expression_result ("")
						set_pixmap (Pixmaps.Icon_expression_disabled)
					elseif not expression.is_evaluated then
						set_expression_info ("Unevaluated")
						set_expression_result_address (Void)
						set_expression_result ("")
						set_pixmap (Void)
					else
						check
							expression_evaluator /= Void
						end
						if expression_evaluator.error_occurred then
							l_error_message := expression_evaluator.text_from_error_messages
							l_error_tag := expression_evaluator.short_text_from_error_messages
							l_tooltip.prepend_string ("ERROR OCCURRED: %N" + l_error_message + "%N%N")
							if l_error_tag /= Void then
								l_error_tag := "[" + l_error_tag + "] "
							else
								l_error_tag := ""
							end
							set_expression_info (l_error_tag)

							create glab
							grid_cell_set_text (glab, "Error occurred (double click to see details)")
							glab.pointer_double_press_actions.force_extend (agent show_error_dialog (l_error_message))
							row.set_item (Col_expression_result_index, glab)

							if expression_evaluator.has_error_exception then
								set_error_pixmap (pixmaps.small_pixmaps.icon_dbg_error)
							elseif expression_evaluator.has_error_expression
								or expression_evaluator.has_error_syntax then
								set_error_pixmap (Pixmaps.Icon_compilation_failed)
							elseif expression_evaluator.has_error_evaluation then
								set_error_pixmap (pixmaps.small_pixmaps.icon_dbg_error)
							elseif expression_evaluator.has_error_not_implemented then
								set_error_pixmap (Pixmaps.Icon_compilation_failed)
							end
							l_exception_dump_value := expression_evaluator.final_result_value
							if l_exception_dump_value /= Void and then l_exception_dump_value.is_type_exception then
								attach_debug_value_to_grid_row (grid_extended_new_subrow (row), l_exception_dump_value.value_exception)
							end
						else
							if last_dump_value /= Void then
								add := object_address
								res := object_value
								typ := object_type_representation
								l_tooltip.append_string ("TYPE: " + typ + "%N")
								l_tooltip.append_string ("VALUE: " + res + "%N")
								if not last_dump_value.is_basic and not last_dump_value.is_void then
									row.ensure_expandable
									expand_actions.extend (agent on_row_expand)
									collapse_actions.extend (agent on_row_collapse)
								end
							else
								res := ""
								typ := ""
							end
							set_expression_info (typ)
							set_expression_result_address (add)
							set_expression_result (res)
							set_expression_pixmap (Pixmaps.Icon_green_tick)
						end
					end
					set_context (expression.context)
					if row.item (col_expression_index) /= Void then
						grid_cell_set_tooltip (row.item (Col_expression_index), l_tooltip)
					end
					if display and row.is_expandable then
						row.expand
					end
					update
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
