indexing

	description:
		"Popup a list of all targets in the tool's history. %
		%The contents is created in the descendants.";
	date: "$Date$";
	revision: "$Revision$"

class LIST_HISTORY

inherit
	PIXMAP_COMMAND
		rename
			init as make
		redefine
			execute
		end

creation
	make

feature -- Properties

	symbol: PIXMAP is
			-- Symbol for the button
		do
			Result := Void
		ensure then
			Void_result: Result = Void
		end;

	name: STRING is
			-- Name of the command
		do
			Result := l_List_targets
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute Current command.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			execute_licenced (argument)
		end;

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Execute Current.
		local
			a_button: EB_BUTTON
		do
			a_button ?= argument;
			if a_button /= Void then
					--| Argument is a button, CHOICE_W should be
					--| popped up.
				create_and_show_choices (a_button)
			elseif argument = choices then
					--| Arrgument is the CHOICE_W, so retargetting
					--| the text_window will do.
				retarget_text_window
			end
		end;

feature {NONE} -- Implementation

	create_and_show_choices (a_button: EB_BUTTON) is
			-- Creates the choice window, fills it,
			-- and pops it up.
			-- `a_button' is used as parent.
		local
			a_list: TWO_WAY_LIST [STRING]
		do
			!! choices.make_with_widget (a_button.parent, a_button);
			!! a_list.make;
			fill_list (a_list);
			choices.popup (Current, a_list);
			choices.select_i_th (tool.history.index + 1)
		end;

	fill_list (list: TWO_WAY_LIST [STRING]) is
			-- Fill `list' with strings.
			--| Be careful: `fill_list' may not change
			--| the position of the active item!!
		local
			cur: CURSOR;
			a_string: STRING;
			history: STONE_HISTORY
		do
			history := tool.history;
			cur := history.cursor;
			from
				history.start
			until
				history.after
			loop
				list.extend (history.item.history_name)
				history.forth
			end;
			history.go_to (cur)
		end;

	retarget_text_window is
			-- Retarget `text_window' with the chosen item.
		local
			history: STONE_HISTORY;
			pos: INTEGER
		do
			pos := choices.position;
			if pos > 1 then
					--| Position 1 is the "--cancel--" entry.
				pos := pos - 1;
				history := tool.history;
				from
					history.start
				until
					pos = 1
				loop
					history.forth;
					pos := pos - 1
				end;
				tool.last_format.execute (history.item)
			end
		end;

feature {NONE} -- Properties

	choices: CHOICE_W
			-- Window to popup the choices.
			
end -- class LIST_HISTORY
