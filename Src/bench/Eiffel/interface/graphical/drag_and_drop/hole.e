
class HOLE 

inherit

	ICONED_COMMAND
		rename
			init as ic_init
		end;
	STONE

creation

	make

feature {NONE}

	make (a_composite: COMPOSITE; a_tool: TOOL_W) is
			-- Create a hole
		do
			ic_init (a_composite, a_tool.text_window);
			tool := a_tool;
			!!transporter_arg;
			add_button_press_action (3, Current, transporter_arg)
		ensure
			parent = a_composite
		end;

	tool: TOOL_W;
			-- Tool attached to Current

	transporter_arg: ANY;
	
feature 

	receive (dropped: STONE) is
			-- Deal with element `dropped'.
		do
			if compatible (dropped) then
				tool.receive (dropped)
			end
		end;

feature {NONE}

	work (argument: ANY) is
		local
			void_text: TEXT_WINDOW
		do
			if argument = transporter_arg then
				tool.transport (Current, void_text, screen.x, screen.y)
			else
				if tool /= project_tool then
					tool.synchronize
				else
					tool.receive (Current)
				end
			end
		end;

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then (stone_type = dropped.stone_type)
		ensure
			Result implies ((dropped /= Void) and then (stone_type = dropped.stone_type))
		end;

feature  -- to redefine

	symbol: PIXMAP is do end;
	command_name: STRING is do end;
	stone_type: INTEGER is do end;

	stone_name: STRING is do Result := command_name end;

feature -- useless

	signature: STRING is do Result := stone_name end;
	click_list: ARRAY [CLICK_STONE] is do end;
	clickable: BOOLEAN is do end;
	origin_text: STRING is do end

end
