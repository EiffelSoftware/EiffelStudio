indexing

	description: "Command to set the text in the focus label.";
	date: "$Date$";
	revision: "$Revision $"

class SET_FOCUS_LINE_COM

inherit

	EC_COMMAND
		redefine
			work
		end

creation

	make

feature {NONE} -- Initialization

	make (line: like focus_line) is
			-- Make a command to set help line.
		require
			has_line: line /= void
		do
			focus_line := line
		ensure
			focus_line_set: focus_line = line
		end

feature {NONE} -- Implementation property

	focus_line: FOCUS_LINE
			-- Window line associated with Current command

feature -- Execution

	work (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			--| Current command should not popdown the error window,
			--| hence the redefinition
		do
		--	execute (arg)
		end

feature {FOCUS_LINE} -- Implementation

	widget_is_entered: BOOLEAN;
			-- Has mouse pointer entered the widget?

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set help line shown.
		do
-- 			check
-- 				help_line_exists: focus_line /= void
-- 			end;
-- 			focus_line.focus_label.set_text (focus_string)
-- 
-- 			widget_is_entered := not focus_string.is_equal (" ");
-- 				-- when `focus_string' is not equal to ` ', the
-- 				-- widget is just entered, otherwise it is left.
-- 		ensure then
-- 			new_focus_set: equal (focus_line.focus_label.text, focus_string);
-- 			widget_is_entered_set: widget_is_entered implies not focus_string.is_equal (" ")
		end;

	update (new_focus: STRING) is
			-- Set the focus to ``new_focus''
		do
			-- Test in order to minimize calls to the X server (?):
			if not equal (focus_line.focus_label.text, new_focus) then 
				focus_line.focus_label.set_text (new_focus)
			end
		ensure
			new_focus_set: equal (focus_line.focus_label.text, new_focus)
		end;

invariant
	has_window: focus_line /= void

end -- class SET_FOCUS_LINE_COM
