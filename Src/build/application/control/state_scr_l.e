indexing
	description: "List of the created states."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class STATE_SCR_L

inherit
	EV_LIST
		rename
			make as list_create
		end

	EV_COMMAND

	REMOVABLE

	CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; editor: APP_EDITOR) is
			-- Create the state_scr_list.
		local
			rout_cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [APP_EDITOR]
		do
			list_create (par)
--			compare_objects

			activate_pick_and_drop (3, Current, Void)
			set_data_type (Pnd_types.state_type)
			create rout_cmd.make (~process_state)
			create arg.make (editor)
			add_pnd_command (Pnd_types.state_type, rout_cmd, arg)
		end
	
feature {NONE} -- Removable

	remove_yourself is
		local
			cut_figure_command: APP_CUT_FIGURE
			arg: EV_ARGUMENT1 [STATE_CIRCLE]
		do
			create cut_figure_command
			create arg.make (Void)
			cut_figure_command.execute (arg, Void)
		end
	
feature -- Access

	selected_circle: STATE_CIRCLE
			-- Current state_figure 

	set_selected (c: STATE_CIRCLE) is
			-- Set selected_circle to `c'.
		do
			selected_circle := c	
		end

feature {STATE_SCR_L} -- Command

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Prepare the transport.
			-- If `selected_circle' is Void the data isn't transportable.
		do
			set_transported_data (selected_circle)
		end

	process_state (arg: EV_ARGUMENT1 [APP_EDITOR]; ev_data: EV_PND_EVENT_DATA) is
			-- Select the state dropped into the list.
		local
			st: BUILD_STATE
		do
			st ?= ev_data.data
			if st /= Void then
				arg.first.update_selected (st)
			end
		end

end -- class LABEL_SCR_L

