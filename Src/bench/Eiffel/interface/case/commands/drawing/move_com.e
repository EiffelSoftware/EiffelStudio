indexing

	description: "Factorization of behaviours for moving by mouse.";
	date: "$Date$";
	revision: "$Revision $"

deferred class MOVE_COM 

inherit

	EV_COMMAND

feature {NONE} -- Execution

	context_data_useful: BOOLEAN is True;
			-- This command need a context_data structure

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Call appropriate routines based on mouse pointer movement.
		local
			motnot_data: EV_MOTION_EVENT_DATA
			but_event: EV_BUTTON_EVENT_DATA
		--	butrel_data: BUTREL_DATA;
		--	btpress_data: BTPRESS_DATA
		do
			motnot_data ?= data;
			if motnot_data /= void then
				execute_button_motion (args, motnot_data)
			else
				but_event ?= data
				if but_event /= Void then
					execute_button_release (args, but_event)
				end
			end
		--		butrel_data ?= context_data;
		--		if butrel_data /= void then
		--			execute_button_release (arg, butrel_data)
		--		else
		--			btpress_data ?= context_data;
		--			check
		--				btpress_data /= void
		--			end;
		--			execute_button_press (arg, btpress_data)
		--		end
		end

feature {NONE} -- Implementation

	--execute_button_press (arg: ANY; button_data: BUTTON_DATA) is
	--		-- Called when the mouse button is pressed
	--	require
	--		button_data /= void
	--	deferred
	--	end;

	execute_button_motion (args: EV_ARGUMENT; motnot_data:  EV_MOTION_EVENT_DATA) is
			-- Called when the mouse is moved
		require
			motnot_data /= void
		deferred
		end

	execute_button_release (arg: EV_ARGUMENT; button_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released
		require
			button_data /= void
		deferred
		end 

end -- class MOVE_COM
