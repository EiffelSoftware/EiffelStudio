indexing
	description: "Common bases for each window in EiffelCase"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECASE_WINDOW

inherit

	--EV_COMMAND
	
	EV_WINDOW

	SIZE_SAVABLE

	ONCES

	CONSTANTS

feature -- Callbacks

	--execute ( arg: EV_ARGUMENT2[ECASE_WINDOW,INTEGER]; data: EV_EVENT_DATA) is
	--	deferred
	--	end

	update is deferred end

	cancel( arg: EV_ARGUMENT; data: EV_EVENT_DATA) is do end

end -- class ECASE_WINDOW
