indexing

	description:	
		"General notion of a hole.";
	date: "$Date$";
	revision: "$Revision: "

class HOLE 

inherit

	ICONED_COMMAND
		rename
			init as ic_init,
			is_valid as pict_color_b_is_valid
		end;
	STONE

creation

	make

feature {NONE} -- Initialization

	make (a_composite: COMPOSITE; a_tool: TOOL_W) is
			-- Create a hole
		do
			ic_init (a_composite, a_tool.text_window);
			tool := a_tool;
			set_action ("<Btn3Down>", Current, transporter_arg);
			set_action ("!c<Btn3Down>", Current, new_tooler_arg)
		ensure
			parent = a_composite
		end;

feature -- Pick and Throw

	receive (dropped: STONE) is
			-- Deal with element `dropped'.
		do
			if compatible (dropped) then
				tool.receive (dropped)
			end
		end;

feature -- For redefinition in the descendants.

	symbol: PIXMAP is
		do
		end;

	full_symbol: PIXMAP is
		do
		end;

	icon_symbol: PIXMAP is
		do
			Result := symbol
		end;

	command_name: STRING is
		do
		end;

	stone_type: INTEGER is
		do
		end;

	stone_name: STRING is
		do
			Result := command_name
		end;

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

	signature: STRING is
		do
			Result := stone_name
		end;

	click_list: ARRAY [CLICK_STONE] is
		do
		end;

	clickable: BOOLEAN is
		do
		end;

	origin_text: STRING is
		do
		end

feature {NONE} -- Properties

	tool: TOOL_W;
			-- Tool attached to Current

	transporter_arg: ANY is
		once
			!!Result
		end;

	new_tooler_arg: ANY is
		once
			!!Result
		end;

	icon_name: STRING is
		do
		end;

	transport_stone: STONE is
		do
			Result := tool.text_window.root_stone
		end;

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then (stone_type = dropped.stone_type)
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
		local
			rs: STONE;
		do
			if argument = transporter_arg then
				rs := transport_stone;
				if rs /= Void then
					tool.transport (rs, void, screen.x, screen.y)
				end;
			elseif argument = new_tooler_arg then
				rs := transport_stone;
				if rs /= Void then
					project_tool.receive (rs)
				end
			else
				if tool /= project_tool then
					tool.synchronize
				else
					tool.receive (Current)
				end
			end
		end;

end -- class HOLE
