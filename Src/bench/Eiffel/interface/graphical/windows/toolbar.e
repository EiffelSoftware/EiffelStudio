indexing

	description:
		"Notion of a toolbar that can be added to and %
		%removed from the user interface.";
	date: "$Date$";
	revision: "$Revision$"

class TOOLBAR

inherit
	COMMAND;
	FORM
		rename
			make as form_make
		end

creation
	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE; a_tool: TOOL_W) is
			-- Initialize Current with `a_name' and
			-- `a_parent'. Add callback for button
			-- press action on right mouse button.
		require
			a_tool_not_void: a_tool /= Void
		do
			form_make (a_name, a_parent);
			add_button_press_action (3, Current, arg_popup);
			tool := a_tool
		end

feature -- User Interface

	add is
		do
			if tool.popup_cell.item /= Void then
				tool.popup_cell.item.destroy;
				tool.popup_cell.put (Void)
			end;
			manage_separator (True);
			manage
		end;

	remove is
		do
			if tool.popup_cell.item /= Void then
				tool.popup_cell.item.destroy;
				tool.popup_cell.put (Void)
			end;
			manage_separator (False);
			unmanage
		end;

feature -- Properties; Execution arguments

	arg_show: ANY is
		once
			!! Result
		end;

	arg_hide: ANY is
		once
			!! Result
		end;

	arg_popup: ANY is
		once
			!! Result
		end

feature {NONE} -- Execution

	execute (argument: ANY) is
		local
			popup_cmd: TOOLBAR_CMD
		do
			if argument = arg_show then
				add
			elseif argument = arg_hide then
				remove
			elseif argument = arg_popup then
				!! popup_cmd.make (tool);
				popup_cmd.execute (Void);
				popup_cmd := Void
			end
		end

feature {NONE} -- Properties

	tool: TOOL_W;
			-- Tool window parent of Current

	new_name: STRING is ""
			-- Dummy name for widget creations

feature {NONE} -- Implementation

	manage_separator (b: BOOLEAN) is
			-- Find the right separator (ie. below Current if
			-- Current is not the lowest toolbar, or else above Current).
		local
			sibs: ARRAYED_LIST [WIDGET];
			s: SEPARATOR
		do
			sibs := parent.children;
			sibs.finish
			from
			until
				sibs.item = Current or else sibs.before
			loop
				sibs.back
			end;
			if not sibs.before then
				sibs.back
				if not sibs.before then
					s ?= sibs.item
					if s /= Void then
						if b then
							sibs.back;
							sibs.back;
							if sibs.before then
								sibs.forth;
								if sibs.item.managed then
									s.manage
								end
							end
						else
							s.unmanage
						end
					end
				else
					sibs.forth;
					sibs.forth;
					s ?= sibs.item
					if s /= Void then
						if b then
							sibs.forth;
							sibs.forth;
							if sibs.after then
								sibs.back;
								if sibs.item.managed then
									s.manage
								end
							end
						else
							s.unmanage
						end
					end
				end
			end
		end

end -- class TOOLBAR
