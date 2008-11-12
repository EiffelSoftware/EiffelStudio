indexing
	description: "Editor to edit or browser a metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_EDITOR

inherit
	EB_METRIC_INTERFACE_PROVIDER

	EB_METRIC_TOOL_INTERFACE

	EB_METRIC_COMPONENT

	EB_RECYCLABLE

feature{NONE} -- Initialization

	setup_editor is
			-- Setup current editor.
		do
			name_area.name_text.change_actions.extend (agent on_definition_change)
			name_area.description_text.change_actions.extend (agent on_description_change)
		end

feature -- Basic operation

	initialize_editor (a_metric: like metric; a_mode: INTEGER; a_unit: QL_METRIC_UNIT) is
			-- Initialize current editor using `a_metric', `mode' with `a_mode' and `unit'with `a_unit'.
		require
			a_unit_attached: a_unit /= Void
			a_mode_valid: is_mode_valid (a_mode)
		do
			is_editor_initialized := True
			set_unit (a_unit)
			set_mode (a_mode)
			load_metric (a_metric, a_mode = readonly_mode)
		ensure
			initialized: is_editor_initialized
			unit_set: unit = a_unit
			mode_set: mode = a_mode
		end

feature -- Setting

	set_mode (a_mode: INTEGER) is
			-- Set `mode' with `a_mode'.
		require
			a_mode_valid: is_mode_valid (a_mode)
		deferred
		ensure
			mode_set: mode = a_mode
		end

	set_unit (a_unit: like unit) is
			-- Set `unit' with `a_unit'.
		require
			a_unit_attached: a_unit /= Void
		do
			unit := a_unit
		ensure
			unit_set: unit = a_unit
		end

	load_metric (a_metric: like metric; a_read_only: BOOLEAN) is
			-- Load metric in current editor.
			-- If `a_read_only' is True, enable read only mode.
		do
			is_loading_metric := True
			if a_metric /= Void then
				original_metric_name := a_metric.name.twin
			else
				original_metric_name := Void
			end
			name_area.set_type (metric_type)
			name_area.set_unit (unit)
			load_metric_name_and_description (a_metric, a_read_only)
			load_metric_definition (a_metric)
			is_definition_changed := False
			is_description_changed := False
			is_loading_metric := False
			if mode = readonly_mode then
				disable_edit
			else
				enable_edit
			end
			change_actions.block
			on_definition_change
			change_actions.resume
		end

	enable_edit is
			-- Enable edit in current editor.
		deferred
		end

	disable_edit is
			-- Disable edit in current editor.
		deferred
		end

	check_validity_for_metric is
			-- Check validity for `metric'.
		local
			l_validity: EB_METRIC_ERROR
			l_metric: like metric
		do
			l_metric := metric
			if
				not l_metric.name.is_empty and then (
				original_metric_name = Void or else
				(not l_metric.name.is_case_insensitive_equal (original_metric_name)))
			then
				if metric_manager.has_metric (l_metric.name) then
					create l_validity.make (metric_names.err_duplicated_metric_name (l_metric.name))
				end
			end
			if l_validity = Void then
				metric_validity_checker.check_metric_validity (l_metric, True)
				l_validity := metric_validity_checker.error_table.item (l_metric.name)
			end
			status_area.set_validity (l_validity)
		end

feature -- Access

	metric: EB_METRIC is
			-- Metric in current editor
		deferred
		ensure
			result_attached: Result /= Void
		end

	metric_type: INTEGER is
			-- Type of metric in current editor
		deferred
		ensure
			good_result: is_metric_type_valid (Result)
		end

	unit: QL_METRIC_UNIT
			-- Unit of metric in current editor

	widget: EV_WIDGET is
			-- Widget of current editor
		local
			l_ver: EV_VERTICAL_BOX
		do
			if widget_internal = Void then
				create l_ver
				l_ver.set_padding (10)
				l_ver.extend (name_area)
				l_ver.disable_item_expand (name_area)
				l_ver.extend (definition_area_widget)
				l_ver.extend (status_area)
				l_ver.disable_item_expand (status_area)
				widget_internal := l_ver
			end
			Result := widget_internal
		end

	definition_area_widget: EV_WIDGET is
			-- Definition area
		deferred
		ensure
			result_attached: Result /= Void
		end

	expression_generator: EB_METRIC_EXPRESSION_GENERATOR is
			-- Expression generator
		do
			if expression_generator_internal = Void then
				create expression_generator_internal.make (rich_text_output)
			end
			Result := expression_generator_internal
		ensure
			result_attached: Result /= Void
		end

	rich_text_output: EB_METRIC_EXPRESSION_RICH_TEXT_OUTPUT is
			-- Output from `expression_generator' in rich text format
		do
			if rich_text_output_internal = Void then
				create rich_text_output_internal.make
			end
			Result := rich_text_output_internal
		ensure
			result_attached: Result /= Void
		end

	name_area: EB_METRIC_NAME_AREA is
			-- Name and description area
		do
			if name_area_internal = Void then
				create name_area_internal.make (metric_tool, metric_panel)
			end
			Result := name_area_internal
		end

	status_area: EB_METRIC_STATUS_AREA is
			-- Area to display current metric status information
		do
			if status_area_internal = Void then
				create status_area_internal.make (metric_tool)
			end
			Result := status_area_internal
		ensure
			result_attached: Result /= Void
		end

	original_metric_name: STRING
			-- Original loaded metric name
			-- Void for new metric

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `is_definition_changes' or `is_description_changes'

feature -- Actions

	on_definition_change is
			-- Action to be performed when definition of metric changes
		do
			if not is_loading_metric then
				check_validity_for_metric
				on_metric_change
				is_definition_changed := True
			end
		ensure
			metric_definition_changed: not is_loading_metric implies is_definition_changed
		end

	on_description_change is
			-- Action to be performed when description of metric changes
		do
			if not is_loading_metric then
				on_metric_change
				is_description_changed := True
			end
		ensure
			metric_description_changed: not is_loading_metric implies is_description_changed
		end

	on_metric_change is
			-- Action to be performed when metric changes (Either its definition or its description)
		do
			change_actions.call (Void)
		end

feature -- Access

	mode: INTEGER
			-- Mode of current editor

feature -- Status report

	is_definition_changed: BOOLEAN
			-- Is metric definition changed?

	is_description_changed: BOOLEAN
			-- Is metric description changed?

	is_metric_changed: BOOLEAN is
			-- Is metric changed?
		do
			Result := is_definition_changed or is_description_changed
		end

	is_criterion_definable: BOOLEAN is
			-- Is criterion of Current definable?
		do
			Result := unit.scope /= Void
		end

	is_loading_metric: BOOLEAN
			-- Is loading metric?

	is_editor_initialized: BOOLEAN
			-- Is Current metric editor initialized?

feature{NONE} -- Implementation

	name_area_internal: like name_area
			-- Implementation of `name_area'

	status_area_internal: like status_area
			-- Implementation of `status_area'

	widget_internal: like widget
			-- Implementation of `widget'

	load_metric_definition (a_metric: like metric) is
			-- Load `a_metric' in current editor.
		deferred
		end

	load_metric_name_and_description (a_metric: like metric; a_read_only: BOOLEAN) is
			-- Load name and description of `a_metric' in `name_area'.
			-- If `a_read_only' is True, disable edit in these two fields.
		do
			if a_read_only then
				name_area.enable_read_only_mode
			else
				name_area.disable_read_only_mode
			end
			if a_metric /= Void then
				name_area.set_name (a_metric.name.twin)
				if a_metric.description /= Void then
					name_area.set_description (a_metric.description.twin)
				else
					name_area.set_description ("")
				end
			else
				name_area.set_name (metric_manager.next_metric_name_with_unit (unit))
				name_area.set_description ("")
			end
		end

	expression_generator_internal: like expression_generator
			-- Implementation of `expression_generator'

	rich_text_output_internal: like rich_text_output
			-- Implementation of `rich_text_output'

invariant
	mode_valid: is_mode_valid (mode)
	unit_attached: unit /= Void
	metric_type_attached: metric_type /= 0
	expression_generator_attached: expression_generator /= Void
	change_actions_attached: change_actions /= Void

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
