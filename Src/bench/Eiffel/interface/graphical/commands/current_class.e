indexing

	description:	
		"Retarget the class tool with the class the execution is stopped in.";
	date: "$Date$";
	revision: "$Revision$"

class CURRENT_CLASS

inherit

	ICONED_COMMAND;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize this window.
		do 
			init (c, a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Current
		end;

	command_name: STRING is
			-- Command name.
		do
			Result := l_Current
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the class tool with the current class if any.
		local
			e_class: E_CLASS;
			status: APPLICATION_STATUS;
			st: FEATURE_STONE
		do
			status := Application.status;
			if status = Void then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			elseif status.e_feature = Void or status.dynamic_class = Void then
					-- Should never happen.
				warner (text_window).gotcha_call (w_Unknown_class)
			else
					-- Show the current routine in that class.
				e_class := status.origin_class;
				!! st.make (status.e_feature, e_class);
				text_window.receive (st)
			end
		end;

end -- class CURRENT_CLASS
