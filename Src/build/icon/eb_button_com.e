-- Eiffelbuild button that has a callback when
-- activated.
deferred class EB_BUTTON_COM

inherit

	EB_BUTTON
		rename
			make_visible as button_make_visible
		end;
	COMMAND;

feature {NONE}

	make_visible (a_parent: COMPOSITE) is	
		require
			valid_a_parent: a_parent /= Void
		do
			button_make_visible (a_parent);
			add_activate_action (Current, Void)
		end;

end
