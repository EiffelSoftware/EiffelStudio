indexing
	description	: "Template for the last state of a wizard for EiffelBench"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			cancel
		end

feature -- Basic operations

	cancel is
			-- User	has pressed the cancel button
		do
			write_bench_notification_cancel
		end

feature {NONE} -- Implementation

	project_generator: WIZARD_PROJECT_GENERATOR is
			-- Project generator
		once
			create Result.make (wizard_information)
		end

end -- class BENCH_WIZARD_FINAL_STATE_WINDOW

