indexing

	description:
		"Button with focus label. Special button class for the preference tool %
		%in EBench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_PREFERENCE_BUTTON

inherit
	WINDOWS;
	PREFERENCE_BUTTON

creation
	make

feature {NONE} -- Implementation

	focus_label: FOCUS_LABEL_I is
			-- Label onto which the focus
			-- string of Current is to be
			-- displayed.
		once
			!FOCUS_LABEL! Result.initialize (Project_tool)
		end

end -- class EB_PREFERENCE_BUTTON
