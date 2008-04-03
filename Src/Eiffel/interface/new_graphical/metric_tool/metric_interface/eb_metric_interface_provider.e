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

	EB_SHARED_WRITER

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION

	SHARED_TEXT_ITEMS

	EB_SHARED_ID_SOLUTION

	EB_DOMAIN_ITEM_UTILITY

	EB_METRIC_XML_CONSTANTS

	EB_METRIC_TOOL_HELPER

	EB_SHARED_WINDOW_MANAGER

feature -- Metric menu

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

	displayed_name (a_name: STRING_GENERAL): STRING_GENERAL is
			-- Displayed name for `a_name'
		require
			a_name_attached: a_name /= Void
		do
			Result := string_general_as_lower (a_name)
			if not a_name.is_empty then
				Result := first_character_as_upper (Result)
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

	name_of_metric_type (a_type: INTEGER): STRING_GENERAL is
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

	metric_tooltip (a_metric: EB_METRIC; a_go_to_definition: BOOLEAN): STRING_32 is
			-- Tooltip for `a_metric'.
			-- If `a_go_to_definition' is True, Add "Go to definition" message.
		require
			a_metric_attached: a_metric /= Void
			a_metric_exists: metric_manager.has_metric (a_metric.name)
		local
			l_validity: EB_METRIC_ERROR
		do
			create Result.make (128)
			l_validity := metric_manager.metric_validity (a_metric.name)
			if l_validity = Void then
				if a_metric.is_predefined or else a_metric.description /= Void then
					if a_metric.description /= Void then
						Result.append (a_metric.description)
					end
				end
			else
				Result.append (l_validity.message_with_location)
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

	show_warning_dialog (a_msg: STRING_GENERAL; a_window: EV_WINDOW) is
			-- Show warning dialog to display `a_msg'.
		require
			a_msg_attached: a_msg /= Void
			a_window_attached: a_window /= Void
		do
			prompts.show_warning_prompt (a_msg, a_window, Void)
		end

feature -- Actions binding

	attach_non_editable_warning_to_text (a_msg: STRING_GENERAL; a_text: EV_TEXT_COMPONENT; a_window: EV_WINDOW) is
			-- Attach actions to display `a_msg' to `a_text'.
			-- A warning dialog will be displayed when a key is pressed on `a_text'.
		require
			a_msg_attached: a_msg /= Void
			a_text_attached: a_text /= Void
			a_window_attached: a_window /= Void
		do
			a_text.key_press_actions.extend (agent on_key_pressed_on_non_editable_text_field (?, a_text, a_msg, a_window))
		end

feature -- Metric editor mode

	readonly_mode: INTEGER is 1
			-- Read only mode
			-- This is used for browsing predefined metrics

	new_mode: INTEGER is 2
			-- New mode
			-- This is used for define new metrics

	edit_mode: INTEGER is 3
			-- Edit mode
			-- This is used for editing existing metrics

	is_mode_valid (a_mode: INTEGER): BOOLEAN is
			-- Is `a_mode' valid?
		do
			Result := a_mode = readonly_mode or a_mode = new_mode or a_mode = edit_mode
		ensure
			good_result: Result implies (a_mode = readonly_mode or a_mode = new_mode or a_mode = edit_mode)
		end

feature -- Layout

	center_pixmap_layout (a_item: EV_GRID_LABEL_ITEM; a_layout: EV_GRID_LABEL_ITEM_LAYOUT) is
			-- Layout to align pixmap of `a_item' in center
		require
			a_item_attached: a_item /= Void
			a_layout_attached: a_layout /= Void
		local
			l_pixmap: EV_PIXMAP
		do
			l_pixmap := pixmaps.icon_pixmaps.general_tick_icon
			a_layout.set_pixmap_x ((a_item.width - l_pixmap.width) // 2)
			a_layout.set_pixmap_y ((a_item.height - l_pixmap.height) // 2)
		end

feature -- Domain dialog

	plain_domain_setup_dialog: EB_METRIC_GRID_PLAIN_DOMAIN_DIALOG is
			-- Dialog to setup a metric domain
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	client_domain_setup_dialog: EB_METRIC_GRID_SUPPLIER_CLIENT_CLASS_DIALOG is
			-- Dialog to setup a client domain
		once
			create Result
			Result.enable_for_client_class
		ensure
			result_attached: Result /= Void
		end

	supplier_domain_setup_dialog: EB_METRIC_GRID_SUPPLIER_CLIENT_CLASS_DIALOG is
			-- Dialog to setup a supplier domain
		once
			create Result
			Result.enable_for_supplier_class
		ensure
			result_attached: Result /= Void
		end

	caller_callee_domain_setup_dialog: EB_METRIC_GRID_CALLER_CALLEE_DIALOG is
			-- Dialog to setup caller/callee domain
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	value_criterion_dialog: EB_METRIC_VALUE_CRITERION_DIALOG is
			-- Dialog to setup value criterion
		once
			create Result.make (True, True, True)
			Result.set_width (600)
		ensure
			result_attached: Result /= Void
		end

	value_tester_dialog: EB_METRIC_VALUE_CRITERION_DIALOG is
			-- Dialog to setup value tester for archive node
		once
			create Result.make (True, False, True)
			Result.set_width (300)
			Result.value_tester.set_metric_value_retriever_dialog_function (agent archive_metric_value_retriever_dialog)
		ensure
			result_attached: Result /= Void
		end

	metric_value_retriever_dialog: EB_METRIC_VALUE_CRITERION_DIALOG is
			-- Dialog to setup metric value retriever
		once
			create Result.make (False, True, False)
			Result.set_title (metric_names.l_setup_metric_value_retriever)
		ensure
			result_attached: Result /= Void
		end

	archive_metric_value_retriever_dialog: EB_METRIC_VALUE_CRITERION_DIALOG is
			-- Dialog to setup metric value retriever
		once
			create Result.make (False, True, False)
			Result.set_title (metric_names.l_setup_metric_value_retriever)
			Result.domain_selector.setup_delayed_domain_item_buttons (True, True, False)
		ensure
			result_attached: Result /= Void
		end

feature -- Color

	red_color: EV_COLOR is
			-- Red color
		once
			Result := (create {EV_STOCK_COLORS}).red
		ensure
			result_attached: Result /= Void
		end

	black_color: EV_COLOR is
			-- Black color
		once
			Result := (create {EV_STOCK_COLORS}).black
		ensure
			result_attached: Result /= Void
		end

feature -- Grid Support

	new_grid_support (a_grid: ES_GRID): EB_EDITOR_TOKEN_GRID_SUPPORT is
			-- New grid support for `a_grid'.
		require
			a_grid_attached: a_grid /= Void
		do
			create Result.make_with_grid (a_grid)
		ensure
			result_attached: Result /= Void
		end

feature -- Domain item

	new_current_application_target_domain_item: EB_METRIC_DOMAIN_ITEM is
			-- New current application target domain item
		do
			create {EB_METRIC_TARGET_DOMAIN_ITEM}Result.make ("")
		ensure
			result_attached: Result /= Void
		end

	new_input_domain_item: EB_METRIC_DOMAIN_ITEM is
			-- New input domain item
		do
			create {EB_METRIC_DELAYED_DOMAIN_ITEM}Result.make ("")
		ensure
			result_attached: Result /= Void
		end

	new_delayed_domain_item: EB_METRIC_DOMAIN_ITEM is
			-- New delayed domain item
		do
			create {EB_METRIC_DELAYED_DOMAIN_ITEM}Result.make (n_delayed_domain_id)
		ensure
			result_attached: Result /= Void
		end

feature -- Pixmap

	ellipsis_pixmap: EV_PIXMAP is
			-- Icon for ellipsis
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (8, 2)
			Result.fill_rectangle (0, 0, 2, 2)
			Result.fill_rectangle (3, 0, 2, 2)
			Result.fill_rectangle (6, 0, 2, 2)

			create l_mask.make_with_size (8, 2)
			l_mask.fill_rectangle (0, 0, 2, 2)
			l_mask.fill_rectangle (3, 0, 2, 2)
			l_mask.fill_rectangle (6, 0, 2, 2)

			Result.set_mask (l_mask)
		ensure
			Result_set: Result /= Void
		end

feature{NONE} -- Font

	bold_font: EV_FONT is
			-- Bold font
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		ensure
			result_attached: Result /= Void
		end

feature -- Pick and drop

	drop_class (st: CLASSI_STONE; a_metric_tool: ES_METRICS_TOOL_PANEL) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
			a_metric_tool_attached: a_metric_tool /= Void
		local
			conv_fst: FEATURE_STONE
		do
			conv_fst ?= st
			if conv_fst = Void then
				a_metric_tool.develop_window.tools.class_tool.set_stone (st)
				a_metric_tool.develop_window.tools.class_tool.show
				a_metric_tool.develop_window.tools.class_tool.content.set_focus
				a_metric_tool.develop_window.tools.class_tool.set_focus
			else
				-- The stone is already dropped through `drop_feature'.
			end
		end

	drop_feature (st: FEATURE_STONE; a_metric_tool: ES_METRICS_TOOL_PANEL) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
			a_metric_tool_attached: a_metric_tool /= Void
		do
			a_metric_tool.develop_window.tools.features_relation_tool.set_stone (st)
			a_metric_tool.develop_window.tools.features_relation_tool.show
			a_metric_tool.develop_window.tools.features_relation_tool.content.set_focus
			a_metric_tool.develop_window.tools.features_relation_tool.set_focus
		end

	drop_cluster (st: CLUSTER_STONE; a_metric_tool: ES_METRICS_TOOL_PANEL) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
			a_metric_tool_attached: a_metric_tool /= Void
		do
			a_metric_tool.develop_window.tools.launch_stone (st)
		end

	extend_drop_actions (a_action_holder: EV_PICK_AND_DROPABLE_ACTION_SEQUENCES; a_metric_tool: ES_METRICS_TOOL_PANEL) is
			-- Register PnD related actions `drop_feature', `drop_class' and `drop_cluster' into `a_action_holder'.
		require
			a_action_holder_attached: a_action_holder /= Void
			a_metric_tool_attached: a_metric_tool /= Void
		do
			a_action_holder.drop_actions.extend (agent drop_class (?, a_metric_tool))
			a_action_holder.drop_actions.extend (agent drop_feature (?, a_metric_tool))
			a_action_holder.drop_actions.extend (agent drop_cluster (?, a_metric_tool))
		end

	tool_drop_actions (a_metric_tool: ES_METRICS_TOOL_PANEL): EV_PND_ACTION_SEQUENCE is
			-- Drop actions
		do
			create Result
			Result.extend (agent drop_class (?, a_metric_tool))
			Result.extend (agent drop_feature (?, a_metric_tool))
			Result.extend (agent drop_cluster (?, a_metric_tool))
		end

	append_drop_actions (a_action_holders: ARRAY [EV_PICK_AND_DROPABLE_ACTION_SEQUENCES]; a_metric_tool: ES_METRICS_TOOL_PANEL) is
			-- Register PnD related actions `drop_feature', `drop_class' and `drop_cluster' into every item in `a_action_holders'.
		require
			a_action_holders_attached: a_action_holders /= Void
			a_action_holders_valid: not a_action_holders.has (Void)
		do
			a_action_holders.do_all (agent extend_drop_actions (?, a_metric_tool))
		end

feature{NONE} -- Implementation

	on_key_pressed_on_non_editable_text_field (a_key: EV_KEY; a_text: EV_TEXT_COMPONENT; a_msg: STRING_GENERAL; a_window: EV_WINDOW) is
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

	activate_grid_item (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER; a_grid_item: EV_GRID_ITEM) is
			-- Action to be performed to activate `a_grid_item'
		require
			a_grid_item_attached: a_grid_item /= Void
		do
			if a_grid_item.is_parented and then button = {EV_POINTER_CONSTANTS}.left then
				a_grid_item.activate
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

