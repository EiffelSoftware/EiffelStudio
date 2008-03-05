indexing
	description:
		"[
			Popup dialog to enter new arguments, modify existing ones and launch system with
			chosen argument.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_DIALOG

inherit
	EV_TITLED_WINDOW

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	DEBUGGER_OBSERVER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		redefine
			on_application_quit,
			on_application_launched,
			on_application_resumed,
			on_application_stopped
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW; cmd: like run) is
			-- Initialize Current with `par' as parent and
			-- `cmd' as command window.
		require
			a_window_not_void: a_window /= Void
			cmd_not_void: cmd /= Void
		do
			make_with_title (interface_names.t_Execution_parameters)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			attach_to_debugger (debugger_manager)
			set_size (600, 400)
			run := cmd

				-- Build Dialog GUI
			create debugging_options_control.make

			build_interface

			show_actions.extend (agent debugging_options_control.on_show)
			key_press_actions.extend (agent escape_check (?))
			focus_in_actions.extend (agent on_window_focused)
			close_request_actions.extend (agent on_close)
		end

	build_interface is
		require
			debugging_options_control_not_void: debugging_options_control /= Void
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			cb: EV_CHECK_BUTTON
			b: EV_BUTTON
			lab: EV_LABEL
			cmd: EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		do
			create execution_frame

			create hbox
			hbox.extend (debugging_options_control.widget)
			hbox.set_border_width (Layout_constants.Small_border_size)
			hbox.set_padding (Layout_constants.Small_padding_size)

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)

			create b.make_with_text (interface_names.b_close)
			vbox.extend (b)
			Layout_constants.set_default_width_for_button (b)
			vbox.disable_item_expand (b)
			b.select_actions.extend (agent on_close)

			if run /= Void then
					--| Run workbench

				create run_button.make_with_text (interface_names.b_run)
				vbox.extend (run_button)
				Layout_constants.set_default_width_for_button (run_button)
				vbox.disable_item_expand (run_button)
				run_button.select_actions.extend (agent execute)

				create cb.make_with_text (interface_names.b_keep_dialog_open)
				if keep_opened_status then
					cb.enable_select
				else
					cb.disable_select
				end
				vbox.extend (cb)
				vbox.disable_item_expand (cb)
				keep_opened_check_button := cb

					--| Outside ES

				vbox.extend (create {EV_CELL})
				create lab.make_with_text (interface_names.l_outside_ide)
				vbox.extend (lab)
				vbox.disable_item_expand (lab)

				cmd := eb_debugger_manager.run_workbench_cmd
				create start_wb_button.make_with_text (cmd.tooltext)
				vbox.extend (start_wb_button)
				vbox.disable_item_expand (start_wb_button)
				start_wb_button.set_pixmap (cmd.pixmap)
				start_wb_button.set_tooltip (cmd.tooltip)
				if {wbcmd: !EB_EXEC_WORKBENCH_CMD} eb_debugger_manager.run_workbench_cmd then
					start_wb_button.select_actions.extend (agent execute_operation (agent wbcmd.execute_with_parameters))
				end
				Layout_constants.set_default_width_for_button (start_wb_button)

				cmd := eb_debugger_manager.run_finalized_cmd
				create start_final_button.make_with_text (cmd.tooltext)
				vbox.extend (start_final_button)
				vbox.disable_item_expand (start_final_button)
				start_final_button.set_pixmap (cmd.pixmap)
				start_final_button.set_tooltip (cmd.tooltip)
				if {fncmd: !EB_EXEC_FINALIZED_CMD} eb_debugger_manager.run_finalized_cmd then
					start_final_button.select_actions.extend (agent execute_operation (agent fncmd.execute_with_parameters))
				end
				Layout_constants.set_default_width_for_button (start_final_button)
			end

			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

			execution_frame.extend (hbox)
			extend (execution_frame)
		end

feature {NONE} -- session data

	keep_opened_status_session_data_id: STRING = "com.eiffel.execution_options_dialog.keep_opened_status"

	keep_opened_status: BOOLEAN is
			-- Access to keep_opened_status' data
		local
    		consumer: !SERVICE_CONSUMER [!SESSION_MANAGER_S]
		do
			create consumer
    		if consumer.is_service_available then
				if {session: !SESSION_I} consumer.service.retrieve (True) then
					if {ref: !BOOLEAN_REF} session.value (keep_opened_status_session_data_id) then
						Result := ref.item
					else
						Result := False
			      	end
        		end
      		end
	  	end

	save_keep_opened_status is
			-- Change keep_opened_status' data.
		local
    		consumer: !SERVICE_CONSUMER [!SESSION_MANAGER_S]
		do
			create consumer
    		if consumer.is_service_available then
				if {session: !SESSION_I} consumer.service.retrieve (True) then
        			session.set_value (keep_opened_check_button.is_selected, keep_opened_status_session_data_id)
        		end
      		end
	  	end

feature -- GUI

	keep_opened_check_button: EV_CHECK_BUTTON

	execution_frame: EV_HORIZONTAL_BOX
			-- Frame containing all execution option

	run_button: EV_BUTTON
			-- Button to run system.

	start_wb_button, start_final_button: EV_BUTTON
			-- Button to start system.

feature -- Status Setting

	update is
			-- Update.
		do
			debugging_options_control.update
		end

feature {NONE} -- Actions

	on_close is
	 		-- Action to take when user presses 'Cancel' button.
	 	local
	 		l_question: ES_DISCARDABLE_QUESTION_PROMPT
		do
			if debugging_options_control.has_changed then
				create l_question.make_standard_with_cancel (
						warning_messages.w_apply_debugger_profiles_before_closing,
						"",
						preferences.dialog_data.confirm_always_apply_debugger_profiles_before_closing_string
					)
				l_question.set_button_action (l_question.dialog_buttons.yes_button, agent do debugging_options_control.store_dbg_options; hide end)
				l_question.set_button_action (l_question.dialog_buttons.no_button, agent do debugging_options_control.validate; hide end)
				l_question.show_on_active_window
			else
				debugging_options_control.validate
				hide
			end
			save_keep_opened_status
		end

feature {NONE} -- Properties

	debugging_options_control: EB_DEBUGGING_OPTIONS_CONTROL
			-- Widget holding all arguments information.

	run: PROCEDURE [ANY, TUPLE [DEBUGGER_EXECUTION_PARAMETERS]]

feature {NONE} -- Implementation

	on_window_focused is
			-- Acion to be taken when window gains focused.
		do
			debugging_options_control.set_focus_on_widget
		end

	on_run_button_key_press (key: EV_KEY) is
			-- Key was pressed whilst button had focus.
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then
				execute
			end
		end

	escape_check (key: EV_KEY) is
			-- Check for keyboard escape character.
		require
			key_not_void: key /= Void
     	do
        	if key.code = {EV_KEY_CONSTANTS}.key_escape then
            	on_close
            end
      	end

	execute_operation (op: like run) is
			-- Execute operation `op'
		local
			params: DEBUGGER_EXECUTION_PARAMETERS
		do
			params := debugging_options_control.selected_profile_parameters

			if keep_opened_check_button.is_selected then
				op.call ([params])
			else
				op.call ([params])
				on_close
			end
		end

	execute is
		do
			execute_operation (run)
		end

	execute_and_close is
		do
			keep_opened_check_button.disable_select
			execute
		end

feature {NONE} -- Observing event handling.

	on_application_quit (dbg: DEBUGGER_MANAGER) is
			-- Action to take when the application is killed.
		do
			run_button.enable_sensitive
		end

	on_application_launched (dbg: DEBUGGER_MANAGER) is
			-- Action to take when the application is launched.
		do
			run_button.disable_sensitive
--			on_application_resumed (dbg)
		end

	on_application_resumed (dbg: DEBUGGER_MANAGER) is
			-- Action to take when the application is resumed.
		do
--			run_button.disable_sensitive
		end

	on_application_stopped (dbg: DEBUGGER_MANAGER) is
			-- Action to take when the application is stopped.
		do
--			run_button.enable_sensitive
		end

invariant
	argument_control_not_void: debugging_options_control /= Void

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

end -- class EB_ARGUMENT_DIALOG
