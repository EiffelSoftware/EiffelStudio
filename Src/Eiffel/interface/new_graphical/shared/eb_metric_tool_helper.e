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

feature -- Access

	show_error_message (a_error_agent: FUNCTION [ANY, TUPLE, EB_METRIC_ERROR]; a_clear_error_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW) is
			-- Show error message retrieved from `a_error_agent' if any in `a_window'.
			-- And then clear error by calling `a_clear_error_agent'.
		require
			a_error_agent_attached: a_error_agent /= Void
			a_clear_error_agent_attached: a_clear_error_agent /= Void
			a_window_attached: a_window /= Void
		local
			l_error: EB_METRIC_ERROR
			l_dlg: EV_ERROR_DIALOG
		do
			l_error := a_error_agent.item (Void)
			if l_error /= Void then
				if feedback_dialog.is_show_requested then
					feedback_dialog.hide
				end
				create l_dlg.make_with_text (l_error.message_with_location)
				l_dlg.set_buttons_and_actions (<<interface_names.b_Ok>>, <<agent do_nothing>>)
				l_dlg.show_relative_to_window (a_window)
				a_clear_error_agent.call (Void)
			end
		end

	show_feedback_dialog (a_msg: STRING_GENERAL; a_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW) is
			-- Show a feedback information `a_dialog' modal to `a_window' to display information `a_msg'.
			-- `a_agent' will be added into `on_show_actions' of that dialog.
		require
			a_msg_attached: a_msg /= Void
			a_agent_attached: a_agent /= Void
			a_window_attached: a_window /= Void
		do
			feedback_dialog.set_title (a_msg)
			feedback_dialog.set_text (a_msg)
			feedback_dialog.show_actions.wipe_out
			feedback_dialog.show_actions.extend (agent call_agent_and_then_hide (a_agent, feedback_dialog))
			feedback_dialog.show_modal_to_window (a_window)
		end

	feedback_dialog: EV_INFORMATION_DIALOG is
			-- Dialog to display feedback
		once
			if feedback_dialog_internal = Void then
				create feedback_dialog_internal
			end
			Result := feedback_dialog_internal
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
					show_feedback_dialog (a_msg, agent metric_manager.load_metrics, a_develop_window.window)
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

	feedback_dialog_internal: like feedback_dialog
			-- Implementation of `feedback_dialog'

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
