indexing
	description: "Undoable command to set the initial state of the Application."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_SET_INIT_STATE

inherit
	APP_COMMAND

	SHARED_APPLICATION

feature -- Access

	undo is
		do 
			application_editor.set_initial_state (old_init_state)
			perform_update_display
		end

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Update the initial state of the application editor
			-- with data droppped.
		local
			circle: STATE_CIRCLE
			st: BUILD_STATE
		do
			circle ?= ev_data.data
			if circle /= Void then
				init_state := circle.data
			else
				init_state ?= ev_data.data
			end
			old_init_state := application_editor.initial_state_circle.data
			if init_state /= old_init_state then
				do_specific_work
			else
				failed := True
			end
		end

feature {NONE} -- Implementation

	old_init_state: BUILD_STATE

	init_state: BUILD_STATE

	do_specific_work is
			-- Set the initial_circle.
		do
			application_editor.set_initial_state (init_state)
			perform_update_display
		end

	update_display is
		do
			application_editor.draw_figures
		end

	name: STRING is
		do
			Result := Command_names.app_set_initial_state_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if init_state /= Void then
				Result.append (init_state.label)
			end
		end

end -- class APP_SET_INIT_STATE

