indexing
	description: "Interface elements provider"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_INTERFACE_PROVIDER

inherit
	EB_METRIC_SHARED

	QL_SHARED_UNIT

	EB_SHARED_WRITER

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

	EV_SHARED_APPLICATION

	SHARED_TEXT_ITEMS

feature -- Metric menu

	metric_menu: EV_MENU is
			-- Menu cantaining all metrics
		local
			l_metric_table: HASH_TABLE [LIST [EB_METRIC], QL_METRIC_UNIT]
			l_metric_list: LIST [EB_METRIC]
			l_submenu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			l_unit_list: like unit_list
		do
			create Result
			l_metric_table := metric_manager.ordered_metrics (metric_manager.ascending_order, False)
			l_unit_list := unit_list (True)
			from
				l_unit_list.start
			until
				l_unit_list.after
			loop
				l_metric_list := l_metric_table.item (l_unit_list.item.unit)
				if not l_metric_list.is_empty then
					create l_submenu.make_with_text (displayed_name (l_unit_list.item.unit.name))
					l_submenu.set_pixmap (l_unit_list.item.pixmap)
					Result.extend (l_submenu)
					from
						l_metric_list.start
					until
						l_metric_list.after
					loop
						create l_menu_item.make_with_text (l_metric_list.item.name)
						l_menu_item.set_data (l_metric_list.item)
						l_menu_item.set_pixmap (pixmap_from_metric (l_metric_list.item))
						l_submenu.extend (l_menu_item)
						l_metric_list.forth
					end
				end
				l_unit_list.forth
			end
		end

	approximate_width_of_menu (a_menu: EV_MENU): INTEGER is
			-- Approximate width in pixel of `a_menu'
		require
			a_menu_attached: a_menu /= Void
		local
			l_font: EV_FONT
			l_width: INTEGER
		do
			create l_font
			from
				a_menu.start
			until
				a_menu.after
			loop
				l_width := l_font.string_width (a_menu.item.text)
				if a_menu.item.pixmap /= Void then
					l_width := l_width + a_menu.item.pixmap.width
					l_width := l_width + 2
				end
				if l_width > Result then
					Result := l_width
				end
				a_menu.forth
			end
		end

feature -- Names

	metric_names: EB_METRIC_NAMES is
			-- Names used in metric interface
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	unit_list (a_all: BOOLEAN): LIST [TUPLE [unit: QL_METRIC_UNIT; pixmap: EV_PIXMAP]] is
			-- List of units
			-- The first argument in tuple is unit's name, the second is its pixmap.
			-- If `a_all' is True, include compilation and ratio unit.
		local
			l_unit_list: LIST [QL_METRIC_UNIT]
			l_unit: QL_METRIC_UNIT
		do
			create {ARRAYED_LIST [TUPLE [QL_METRIC_UNIT, EV_PIXMAP]]} Result.make (11)

			from
				l_unit_list := preferences.metric_tool_data.unit_order
				l_unit_list.start
			until
				l_unit_list.after
			loop
				l_unit := l_unit_list.item
				if not a_all and then (l_unit = compilation_unit or l_unit = ratio_unit) then
				else
					Result.extend ([l_unit, pixmap_from_unit (l_unit)])
				end
				l_unit_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	unit_pixmap_table: HASH_TABLE [EV_PIXMAP, QL_METRIC_UNIT] is
			-- Table of pixmap for metric unit
			-- Key is unit, value is pixmap for that unit.
		once
			create Result.make (11)
			Result.put (pixmaps.icon_pixmaps.metric_unit_target_icon, target_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_group_icon, group_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_class_icon, class_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_generic_icon, generic_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_feature_icon, feature_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_local_or_argument_icon, argument_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_local_or_argument_icon, local_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_assertion_icon, assertion_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_line_icon, line_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_compilation_icon, compilation_unit)
			Result.put (pixmaps.icon_pixmaps.metric_unit_ratio_icon, ratio_unit)
		ensure
			result_attached: Result /= Void
		end

	displayed_name (a_name: STRING): STRING is
			-- Displayed name for `a_name'
		require
			a_name_attached: a_name /= Void
		local
			l_char: CHARACTER
		do
			Result := a_name.as_lower
			if not a_name.is_empty then
				l_char := Result.item (1)
				Result.put (l_char.as_upper, 1)
			end
		ensure
			result_attached: Result /= Void
		end

	pixmap_from_metric (a_metric: EB_METRIC): EV_PIXMAP is
			-- Pixmap of `a_metric'
		require
			a_metric_attached: a_metric /= Void
		do
			if a_metric.is_predefined then
				if a_metric.is_basic then
					Result := pixmaps.icon_pixmaps.metric_basic_readonly_icon
				elseif a_metric.is_linear then
					Result := pixmaps.icon_pixmaps.metric_linear_readonly_icon
				elseif a_metric.is_ratio then
					Result := pixmaps.icon_pixmaps.metric_ratio_readonly_icon
				end
			else
				if a_metric.is_basic then
					Result := pixmaps.icon_pixmaps.metric_basic_icon
				elseif a_metric.is_linear then
					Result := pixmaps.icon_pixmaps.metric_linear_icon
				elseif a_metric.is_ratio then
					Result := pixmaps.icon_pixmaps.metric_ratio_icon
				end
			end
		ensure
			result_attached: Result /= Void
		end

	pixmap_from_metric_type (a_type: INTEGER): EV_PIXMAP is
			-- Pixmap for metric type `a_type'
		require
			a_type_valid: is_metric_type_valid (a_type)
		do
			if a_type = basic_metric_type then
				Result := pixmaps.icon_pixmaps.metric_basic_icon
			elseif a_type = linear_metric_type then
				Result := pixmaps.icon_pixmaps.metric_linear_icon
			elseif a_type = ratio_metric_type then
				Result := pixmaps.icon_pixmaps.metric_ratio_icon
			end
		ensure
			result_attached: Result /= Void
		end

	name_of_metric_type (a_type: INTEGER): STRING is
			-- Name of metric type `a_type'
		require
			a_type_valid: is_metric_type_valid (a_type)
		do
			if a_type = basic_metric_type then
				Result := metric_names.t_basic
			elseif a_type = linear_metric_type then
				Result := metric_names.t_linear
			elseif a_type = ratio_metric_type then
				Result := metric_names.t_ratio
			end
		ensure
			result_attached: Result /= Void
		end

	pixmap_from_unit (a_unit: QL_METRIC_UNIT): EV_PIXMAP is
			-- Pixmap for metric unit `a_unit'
		require
			a_unit_attached: a_unit /= Void
			a_unit_supported: unit_pixmap_table.has (a_unit)
		do
			Result := unit_pixmap_table.item (a_unit)
		ensure
			result_attached: Result /= Void
		end

	add_editor_token_representation (a_item: QL_ITEM; a_full_signature: BOOLEAN; a_associated_class: BOOLEAN; a_writer: like token_writer) is
			-- Add editor token representation of `a_item' into `a_writer'.
			-- If `a_full_signature' is True, add full signature of `a_item', otherwise, just name.
			-- If `a_associated_class' is True, and `a_item' is a feature item, class name will be prepended:
			-- like LINKED_LIST.first.
			-- {ANY}.out
		require
			a_item_attached: a_item /= Void
			a_writer_attached: a_writer /= Void
		local
			l_group: QL_GROUP
			l_class: QL_CLASS
			l_real_feature: QL_REAL_FEATURE
			l_invariant: QL_INVARIANT
			l_feature: QL_FEATURE
			l_target: QL_TARGET
		do
			if a_item.is_class then
				l_class ?= a_item
				if a_full_signature and then l_class.is_compiled then
					l_class.class_c.append_signature (a_writer, False)
				else
					a_writer.add_class (l_class.class_i)
				end
			elseif a_item.is_feature then
				if a_item.is_real_feature then
					l_real_feature ?= a_item
					l_feature := l_real_feature
				else
					l_invariant ?= a_item
					l_feature := l_invariant
				end
				if a_associated_class then
					a_writer.process_symbol_text (ti_l_curly)
					l_feature.class_c.append_name (a_writer)
					a_writer.process_symbol_text (ti_r_curly)
					a_writer.process_symbol_text (ti_dot)
				end
				if l_feature.is_real_feature then
					if a_full_signature then
						l_feature.e_feature.append_signature (a_writer)
					else
						a_writer.add_sectioned_feature_name (l_real_feature.e_feature)
					end
				else
					a_writer.add_string (l_feature.name)
				end
			elseif a_item.is_group then
				l_group ?= a_item
				a_writer.add_group (l_group.group, l_group.name)
			elseif a_item.is_target then
				l_target ?= a_item
				a_writer.process_target_name_text (l_target.name, l_target.target)
			else
				a_writer.add_string (a_item.name)
			end
		end

	pixmap_for_query_lanaguage_item (a_item: QL_ITEM): EV_PIXMAP is
			-- Pixmap for `a_item'
		require
			a_item_attached: a_item /= Void
		local
			l_group: QL_GROUP
			l_class: QL_CLASS
			l_feature: QL_REAL_FEATURE
		do
			if a_item.is_target then
				Result := pixmaps.icon_pixmaps.metric_unit_target_icon
			elseif a_item.is_group then
				l_group ?= a_item
				Result := pixmap_from_group (l_group.group)
			elseif a_item.is_class then
				l_class ?= a_item
				Result := pixmap_from_class_i (l_class.class_i)
			elseif a_item.is_generic then
				Result := pixmaps.icon_pixmaps.metric_unit_generic_icon
			elseif a_item.is_real_feature then
				l_feature ?= a_item
				Result := pixmap_from_e_feature (l_feature.e_feature)
			elseif a_item.is_invariant_feature then
				Result := pixmaps.icon_pixmaps.class_features_invariant_icon
			elseif a_item.is_argument or a_item.is_local then
				Result := pixmaps.icon_pixmaps.metric_unit_local_or_argument_icon
			elseif a_item.is_assertion then
				Result := pixmaps.icon_pixmaps.metric_unit_assertion_icon
			elseif a_item.is_line then
				Result := pixmaps.icon_pixmaps.metric_unit_line_icon
			end
		ensure
			result_attached: Result /= Void
		end

	metric_value (a_value: DOUBLE; a_percent: BOOLEAN): STRING is
			-- String representation of `a_value'.
			-- If `a_percent' is True, Result is in percentage form.
		local
			l_formatter: FORMAT_DOUBLE
			l_value: DOUBLE
			l_cnt: INTEGER
			l_char: CHARACTER
			done: BOOLEAN
		do
			if a_percent then
				l_value := a_value * 100
				create l_formatter.make (24, 3)
			else
				l_value := a_value
				create l_formatter.make (24, 5)
			end
			Result := l_formatter.formatted (l_value)
			Result.left_adjust
			Result.right_justify
			if l_value = 0.0 then

				Result.wipe_out
				Result.append_character ('0')
			elseif l_value >= 1.0 then
				from
					l_cnt := Result.count
				until
					done
				loop
					l_char := Result.item (l_cnt)
					if l_char = '0' then
						l_cnt := l_cnt - 1
					elseif l_char ='.' then
						l_cnt := l_cnt - 1
						done := True
					else
						done := True
					end
				end
				check l_cnt > 0 end
				Result.keep_head (l_cnt)
			end
			if a_percent then
				Result.append ("%%")
			end
		end

	metric_tooltip (a_metric: EB_METRIC; a_go_to_definition: BOOLEAN): STRING is
			-- Tooltip for `a_metric'.
			-- If `a_go_to_definition' is True, Add "Go to definition" message.
		require
			a_metric_attached: a_metric /= Void
			a_metric_exists: metric_manager.has_metric (a_metric.name)
		local
			l_vadility: EB_METRIC_ERROR
		do
			create Result.make (128)
			l_vadility := metric_manager.metric_vadility (a_metric.name)
			if l_vadility = Void then
				if a_metric.is_predefined or else a_metric.description /= Void then
					if a_metric.description /= Void then
						Result.append (a_metric.description)
					end
				end
			else
				Result.append(l_vadility.out)
			end
			if a_go_to_definition then
				if not Result.is_empty then
					Result.append_character ('%N')
				end
				Result.append (metric_names.f_double_click_to_go_to_definition)
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Dialog

	show_warning_dialog (a_msg: STRING; a_window: EV_WINDOW) is
			-- Show warning dialog to display `a_msg'.
		require
			a_msg_attached: a_msg /= Void
			a_window_attached: a_window /= Void
		local
			l_dialog: EV_WARNING_DIALOG
		do
			create l_dialog.make_with_text (a_msg)
			l_dialog.show_modal_to_window (a_window)
		end

feature -- Actions binding

	attach_non_editable_warning_to_text (a_msg: STRING; a_text: EV_TEXT_COMPONENT; a_window: EV_WINDOW) is
			-- Attach actions to display `a_msg' to `a_text'.
			-- A warning dialog will be displayed when a key is pressed on `a_text'.
		require
			a_msg_attached: a_msg /= Void
			a_text_attached: a_text /= Void
			a_window_attached: a_window /= Void
		do
			a_text.key_press_actions.extend (agent on_key_pressed_on_non_editable_text_field (?, a_text, a_msg, a_window))
		end

feature -- Feedback dialog

	show_feedback_dialog (a_msg: STRING; a_agent: PROCEDURE [ANY, TUPLE]; a_dialog: EV_INFORMATION_DIALOG; a_window: EV_WINDOW) is
			-- Show a feedback information `a_dialog' modal to `a_window' to display information `a_msg'.
			-- `a_agent' will be added into `on_show_actions' of that dialog.
		require
			a_msg_attached: a_msg /= Void
			a_agent_attached: a_agent /= Void
			a_dialog_attached: a_dialog /= Void
			not_a_dialog_is_destroyed: not a_dialog.is_destroyed
			a_window_attached: a_window /= Void
		do
			a_dialog.set_text (a_msg)
			a_dialog.show_actions.wipe_out
			a_dialog.show_actions.extend (agent call_agent_and_then_hide (a_agent, a_dialog))
			a_dialog.show_modal_to_window (a_window)
		end

feature{NONE} -- Implementation

	on_key_pressed_on_non_editable_text_field (a_key: EV_KEY; a_text: EV_TEXT_COMPONENT; a_msg: STRING; a_window: EV_WINDOW) is
			-- Action to be performed when `a_key' is pressed
		require
			a_key_attached: a_key /= Void
			a_text_attached: a_text /= Void
			a_msg_attached: a_msg /= Void
			a_window_attached: a_window /= Void
		local
			l_code: INTEGER
		do
			l_code := a_key.code
			if
				a_key.is_arrow or
				a_key.is_function or
				l_code = {EV_KEY_CONSTANTS}.key_tab or
				l_code = {EV_KEY_CONSTANTS}.key_home or
				l_code = {EV_KEY_CONSTANTS}.key_end or
				l_code = {EV_KEY_CONSTANTS}.key_page_up or
				l_code = {EV_KEY_CONSTANTS}.key_page_down or
				l_code = {EV_KEY_CONSTANTS}.key_ctrl or
				l_code = {EV_KEY_CONSTANTS}.key_alt or
				l_code = {EV_KEY_CONSTANTS}.key_shift or
				l_code = {EV_KEY_CONSTANTS}.key_escape or
				(ev_application.ctrl_pressed and then (l_code = {EV_KEY_CONSTANTS}.key_c))
			then
			elseif (ev_application.ctrl_pressed and then l_code = {EV_KEY_CONSTANTS}.key_a) then
				if a_text.text_length > 0 then
					a_text.select_all
				end
			else
				show_warning_dialog (a_msg, a_window)
			end
		end

	call_agent_and_then_hide (a_agent: PROCEDURE [ANY, TUPLE]; a_dialog: EV_DIALOG) is
			-- Call `a_agent' and then hide `a_dialog'.
		require
			a_agent_attached: a_agent /= Void
			a_dialog_attached: a_dialog /= Void
			not_a_dialog_is_destroyed: not a_dialog.is_destroyed
		do
			a_agent.call ([])
			a_dialog.hide
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
