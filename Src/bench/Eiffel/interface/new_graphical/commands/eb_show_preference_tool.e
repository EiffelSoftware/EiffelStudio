indexing
	description	: "Command to show the preference window."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class EB_SHOW_PREFERENCES_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create this command.
		do
		end

feature {NONE} -- Execution

	execute is
			-- Execute command.
		do
			if preference_window = Void or else preference_window.is_destroyed then
					-- Preference tool is not currently displayed, create and display it.
				create preference_window.make
			else
					-- Preference is currently displayed, raise it.
				preference_window.raise
			end
		end

feature -- Properties

	name: STRING is 
			-- Command name
		do
			Result := Interface_names.f_Preferences
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Preferences
		end

feature {NONE} -- Implementation

	preference_window: PREFERENCE_WINDOW
			-- Current preference window if any.

end -- class EB_SHOW_PREFERENCE_TOOL
