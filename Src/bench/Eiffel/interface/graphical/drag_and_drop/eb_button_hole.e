indexing

	description:	
		"A pict color button that is a hole and a stone.";
	date: "$Date$";
	revision: "$Revision: "

class EB_BUTTON_HOLE 

inherit

	HOLE
		redefine
			receive, registered, compatible
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

create

	make

feature {NONE} -- Initialization

	make (a_cmd: like associated_command; a_parent: COMPOSITE) is
			-- Create a hole
		do
			eb_button_make (a_cmd, a_parent);
			a_cmd.init_other_button_actions (Current);
			initialize_transport
		end;

feature -- Access

	registered: BOOLEAN is
			-- Always registered
		do
			Result := True
		end;

	compatible (a_stone: STONE): BOOLEAN is
			-- Is the hole compatible with `a_stone'
		do
			Result := associated_command.stone_type = Any_type or else
				associated_command.compatible (a_stone)
		end

feature -- Properties

	associated_command: HOLE_COMMAND;

feature -- For redefinition in the descendants.

	full_symbol: PIXMAP is
		do
			Result := associated_command.full_symbol
		end;

	stone_type: INTEGER is
		do
		end;

	transported_stone: STONE is
		do
			Result := associated_command.transported_stone
		end

feature -- Pick and Throw

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'
		do
				-- Propagate receiption to `associated_command'.
			associated_command.receive (a_stone)
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

end -- class EB_BUTTON_HOLE
