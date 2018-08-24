note
	description: "Summary description for {E2B_BLACKBOARD_SCORES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BLACKBOARD_SCORES

feature

	successful: REAL = 1.0
	successful_with_errors: REAL = 0.25
	failed: REAL = -0.25
	skipped: REAL = 0.0

end
