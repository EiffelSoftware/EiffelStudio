indexing

	description:	
		"A pict color button that is a hole and a stone.";
	date: "$Date$";
	revision: "$Revision: "

class EB_BUTTON_HOLE 

inherit

	HOLE
		redefine
			receive, registered
		end;
	DRAG_SOURCE
		rename
			source as target
		end;
	EB_BUTTON
		rename
			focus_source as target,
			make as eb_button_make
		redefine
			associated_command
		end

creation

	make

feature {NONE} -- Initialization

	make (a_cmd: like associated_command; a_parent: COMPOSITE) is
			-- Create a hole
		do
			eb_button_make (a_cmd, a_parent);
			initialize_transport
		end;

feature -- Access

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

	full_symbol: PIXMAP is
		do
			Result := associated_command.full_symbol
		end;

--	icon_symbol: PIXMAP is
--		do
--			Result := associated_command.icon_symbol
--		end;

feature -- Pick and Throw

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'
		do
			if a_stone.is_valid and then compatible (a_stone) then
				tool.receive (a_stone)
			end
		end;

feature -- Setting

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

feature -- Properties

	tool: TOOL_W is
			-- Tool attached to Current
		do
			Result := associated_command.tool
		end

feature {NONE} -- Properties

	associated_command: HOLE_COMMAND

end -- class EB_BUTTON_HOLE
