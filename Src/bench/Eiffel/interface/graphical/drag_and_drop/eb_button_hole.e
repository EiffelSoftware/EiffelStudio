indexing

	description:	
		"A pict color button that is a hole and a stone.";
	date: "$Date$";
	revision: "$Revision: "

class EB_BUTTON_HOLE 

inherit

	ICONED_COMMAND
		rename
			init as button_init,
			is_valid as pict_color_b_is_valid
		end;
	HOLE
		redefine
			receive, registered
		end;
	DRAG_SOURCE
		rename
			source as target
		end

creation

	make

feature {NONE} -- Initialization

	make (a_composite: COMPOSITE; t: like tool) is
			-- Create a hole
		require
			valid_t: t /= Void
		do
			button_init (a_composite, t.text_window);
			initialize_transport
		end;

feature -- Access

	target: WIDGET is
			-- Target of hole
		do
			Result := Current
		end;

	registered: BOOLEAN is
			-- Always registered
		do
			Result := True
		end;

feature -- Stone properties

	stone_type: INTEGER is
		do
		end;

	transported_stone: STONE is
		do
			Result := tool.stone
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

	name: STRING is
		do
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

feature {NONE} -- Properties

	tool: TOOL_W is
			-- Tool attached to Current
		do
			Result := text_window.tool
		end

feature {NONE} -- Implementation

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'
		do
			tool.receive (a_stone)
		end;

	work (argument: ANY) is
		local
			ts: like transported_stone;
			new_tool: TOOL_W
		do
			if tool = Project_tool then
				inspect 
					stone_type
				when Class_type then
					new_tool := window_manager.class_window
				when Routine_type then
					new_tool := window_manager.routine_window
				when Object_type then
					new_tool := window_manager.object_window
				when Explain_type then
					new_tool := window_manager.explain_window
				when System_type then
					new_tool := system_tool;
				end;
				if new_tool /= Void then
					new_tool.display
				end
			else
				ts := transported_stone;
				if ts /= Void then
					tool.receive (transported_stone)
				end
			end
		end;

end -- class EB_BUTTON_HOLE
