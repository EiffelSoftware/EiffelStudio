note
	description: "Summary description for {REPORT_STATISTICS}."
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_STATISTICS

feature -- Access

	open: NATURAL
 		--  Number of open issues.

	analyzed: NATURAL
 		-- Number of  analyzed issues.

	closed: NATURAL
		-- Number of closed issues.

	suspended: NATURAL
		-- Number of suspended issues.

	wont_fix: NATURAL
		-- Number of won't fix issues.

feature -- Change element

	increment_open
		do
			open := open + 1
		ensure
			open_incremented: old open + 1 = open
		end

	increment_analyzed
		do
			analyzed := analyzed + 1
		ensure
			analyzed_incremented: old analyzed + 1 = analyzed
		end

	increment_closed
		do
			closed := closed + 1
		ensure
			closed_incremented: old closed + 1 = closed
		end

	increment_suspended
		do
			suspended := suspended + 1
		ensure
			suspended_incremented: old suspended + 1 = suspended
		end


	increment_wont_fix
		do
			wont_fix := wont_fix + 1
		ensure
			wont_fix_incremented: old wont_fix + 1 = wont_fix
		end

end
