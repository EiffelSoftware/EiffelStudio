indexing
	description: "Helper class to manage metric loading and metric validity checking for tools"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TOOL_HELPER

inherit
	EB_SHARED_MANAGERS

	SHARED_WORKBENCH

	EB_CONSTANTS

	EB_METRIC_SHARED

	EB_DOMAIN_ITEM_UTILITY

	EVS_GRID_TWO_WAY_SORTING_ORDER

	QL_SHARED_UNIT

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

feature -- Access

	show_error_message (a_error_agent: FUNCTION [ANY, TUPLE, EB_METRIC_ERROR]; a_clear_error_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW) is
			-- Show error message retrieved from `a_error_agent' if any in `a_window'.
			-- And then clear error by calling `a_clear_error_agent'.
		require
			a_error_agent_attached: a_error_agent /= Void
			a_clear_error_agent_attached: a_clear_error_agent /= Void
		local
			l_error: EB_METRIC_ERROR
		do
			l_error := a_error_agent.item (Void)
			if l_error /= Void then
				prompts.show_error_prompt (l_error.message_with_location, a_window, Void)
				a_clear_error_agent.call (Void)
			end
		end

	show_feedback_dialog (a_msg: STRING_GENERAL; a_agent: PROCEDURE [ANY, TUPLE]; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Display `a_msg' in status bar of `a_window'
			-- And then call `a_agent'.
		require
			a_msg_attached: a_msg /= Void
			a_agent_attached: a_agent /= Void
		do
			a_window.status_bar.display_message (a_msg)
			a_agent.call (Void)
			a_window.status_bar.display_message ("")
		end

	metric_order_tester (a_metric, b_metric: EB_METRIC; a_sorting_order: INTEGER): BOOLEAN is
			-- Tester to decide the order of `a_metric' and `b_metric' according to `a_sorting_order'
		require
			a_metric_attached: a_metric /= Void
			b_metric_attached: b_metric /= Void
		local
			l_metric_a_valid: BOOLEAN
			l_metric_b_valid: BOOLEAN
			l_manager: EB_METRIC_MANAGER
		do
			if a_sorting_order = topology_order then
				l_manager := metric_manager
				l_metric_a_valid := l_manager.is_metric_calculatable (a_metric.name)
				l_metric_b_valid := l_manager.is_metric_calculatable (b_metric.name)
				if l_metric_a_valid and then not l_metric_b_valid then
					Result := True
				elseif not l_metric_a_valid and then l_metric_b_valid then
				else
					Result := a_metric.name.as_lower < b_metric.name.as_lower
				end
			else
				if a_sorting_order = ascending_order then
					Result := a_metric.name.as_lower < b_metric.name.as_lower
				elseif a_sorting_order = descending_order then
					Result := a_metric.name.as_lower > b_metric.name.as_lower
				end
			end
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
			l_metric_table := metric_manager.ordered_metrics (agent metric_order_tester (?, ?, ascending_order) , False)
			l_unit_list := unit_list (True)
			from
				l_unit_list.start
			until
				l_unit_list.after
			loop
				l_metric_list := l_metric_table.item (l_unit_list.item.unit)
				if not l_metric_list.is_empty then
					create l_submenu.make_with_text (unit_name_table.item (l_unit_list.item.unit))
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

feature -- Domain item

	metric_domain_item_from_stone (a_stone: STONE): EB_METRIC_DOMAIN_ITEM is
			-- Metric domain item from `a_stone'
		require
			a_stone_attached: a_stone /= Void
		local
			l_domain_item: EB_DOMAIN_ITEM
			l_target_stone: TARGET_STONE
		do
			l_domain_item := domain_item_from_stone (a_stone)
			if l_domain_item /= Void then
				if l_domain_item.is_feature_item then
					create {EB_METRIC_FEATURE_DOMAIN_ITEM} Result.make (l_domain_item.id)
				elseif l_domain_item.is_class_item then
					create {EB_METRIC_CLASS_DOMAIN_ITEM} Result.make (l_domain_item.id)
				elseif l_domain_item.is_folder_item then
					create {EB_METRIC_FOLDER_DOMAIN_ITEM} Result.make (l_domain_item.id)
				elseif l_domain_item.is_group_item then
					create {EB_METRIC_GROUP_DOMAIN_ITEM} Result.make (l_domain_item.id)
				elseif l_domain_item.is_target_item then
					l_target_stone ?= a_stone
					check l_target_stone /= Void end
					if l_target_stone.is_delayed_application_target then
						create {EB_METRIC_TARGET_DOMAIN_ITEM} Result.make ("")
					else
						create {EB_METRIC_TARGET_DOMAIN_ITEM} Result.make (l_domain_item.id)
					end
				end
				if l_domain_item.library_target_uuid /= Void then
					Result.set_library_target_uuid (l_domain_item.library_target_uuid)
				end
			end
		end

	unit_name_table: HASH_TABLE [STRING_GENERAL, QL_METRIC_UNIT] is
			-- Interface names for metric unit
		once
			create Result.make (12)
			Result.put (metric_names.l_target_unit, target_unit)
			Result.put (metric_names.l_group_unit, group_unit)
			Result.put (metric_names.l_class_unit, class_unit)
			Result.put (metric_names.l_feature_unit, feature_unit)
			Result.put (metric_names.l_generic_unit, generic_unit)
			Result.put (metric_names.l_assertion_unit, assertion_unit)
			Result.put (metric_names.l_local_unit, local_unit)
			Result.put (metric_names.l_line_unit, line_unit)
			Result.put (metric_names.l_compilation_unit, compilation_unit)
			Result.put (metric_names.l_ratio_unit, ratio_unit)
			Result.put (metric_names.l_argument_unit, argument_unit)
			Result.put ("", no_unit)
	ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_metric_validation_checked: CELL [BOOLEAN] is
			-- Is validation of metrica checked?
		once
			create Result.put (False)
		ensure
			result_attached: Result /= Void
		end

feature -- Basic Operations

	load_metrics (a_force: BOOLEAN; a_msg: STRING_GENERAL; a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Load metrics is they are not already loaded.
			-- If `a_force' is True, load metrics even thought they are already loaded.
			-- When loading metrics, `a_msg' will be displayed in a dialog in `a_develop_window'.			
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
			a_develop_window_attached: a_develop_window /= Void
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				if a_force or else not metric_manager.is_metric_loaded then
					show_feedback_dialog (a_msg, agent metric_manager.load_metrics, a_develop_window)
					check_metric_validation (a_develop_window)
				end
			end
		end

	check_metric_validation (a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Check metric validation and display status message in `a_develop_window'.
		require
			a_develop_window_attached: a_develop_window /= Void
		do
			a_develop_window.window_manager.display_message (metric_names.t_checking_metric_vadility)
			metric_manager.check_validation (True)
			is_metric_validation_checked.put (True)
			a_develop_window.window_manager.display_message ("")
		end

feature{NONE} -- Implementation

	call_agent_and_then_hide (a_agent: PROCEDURE [ANY, TUPLE]; a_dialog: EV_DIALOG) is
			-- Call `a_agent' and then hide `a_dialog'.
		require
			a_agent_attached: a_agent /= Void
			a_dialog_attached: a_dialog /= Void
			not_a_dialog_is_destroyed: not a_dialog.is_destroyed
		do
			a_agent.call (Void)
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
