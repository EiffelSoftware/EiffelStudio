indexing

	description: 
		"This class is used so that the focus can be%
		%displayed when a stone is picked up from a button widget";
	date: "$Date$";
	revision: "$Revision $"

class STONE_SET_FOCUS_LINE_COM

inherit

	SET_FOCUS_LINE_COM
		redefine
			execute
		end

creation

	make

feature -- Properties

	transporting: BOOLEAN;

feature -- Setting

	set_transporting (b: BOOLEAN) is
		do
			transporting := b
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set help line shown
		do
		--	check
		--		help_line_exists: focus_line /= void
		--	end;
		--	if not transporting then
		--		focus_line.focus_label.set_text (focus_string)
		--	end;
		end;

end -- class STONE_SET_FOCUS_LINE_COM
