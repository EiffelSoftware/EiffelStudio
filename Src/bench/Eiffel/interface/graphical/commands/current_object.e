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
			stone: OBJECT_STONE
		do
			if Run_info.is_running and Run_info.is_stopped then
				!! stone.make (Run_info.object_address, Run_info.class_type.associated_class);
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
