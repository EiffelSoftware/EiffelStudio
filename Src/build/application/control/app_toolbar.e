indexing
	description: "Toolbar of the Application Editor."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_TOOLBAR 

inherit
	EV_TOOL_BAR
		redefine
			make
		end

creation
	make
	
feature {NONE} -- Initialization

	make (par: EV_BOX) is
			-- Create application menu bar.
		local
			new_state_b: APP_NEW_STATE
			init_state_hole: APP_INIT_ST_H
			self_hole: APP_SELF_HOLE
			return_hole: APP_RETURN_H
			exit_hole: APP_EXIT_HOLE
			tran_hole: APP_LINE_HOLE
			cut_hole: CUT_HOLE
		do
			{EV_TOOL_BAR} Precursor (par)
			par.set_child_expandable (Current, False)
			create new_state_b.make (Current)
			create init_state_hole.make (Current) 
			create self_hole.make (Current)
			create return_hole.make (Current)
			create exit_hole.make (Current)
			create tran_hole.make (Current) 
			create cut_hole.make (Current) 
		end

end -- class APP_TOOLBAR

