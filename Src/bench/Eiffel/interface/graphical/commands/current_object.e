-- Retarget the object tool with the object the execution is stopped in.

class CURRENT_OBJECT

inherit

	ICONED_COMMAND;
	SHARED_DEBUG

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do 
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Retarget the object tool with the current object if any.
		local
			e_class: E_CLASS;
			address: STRING;
			stone: OBJECT_STONE
		do
			address := Run_info.object_address;
			if not Run_info.is_running then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not Run_info.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			elseif address = Void or Run_info.class_type = Void then
					-- Should never happen.
				warner (text_window).gotcha_call (w_Unknown_object)
			else
				e_class := Run_info.class_type.associated_class.e_class;
				!! stone.make (address, e_class);
				text_window.receive (stone)
			end
		end;

feature

	symbol: PIXMAP is
		once
			Result := bm_Current
		end;

	command_name: STRING is
		do
			Result := l_Current
		end;

end -- class CURRENT_OBJECT
