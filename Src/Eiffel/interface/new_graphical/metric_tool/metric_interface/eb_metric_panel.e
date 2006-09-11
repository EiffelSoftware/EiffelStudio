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

	EB_METRIC_TOOL_INTERFACE

feature -- Status report

	is_up_to_date: BOOLEAN
			-- Is current panel up-to-date?

	is_valid_update_request (a_request: INTEGER): BOOLEAN is
			-- Is `a_request' a valid update request?
		do
			Result :=
				a_request = compilation_start_update_request or
				a_request = compilation_stop_update_request or
				a_request = load_metric_update_request
		end

	is_selected: BOOLEAN
			-- Is current panel selected?

feature -- Access

	last_update_request: INTEGER
			-- Type of last update request
			-- See `compilation_start_update_request' and `compilation_stop_update_request' for more information.

	compilation_start_update_request: INTEGER is 1
			-- Update request when Eiffel compilation starts

	compilation_stop_update_request: INTEGER is 2
			-- Update request when Eiffel compilation stops

	load_metric_update_request: INTEGER is 3
			-- Update request when metric definition is loaded

feature -- Basic operations

	synchronize_when_compile_start is
			-- Synchronize when Eiffel compilation starts.
		deferred
		end

	synchronize_when_compile_stop is
			-- Synchronize when Eiffel compilation stops.
		deferred
		end

	set_last_update_request (a_request: INTEGER) is
			-- Set `last_update_request' with with `a_request'.
		require
			a_request_valid: is_valid_update_request (a_request)
		do
			last_update_request := a_request
		ensure
			last_update_request_set: last_update_request = a_request
		end

	set_is_up_to_date (b: BOOLEAN) is
			-- Set `is_up_to_date' with `b'.
		do
			is_up_to_date := b
		ensure
			is_up_to_date_set: is_up_to_date = b
		end

	set_is_selected (b: BOOLEAN) is
			-- Set `is_selected' with `b'.
		do
			is_selected := b
		ensure
			is_selected_set: is_selected = b
		end

	set_stone (a_stone: STONE) is
			-- Notify that `a_stone' has been dropped on Current.
		deferred
		end

feature -- Actions

	on_select is
			-- Action to be performed when current panel is selected
		deferred
		ensure
			is_up_to_date: is_up_to_date
		end

	on_process_gui (a_item: QL_ITEM) is
			-- Action to be performed to process gui events
		do
			process_events_and_idle
			if a_item /= Void then
				display_status_message (metric_names.e_evaluating + a_item.path)
			end
		end

	on_unit_order_change is
			-- Action to ber performed when unit order changes
		do
			update (Void, Void)
		end

	on_unit_order_change_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_unit_order_change'

feature -- Pick and drop

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

	display_message (a_message: STRING) is
			-- Display `a_message' in a prompt-out information dialog.
		require
			a_message_attached: a_message /= Void
		local
			l_dialog: EV_INFORMATION_DIALOG
		do
			create l_dialog.make_with_text (a_message)
			l_dialog.set_buttons_and_actions (<<metric_names.t_ok>>, <<agent l_dialog.destroy>>)
			l_dialog.show_relative_to_window (metric_tool_window)
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
