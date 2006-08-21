indexing
	description: "Panels used in metric tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_PANEL

inherit
	EB_METRIC_SHARED

	QL_OBSERVER

	EV_SHARED_APPLICATION

	EB_METRIC_INTERFACE_PROVIDER

feature -- Access

	metric_tool: EB_METRIC_TOOL
			-- Metric tool panel

feature -- Status report

	is_up_to_date: BOOLEAN
			-- Is metrics in `metric_selector' up-to-date?

feature -- Basic operations

	synchronize_when_compile_start is
			-- Synchronize when Eiffel compilation starts.
		deferred
		end

	synchronize_when_compile_stop is
			-- Synchronize when Eiffel compilation stops.
		deferred
		end

feature -- Actions

	on_select is
			-- Action to be performed when current panel is selected
		deferred
		end

	on_process_gui (a_item: QL_ITEM) is
			-- Action to be performed to process gui events
		do
			process_events_and_idle
			if a_item /= Void then
				display_status_message (metric_names.e_evaluating + a_item.path)
			end
		end

	drop_class (st: CLASSI_STONE) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
		local
			conv_fst: FEATURE_STONE
		do
			conv_fst ?= st
			if conv_fst = Void then
				metric_tool.context_tool.launch_stone (st)
				metric_tool.context_tool.class_view.pop_default_formatter
			else
				-- The stone is already dropped through `drop_feature'.
			end
		end

	drop_feature (st: FEATURE_STONE) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
		do
			metric_tool.context_tool.launch_stone (st)
			metric_tool.context_tool.feature_view.pop_default_formatter
		end

	drop_cluster (st: CLUSTER_STONE) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
		do
			metric_tool.context_tool.launch_stone (st)
		end


feature{NONE} -- Implementation

	display_status_message (a_msg: STRING) is
			-- Display `a_msg' in message bar.
		require
			a_msg_attached: a_msg /= Void
		do
			metric_tool.development_window.status_bar.display_message (a_msg)
		end

	display_error_message is
			-- Display last error message in `metric_manager'.
		do
			metric_tool.display_error_message
		end

invariant
	metric_tool_attached: metric_tool /= Void

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
