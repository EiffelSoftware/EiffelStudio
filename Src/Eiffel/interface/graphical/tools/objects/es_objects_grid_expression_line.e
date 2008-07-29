indexing
	description: "Objects that represent an expression line"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_EXPRESSION_LINE

inherit
	ES_OBJECTS_GRID_OBJECT_LINE
		rename
			data as expression_evaluation,
			set_data as set_expression_evaluation,
			Col_name_index as Col_expression_index,
			Col_type_index as Col_expression_info_index,
			Col_value_index as Col_expression_result_index,
			set_name as set_expression_text,
			set_address as set_expression_result_address,
			set_value as set_expression_result,
			set_type as set_expression_info
		redefine
			set_expression_text,
			expression_evaluation,
			reset,
			refresh
		end

create
	make_with_expression_evaluation

feature {NONE} -- Initialization

	make_with_expression_evaluation (evl: DBG_EXPRESSION_EVALUATION; g: like parent_grid) is
			-- Create Current line with `evl' data, and inside grid `g'
		require
			evaluation_attached: evl /= Void
		do
			make_with_grid (g)
			set_expression_evaluation (evl)
			if evl.evaluated then
				if not evl.error_occurred then
					last_dump_value := evl.value
					if last_dump_value /= Void then
						object_address := last_dump_value.address
						object_dynamic_class := last_dump_value.dynamic_class
					else
						object_address := Void
						object_dynamic_class := evl.dynamic_class
					end
					if object_dynamic_class = Void then
						object_dynamic_class := evl.static_class
					end
					if object_dynamic_class /= Void then
						object_is_special_value := object_dynamic_class.is_special
								or object_dynamic_class.is_native_array
					end
				end
			end
		ensure
			evaluation_set: expression_evaluation = evl
		end

feature -- Recycling

	reset is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor
			internal_associated_dump_value := Void
			if expression_evaluation /= Void then
				expression_evaluation.reset
			end
			evaluation_requested := False
			refresh_requested := False
		end

feature -- Refresh management

	refresh_requested: BOOLEAN
			-- Has a refresh operation been requested?

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
			-- Effective refresh of current line
		require else
			has_expression: expression_evaluation /= Void
		do
			last_dump_value := Void
			object_address := Void
			object_dynamic_class := Void
			internal_associated_dump_value := Void
			clear_items_stone_properties

			if
				not evaluation_requested --| i.e: evaluate only on `grid_display_compute'
				and then {evl: like expression_evaluation} expression_evaluation
				and then evl.evaluated
			then
				if not evl.error_occurred then
					last_dump_value := evl.value
					if last_dump_value /= Void then
						object_address := last_dump_value.address
					else
						object_address := Void
					end
					object_dynamic_class := evl.dynamic_class
				end
			end
			Precursor
		end

	request_evaluation (v: BOOLEAN) is
			-- Request an evaluation on next grid display computing
			-- (i.e: evaluate `text' only if displayed)
		do
			evaluation_requested := v
		end

	refresh_expression is
			-- Refresh expression
			--| Moved from ES_WATCH_TOOL_PANEL
			--| to reduce dependencies and prepare refactoring
		do
			process_evaluation
		end

feature {NONE} -- Refresh implementation

	process_evaluation is
		local
			evl: like expression_evaluation
		do
			evl := expression_evaluation
			if evl.disabled then
				--| nothing to do
			else
				if debugger_manager.safe_application_is_stopped then
					if is_auto_expression then
						evl.side_effect_forbidden := True
					end
					if evl.evaluated then
						evl.update
					else
						evl.evaluate
					end
				else
					evl.evaluated := False
				end
			end
			refresh
		end

	process_evaluation_request is
		require
			evaluation_requested: evaluation_requested
		do
			evaluation_requested := False
			process_evaluation
		ensure
			evaluation_request_done: not evaluation_requested
		end

	evaluation_requested: BOOLEAN
			-- Is evaluation requested ?

feature -- change properties

	apply_cell_expression_text_properties_on (a_item: EV_GRID_LABEL_ITEM) is
			-- Apply comestic properties on text item `a_item'
		require
			expression_not_void: expression_evaluation /= Void
		local
			evl: like expression_evaluation
		do
			evl := expression_evaluation
			if evl.disabled then
				a_item.set_foreground_color (parent_grid.disabled_row_fg_color)
			elseif evl.error_occurred then
				a_item.set_foreground_color (parent_grid.error_row_fg_color)
			else
				if parent_grid.parent /= Void then
					a_item.set_foreground_color (parent_grid.parent.foreground_color)
				end
			end
		end

feature -- Settings

	set_auto_expression	(b: like is_auto_expression) is
			-- Set `is_auto_expression' value
		do
			is_auto_expression := b
		end

feature -- Properties

	is_auto_expression: BOOLEAN
			-- Is auto expression line ?

	expression: DBG_EXPRESSION
			-- Associated expression.
		do
			Result := expression_evaluation.expression
		end

	expression_evaluation: DBG_EXPRESSION_EVALUATION
			-- Associated expression evaluation

	object_name: STRING_32 is
			-- Name associated to Current's object
		do
			if title /= Void then
				Result := title
			elseif expression.text /= Void then
				Result := expression.text
			else
				Result := object_address
			end
		end

	object_address: STRING
			-- Object Address associated to expression's value

	object_dynamic_class: CLASS_C
			-- Dynamic class associated to expression's value

	object_spec_capacity: INTEGER is
		do
			Result := debugger_manager.object_manager.special_object_capacity_at_address (object_address)
		end

feature -- Query

	has_attributes_values: BOOLEAN is
		do
fixme ("find a smarter way to get a valid value")
			Result := True
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		local
			dmp: DUMP_VALUE
		do
			dmp := last_dump_value
			if dmp /= Void and then dmp.is_type_exception and then dmp.value_exception /= Void then
				Result := dmp.value_exception.sorted_children
			elseif object_address /= Void then
				Result := debugger_manager.object_manager.sorted_attributes_at_address (object_address, object_spec_lower, object_spec_upper)
			end
		end

	sorted_once_routines: LIST [E_FEATURE] is
		do
			if object_dynamic_class /= Void then
				Result := object_dynamic_class.once_routines
			end
		end

	object_value: STRING_32 is
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
			Result := last_dump_value.generating_type_representation (generating_type_evaluation_enabled)
		end

	associated_dump_value: DUMP_VALUE is
		do
			Result := internal_associated_dump_value
			if Result = Void and then object_address /= Void then
				Result := debugger_manager.application.dump_value_at_address_with_class (object_address, object_dynamic_class)
				internal_associated_dump_value := Result
			end
		end

	internal_associated_dump_value: like associated_dump_value

feature -- Graphical changes

	new_cell_expression: ES_OBJECTS_GRID_EXPRESSION_CELL is
		do
			create Result
		end

	set_expression_text (v: STRING_32) is
		require else
			is_attached_to_row: row /= Void
		local
			glab: EV_GRID_LABEL_ITEM
			gedit: ES_OBJECTS_GRID_EXPRESSION_CELL
			l_provider: EB_DEBUGGER_EXPRESSION_COMPLETION_POSSIBILITIES_PROVIDER
			l_class_c: CLASS_C
			l_feature_as: FEATURE_AS
			exp: like expression
		do
			title := v
			if is_read_only then
				glab ?= cell (Col_expression_index)
				if glab = Void then
					glab := new_cell_name
				end
			else
				gedit ?= cell (Col_expression_index)
				if gedit = Void then
					exp := expression
					gedit := new_cell_expression
					gedit.pointer_double_press_actions.extend (agent grid_activate_item_if_row_selected (gedit, False, ?,?,?,?,?,?,?,?))
					gedit.pointer_button_press_actions.extend (agent grid_activate_item_if_row_selected (gedit, True, ?,?,?,?,?,?,?,?))
					gedit.deactivate_actions.extend (agent update_expression_on_deactivate (gedit))

					if exp /= Void and then exp.context.associated_class /= Void then
						l_class_c := exp.context.associated_class
					else
						l_class_c := eb_debugger_manager.current_debugging_class_c
						l_feature_as := eb_debugger_manager.current_debugging_feature_as
					end
					if l_class_c /= Void then
						create l_provider.make (l_class_c, l_feature_as)
						if
							exp = Void or else
							exp.context.associated_class = Void
						then
							l_provider.set_dynamic_context_functions (
											agent eb_debugger_manager.current_debugging_class_c,
											agent eb_debugger_manager.current_debugging_feature_as)
						end
						gedit.set_completion_possibilities_provider (l_provider)
					end
				end
				glab := gedit
			end

			apply_cell_expression_text_properties_on (glab)
			set_cell (Col_expression_index, glab)
			grid_cell_set_text (glab, v)
		end

	update_expression_on_deactivate (a_item: ES_OBJECTS_GRID_EXPRESSION_CELL) is
			-- Update Current data with expression data from `a_item'
		require
			a_item /= Void
			expression_evaluation_attached: expression_evaluation /= Void
		local
			new_text: STRING
			r: EV_GRID_ROW
			evl: like expression_evaluation
			exp: like expression
		do
			r := a_item.row

			new_text := a_item.text
			if new_text /= Void then
				new_text.left_adjust
				evl := expression_evaluation
				exp := evl.expression
				if exp.is_context_object then
						--| i.e: we just change the "title" of the expression
					if exp.name = Void or else not new_text.is_equal (exp.name) then
						exp.set_name (new_text)
						set_title (exp.name)
					end
				else
					if
						new_text.is_empty
					then
						a_item.set_text (exp.text)
					elseif not new_text.is_equal (exp.text) then
						if is_auto_expression then
							set_auto_expression (False)
						end
						exp.set_text (new_text)
						if debugger_manager.safe_application_is_stopped  then
							request_evaluation (True)
						elseif evl /= Void then
							expression_evaluation.evaluated := False
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

	show_error_dialog (txt: STRING_GENERAL) is
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
			edv: EXCEPTION_DEBUG_VALUE
			l_meaning: STRING_32
			exp: like expression
		do
			exp := expression
			if exp /= Void then
				l_meaning := exp.text.twin
				if l_meaning /= Void then
					l_meaning := interface_names.l_error_on_expression (l_meaning)
				end
			end
			create dlg.make
			create edv.make_without_any_value
			edv.set_user_meaning (l_meaning)
			edv.set_user_text (txt)

			dlg.set_exception (edv)
			dlg.set_title_and_label (interface_names.t_watch_tool_error_message, interface_names.l_error_message)
			dlg.set_is_modal (True)
			dlg.show_on_active_window
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
				not is_read_only
				and then abutton = 1
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
			l_error_message: STRING_32
			l_error_tag: STRING_32
			s32: STRING_32
			l_tooltip: STRING_32
			glab: EV_GRID_LABEL_ITEM
			add,typ: STRING
			res: STRING_32
			l_title: STRING_32
			exp: like expression
			evl: like expression_evaluation
		do
			if not compute_grid_display_done and not refresh_requested then
				if evaluation_requested then
					process_evaluation_request
				elseif row /= Void then
					evl := expression_evaluation
					exp := expression
					check
						evl_expression_is_expr: evl.expression =  exp
						evaluation_not_requested: not evaluation_requested
					end
					compute_grid_display_done := True

					create l_tooltip.make (20)

					if exp.is_context_object and then exp.context.associated_address /= Void then
						if exp.name /= Void then
							set_title (exp.name)
						else
							set_title (exp.context.associated_address)
						end
						if title /= Void then
							l_tooltip.append_string (interface_names.l_object_name)
							l_tooltip.append_string (title)
						end
					else
						set_expression_text (exp.text)
						l_tooltip.append_string (interface_names.l_expression_capital + exp.text)
					end
					l_tooltip.append_string (interface_names.l_context_is (exp.context_as_string))

					if evl.disabled then
						set_expression_info (interface_names.l_disabled)
						set_expression_result_address (Void)
						set_expression_result ("")
						set_pixmap (pixmaps.icon_pixmaps.debugger_object_watched_disabled_icon)
					elseif not evl.evaluated then
						set_expression_info (interface_names.l_unevaluated)
						set_expression_result_address (Void)
						set_expression_result ("")
						set_pixmap (Void)
					else
						if evl.error_occurred then
							l_error_message := evl.text_from_error_messages

							if l_error_message /= Void then
								l_tooltip.prepend_string ("%N%N")
								l_tooltip.prepend_string (l_error_message)
							end
							l_tooltip.prepend_string (interface_names.l_error_occurred.as_string_32)
							l_error_tag := expression_evaluation.short_text_from_error_messages
							if l_error_tag /= Void then
								s32 := "["
								s32.append_string (l_error_tag)
								s32.append_string ("] ")
							else
								s32 := ""
							end
							set_expression_info (s32)

							create glab
							grid_cell_set_text (glab, interface_names.l_error_occurred_click)
							glab.pointer_double_press_actions.force_extend (agent show_error_dialog (l_error_message))
							row.set_item (Col_expression_result_index, glab)

							if evl.has_error_exception then
								set_error_pixmap (pixmaps.icon_pixmaps.general_mini_error_icon)
							elseif evl.has_error_expression or evl.has_error_syntax then
								set_error_pixmap (pixmaps.icon_pixmaps.compile_error_icon)
							elseif evl.has_error_evaluation then
								set_error_pixmap (pixmaps.icon_pixmaps.general_mini_error_icon)
							end
							if {l_exception_dump_value: DUMP_VALUE} evl.value then
								if l_exception_dump_value.is_type_exception then
									if evl.has_error_exception then
										l_title := interface_names.l_Exception_object
									end
									attach_debug_value_to_grid_row (grid_extended_new_subrow (row), l_exception_dump_value.value_exception, l_title)
								end
							end
						else
							if last_dump_value /= Void then
								add := object_address
								res := object_value
								typ := object_type_representation
								l_tooltip.append (interface_names.l_type_capital)
								l_tooltip.append (typ)
								l_tooltip.append ("%N")
								l_tooltip.append (interface_names.l_value_capital)
								l_tooltip.append (res)
								l_tooltip.append ("%N")
								if not last_dump_value.is_basic and not last_dump_value.is_void then
									row.ensure_expandable
									set_expand_action (agent on_row_expand)
									set_collapse_action (agent on_row_collapse)
								end
							else
								res := ""
								typ := ""
							end
							set_expression_info (typ)
							set_expression_result_address (add)
							set_expression_result (res)
							set_expression_pixmap (pixmaps.icon_pixmaps.debugger_object_watched_icon)
						end
					end
					if is_auto_expression then
						set_pixmap (pixmaps.mini_pixmaps.watch_auto_icon)
						set_context (interface_names.m_auto_expression_context)
					else
						set_context (exp.context_as_string)
					end

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
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
