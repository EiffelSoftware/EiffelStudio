indexing
	description	: "Wizard state: Error "
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_ERROR_STATE_WINDOW

inherit
	WIZARD_ERROR_STATE_WINDOW
		redefine
			cancel
		end

feature -- Basic operations

	cancel is
			-- The user has pushed the cancel (or the abort) button
		do
			write_bench_notification_cancel
		end

end -- class BENCH_WIZARD_ERROR_LOCATION

