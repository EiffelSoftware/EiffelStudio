indexing

	description:	
		"Retarget the object tool with the object the execution is stopped in.";
	date: "$Date$";
	revision: "$Revision$"


class CURRENT_OBJECT

inherit

	ICONED_COMMAND;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the associated window.
		do 
			init (a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Current
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := l_Current
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the object tool with the current object if any.
		local
			e_class: E_CLASS;
			address: STRING;
			stone: OBJECT_STONE;
			status: APPLICATION_STATUS
		do
			status := Application.status;
			if status = Void then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			else
				address := status.object_address;
				if address = Void or status.dynamic_class = Void then
						-- Should never happen.
					warner (text_window).gotcha_call (w_Unknown_object)
				else
					e_class := status.dynamic_class;
					!! stone.make (address, e_class);
					text_window.tool.process_object (stone)
				end
			end
		end;

end -- class CURRENT_OBJECT
