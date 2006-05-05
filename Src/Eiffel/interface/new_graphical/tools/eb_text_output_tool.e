indexing
	description: "Object that represents an output tool which contains a text field"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_OUTPUT_TOOL

feature -- Accelerator

	is_accelerator_matched (a_key: EV_KEY; a_accelerator: EV_ACCELERATOR): BOOLEAN is
			-- Does `a_accelerator' match current keyboard status?
		require
			a_key_attached: a_key /= Void
		local
			l_ev_app: like ev_application
		do
			l_ev_app := ev_application
			Result := a_accelerator /= Void and then
					 a_accelerator.key.code = a_key.code and then
					 a_accelerator.alt_required = l_ev_app.alt_pressed and then
					 a_accelerator.shift_required = l_ev_app.shift_pressed and then
					 a_accelerator.control_required = l_ev_app.ctrl_pressed
		end

feature -- Access

	output_text: EV_TEXT is
			-- Text pane used to display output
		do
			if internal_output_text = Void then
				create internal_output_text
				internal_output_text.key_press_actions.extend (agent on_key_presses_in_output)
			end
			Result := internal_output_text
		ensure
			result_attached: Result /= Void
		end

	ev_application: EV_APPLICATION is
			-- Current application.
		once
			Result := (create {EV_ENVIRONMENT}).application
		end

feature -- Actions

	on_key_presses_in_output (a_key: EV_KEY) is
			-- Action to be performed when key pressed on text field
		require
			a_key_attached: a_key /= Void
			output_text_attached: output_text /= Void
		do
			if is_accelerator_matched (a_key, ctrl_a) then
				output_text.select_all
			elseif is_accelerator_matched (a_key, ctrl_c) then
				if output_text.has_selection then
					output_text.copy_selection
				end
			end
		end

feature{NONE} -- Implementation

	ctrl_c: EV_ACCELERATOR is
			-- Ctrl+C accelerator
		once
			create Result.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_c), True, False, False)
		ensure
			result_attached: Result /= Void
		end

	ctrl_a: EV_ACCELERATOR is
			-- Ctrl+A accelerator
		once
			create Result.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_a), True, False, False)
		ensure
			result_attached: Result /= Void
		end

	internal_output_text: like output_text
			-- Implementation of `output_text'

end
