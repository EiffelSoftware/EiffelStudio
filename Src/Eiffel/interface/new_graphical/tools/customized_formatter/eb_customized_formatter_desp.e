note
	description: "[
				Customized formatter discriptor
				This class contains information of a customized formatter.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_DESP

inherit
	HASHABLE

create
	make

feature{NONE} -- Initialization

	make (a_name: like name)
			-- Initialize Current.
		require
			a_name_attached: a_name /= Void
		do
			set_name (a_name)
			create tools.make (2)
			create sorting_orders.make (2)
			set_header ("")
			set_temp_header ("")
			set_pixmap_location ("")
			set_tooltip ("")
			set_metric_name ("")
		end

feature -- Access

	name: STRING
			-- Name of Current formatter

	header: STRING
			-- Name of Current formatter

	temp_header: STRING
			-- Name of Current formatter

	tooltip: STRING
			-- Name of Current formatter

	pixmap_location: STRING
			-- Name of Current formatter

	metric_name: STRING
			-- Name of Current formatter

	new_formatter (a_tool: STRING; a_manager: EB_STONABLE): EB_CUSTOMIZED_FORMATTER
			-- New customized formatter which is going to be used in tool named `a_tool'.
		require
			a_tool_attached: a_tool /= Void
			a_tool_valid: has_tool (a_tool)
		do
			create Result.make (a_manager, name, header, temp_header, name, metric_name, tools.item (a_tool), pixmap_location, tooltip)
			Result.set_descriptor (Current)
			Result.set_tool (a_tool)
		ensure
			result_attached: Result /= Void
		end

	tools: HASH_TABLE [STRING, STRING]
			-- Table of tools to display the customized formatter.
			-- [viewer_name, tool_name]
			-- `tool_name' is the tool in which the customized formatter is displayed,
			-- `viewer_name' is the displayer name to decide how is the result of the customized formatter displayed.
			-- A customized formatter can be displayed in several tools.

	sorting_orders: HASH_TABLE [STRING, STRING]
			-- Stored sorting orders for formatters
			-- [sorting_order, tool_name]
			-- `tool_name' is the tool in which the customized formatter is displayed,
			-- `sorting_order' is sorting orders for that formatter which is to be displayed in that tool

	hash_code: INTEGER
			-- Hash code value
		do
			if hash_code_internal = 0 then
				 hash_code_internal := name.hash_code
			end
			Result := hash_code_internal
		end

feature -- Status report

	is_filter_enabled: BOOLEAN
			-- Is filter enabled when metric is calculated?

	has_tool (a_tool_name: STRING): BOOLEAN
			-- Can Current formatter be used in tool named `a_tool_name'?
		require
			a_tool_name_attached: a_tool_name /= Void
		do
			Result := tools.has_key (a_tool_name)
		end

	is_global_scope: BOOLEAN
			-- Is Current formatter of global scope?
			-- Global scope means that Current formatter is displayed per EiffelStduio as oppose to per target scope.

	is_target_scope: BOOLEAN
			-- Is Current formatter of target scope?
			-- For more information of formatter scope, see `is_global_scope'.
		do
			Result := not is_global_scope
		ensure
			good_result: Result = not is_global_scope
		end

feature -- Setting

	set_name (a_name: like name)
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			name := a_name.twin
		end

	set_header (a_header: like header)
			-- Set `header' with `a_header'.
		require
			a_header_attached: a_header /= Void
		do
			header := a_header.twin
		end

	set_temp_header (a_temp_header: like temp_header)
			-- Set `temp_header' with `a_temp_header'.
		require
			a_temp_header_attached: a_temp_header /= Void
		do
			temp_header := a_temp_header.twin
		end

	set_tooltip (a_tooltip: like tooltip)
			-- Set `tooltip' with `a_tooltip'.
		require
			a_tooltip_attached: a_tooltip /= Void
		do
			tooltip := a_tooltip.twin
		end

	set_pixmap_location (a_pixmap_location: like pixmap_location)
			-- Set `pixmap_location' with `a_pixmap_location'.
		require
			a_pixmap_location_attached: a_pixmap_location /= Void
		do
			pixmap_location := a_pixmap_location.twin
		end

	set_metric_name (a_metric_name: like metric_name)
			-- Set `metric_name' with `a_metric_name'.
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			metric_name := a_metric_name.twin
		end

	set_is_filter_enabled (b: BOOLEAN)
			-- Set `is_filter_enabled' with `b'.
		do
			is_filter_enabled := b
		ensure
			is_filter_enabled_set: is_filter_enabled = b
		end

	enable_global_scope
			-- Enable global scope of Current formatter
			-- For more information about formatter scope, see `is_global_scope'.
		do
			is_global_scope := True
		ensure
			global_scope_set: is_global_scope
		end

	enable_target_scope
			-- Enable target scope of Current formatter
			-- For more information about formatter scope, see `is_global_scope'.
		do
			is_global_scope := False
		ensure
			target_scope_set: is_target_scope
		end

	wipe_out_tools
			-- Wipe out `tools' and `sorting_orders'.
		do
			tools.wipe_out
			sorting_orders.wipe_out
		end

	extend_tool (a_tool_name: STRING; a_viewer_name: STRING; a_sorting_order: STRING)
			-- Add a tool named `a_tool_name', a viewer named `a_viewer_name' and sorting order `a_sorting_order' in `tools'.
		require
			a_tool_name_attached: a_tool_name /= Void
			a_viewer_name_attached: a_viewer_name /= Void
			a_sorting_order_attached: a_sorting_order /= Void
		do
			tools.force (a_viewer_name, a_tool_name)
			sorting_orders.force (a_sorting_order, a_tool_name)
		end

	extend_sorting_order (a_tool_name: STRING; a_sorting_order: STRING)
			-- Add a tool named `a_tool_name' and sorting order `a_sorting_order' in `sorting_orders'.
		require
			a_tool_name_attached: a_tool_name /= Void
			a_sorting_order_attached: a_sorting_order /= Void
		do
			sorting_orders.force (a_sorting_order, a_tool_name)
		end

feature{NONE} -- Implementation

	hash_code_internal: INTEGER
			-- Internal hash code

invariant
	name_attached: name /= Void
	tools_attached: tools /= Void
	sorting_orders_attached: sorting_orders /= Void

note
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
