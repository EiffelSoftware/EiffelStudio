indexing

	description:
		"Button with focus label. Special button class for the preference tool %
		%in EBench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_PREFERENCE_BUTTON

inherit
	WINDOWS;
	WIDGET_ROUTINES;
	PREFERENCE_BUTTON
		rename
			make as old_make
		end

create
	make

feature -- Initialization

    make (cmd: PREFERENCE_CATEGORY; a_parent: COMPOSITE) is
            -- Initialize Current
        do
			old_make (cmd, a_parent);
			init_button (implementation)
		end

end -- class EB_PREFERENCE_BUTTON
