indexing
	description: "Source to create a new state%
				% and target to edit an existing state."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_NEW_STATE 

inherit
	EB_BUTTON
		redefine
			make, transportable
		end

	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			rout_cmd: EV_ROUTINE_COMMAND
		do
			Precursor (par)
			activate_pick_and_drop (3, Current, Void)
			set_data_type (Pnd_types.new_state_type)
			create rout_cmd.make (~process_state)
			add_pnd_command (Pnd_types.state_type, rout_cmd, Void)
			add_click_command (Current, Void)
		end
	
feature -- Access

	transportable: BOOLEAN is
		do
			Result := True
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.state_pixmap
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.create_edit_label)
--		end

feature {APP_NEW_STATE} -- Commands

	process_state (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Create a editor for the stone dropped
			-- if it is not already being edited.
		local
			state: BUILD_STATE
			circle: STATE_CIRCLE
		do
			circle ?= ev_data.data
			if circle /= Void then
				state := circle.data
			else
				state ?= ev_data.data
			end
			if state /= Void then
				state.create_editor
			end
		end

	execute (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Create a new state
		local
			add_state_cmd: APP_ADD_FIGURE
			args: EV_ARGUMENT2 [EV_POINT, BUILD_STATE]
			new_state: BUILD_STATE
			pt: EV_POINT
		do
			create new_state.make
			if ev_data = Void then
				new_state.set_internal_name ("")
				create add_state_cmd
				create pt.set (50, 50)
				create args.make (pt, new_state)
				add_state_cmd.execute (args, Void)	
			else
				set_transported_data (new_state)
			end
		end

end -- class APP_NEW_STATE

