indexing

	description:
		"Notion of a toolbar that can be added to and %
		%removed from the user interface.";
	date: "$Date$";
	revision: "$Revision$"

class TOOLBAR

inherit
	FORM;
	COMMAND_W

creation
	make

feature -- Initialization

	init_toggle (toggle: TOGGLE_B) is
			-- Init arm action.
		do
			associated_toggle := toggle;
			toggle.add_activate_action (Current, Void);
			toggle.set_toggle_on
		end;

feature -- Access

	associated_toggle: TOGGLE_B;
			-- associated toggle button with toolbar

feature -- User Interface

	add is
		do
			manage_separator (True);
			manage;
			parent.unmanage; -- Shake it (for HP)
			parent.manage;
			associated_toggle.set_toggle_on
		end;

	remove is
		do
			manage_separator (False);
			unmanage;
			parent.unmanage; -- Shake it (for HP)
			parent.manage; 
			associated_toggle.set_toggle_off
		end;

feature {NONE} -- Execution

	work (argument: ANY) is
		do
			if associated_toggle.state then
				add
			else
				remove
			end;
		end

feature {NONE} -- Implementation

	manage_separator (b: BOOLEAN) is
			-- Find the right separator (ie. below Current if
			-- Current is not the lowest toolbar, or else above Current).
		local
			s: SEPARATOR;
			sibs: ARRAYED_LIST [WIDGET];
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
