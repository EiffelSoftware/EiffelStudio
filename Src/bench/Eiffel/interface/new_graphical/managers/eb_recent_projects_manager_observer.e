indexing
	description	: "Observer for EB_RECENT_PROJECTS_MANAGER"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_RECENT_PROJECTS_MANAGER_OBSERVER

feature -- Updates

	on_update is
			-- the list of recent projects has changed.
		do
		end

end -- class EB_RECENT_PROJECTS_MANAGER_OBSERVER
