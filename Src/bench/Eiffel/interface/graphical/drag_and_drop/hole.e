
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
--			add_button_click_action (3, Current, transporter_arg)
			add_button_press_action (3, Current, transporter_arg)
		ensure
			parent = a_composite
		end;

	tool: TOOL_W;
			-- Tool attached to Current

	transporter_arg: ANY;

	icon_name: STRING is do end;
	
feature 

	receive (dropped: STONE) is
			-- Deal with element `dropped'.
		do
			if compatible (dropped) then
				tool.receive (dropped)
			end
		end;

feature {NONE}

	transport_stone: STONE is
		do
			Result := tool.text_window.root_stone
		end;

	work (argument: ANY) is
		local
			rs: STONE;
		do
			if argument = transporter_arg then
				rs := transport_stone;
				if rs /= Void then
					tool.transport (rs, void, screen.x, screen.y)
				end;
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
		end;

feature  -- to redefine

	symbol: PIXMAP is do end;
	full_symbol: PIXMAP is do end;
	icon_symbol: PIXMAP is do Result := symbol end;
	command_name: STRING is do end;
	stone_type: INTEGER is do end;
	stone_name: STRING is do Result := command_name end;

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

feature -- useless

	signature: STRING is do Result := stone_name end;
	click_list: ARRAY [CLICK_STONE] is do end;
	clickable: BOOLEAN is do end;
	origin_text: STRING is do end

end
