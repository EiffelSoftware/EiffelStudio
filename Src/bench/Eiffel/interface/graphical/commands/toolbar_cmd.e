indexing

	description:
		"Command to popup the menu for a toolbar.";
	date: "$Date$";
	revision: "$Revision$"

class TOOLBAR_CMD

inherit
	COMMAND;
	WINDOW_ATTRIBUTES

create
	make

feature {NONE} -- Initialization

	make (a_tool: TOOL_W) is
			-- Initialize Current with `a_tool' as `tool'.
		do
			tool := a_tool
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute Current
		local
			popup: POPUP;
			entry: PUSH_B;
			e_text: STRING;
			a_bar: TOOLBAR;
			arg: ANY;
			bars: ARRAYED_LIST [WIDGET];
			sep: THREE_D_SEPARATOR;
			screen: SCREEN
		do
			popup := tool.popup_cell.item;
			if popup /= Void then
				if argument = destroy_action or else 
					popup.parent /= tool.toolbar_parent 
				then
					tool.popup_cell.put (Void);
					popup.destroy;
					popup := Void
				end
			end;
			screen := tool.toolbar_parent.screen;
			if popup = Void then
				create popup.make ("", tool.toolbar_parent);
				popup.set_action ("<Unmap>", Current, destroy_action);
				popup.set_title ("Toolbars");
				create sep.make ("", popup);

				from
					bars := tool.toolbar_parent.children;
					bars.finish
				until
					bars.before
				loop
					a_bar ?= bars.item;
					if a_bar /= Void then
						create e_text.make (0);
						if a_bar.managed then
							e_text.append ("Hide ");
							arg := a_bar.arg_hide
						else
							e_text.append ("Show ");
							arg := a_bar.arg_show
						end;
						e_text.append (a_bar.identifier);
						create entry.make (e_text, popup);
						entry.add_activate_action (a_bar, arg)
					end
					bars.back
				end;
				set_composite_attributes (popup);
				tool.popup_cell.put (popup)
			end;
			popup.set_x_y (screen.x, screen.y);
			popup.popup
		end

feature {NONE} -- Properties

	tool: TOOL_W
			-- Tool window that holds the popup.

	destroy_action: ANY is
		once
			create Result
		end

end -- class TOOLBAR_CMD
