indexing

	description: 
		"Abstract ancestor of commands associated to the workarea.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	WORKAREA_COMMAND

inherit
	EC_COMMAND 

feature {NONE} -- Initialization

	make (wa: like workarea) is
			-- Associate workarea `wa' to the Current command
		do
			workarea := wa
		ensure
			workarea_set: workarea = wa
		end

feature -- Status report    

	workarea: WORKAREA
		-- Workarea to which the Current command is associated.

invariant
	workarea_exists: workarea /= Void
end -- class WORKAREA_COMMAND



