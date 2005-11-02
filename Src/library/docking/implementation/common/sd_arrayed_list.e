indexing
	description: "Objects that is a ARRAYED_LIST with actions."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_ARRAYED_LIST [G]
--FIXIT: USE ACTIVE_LIST -- But ACTIVE_LIST prune_all not work...
inherit
	ARRAYED_LIST [G]
		redefine
			make,
			extend,
			prune
		end
create
	make
	
feature {NONE} -- Initlization

	make (n: INTEGER) is
			-- Creation method.
		do
			Precursor {ARRAYED_LIST} (n)	
			create inserting_actions
			create inserted_actions
			create pruning_actions
			create pruned_actions 
			create clearing_actions
			create cleared_actions
		end
		
feature -- Events

	extend (v: like item) is
			-- Do precursor and fire the events.
		do
			Precursor {ARRAYED_LIST} (v)
			inserted_actions.call ([v])
		end	
	
	prune (v: like item) is
			-- Do precursor and fire the events.
		do
			Precursor {ARRAYED_LIST} (v)
			pruned_actions.call ([v])
		end
		
	inserting_actions: SD_DOCKING_ACTION [G]
			-- The actions called when inserting.
	inserted_actions: SD_DOCKING_ACTION [G]
			-- The actions called when inserted.
	pruning_actions: SD_DOCKING_ACTION [G]
			-- The actions called when pruning.
	pruned_actions: SD_DOCKING_ACTION [G]
			-- The actions called when pruned.
	clearing_actions: SD_DOCKING_ACTION [G]
			-- The actions called when clearing.
	cleared_actions: SD_DOCKING_ACTION [G]
			-- The actions called when cleared.
end
