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

	icon_symbol: PIXMAP is
		do
			Result := associated_command.icon_symbol
		end;

	text_window: TEXT_WINDOW is
		do
		end;

feature -- Pick and Throw

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'
		do
			tool.receive (a_stone)
		end;

feature -- Properties

	tool: TOOL_W is
			-- Tool attached to Current
		do
			Result := associated_command.text_window.tool
		end

end -- class EB_BUTTON_HOLE
