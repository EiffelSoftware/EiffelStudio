indexing

	description: 
		"Abstract class for entity destruction.";
	date: "$Date$";
	revision: "$Revision $"

deferred class DESTROY

inherit

	ONCES

feature {NONE} -- Implementation property

	data: DATA
			-- Entity destroyed

feature {DESTROY_ENTITIES_U, DESTROY_FEATURES_U, DESTROY_CLUSTER} -- Implementation

	update is
			-- Update required. Note this is only called
			-- once if Current is part of a list.
		deferred
		end;

	redo is
		deferred
		end;

	undo is
		deferred
		end;

	name: STRING is
		deferred
		end;

	free_data is
			-- Free data from server.
		do
			-- Do nothing
		end;

	request_for_data is
			-- Request data to be held in memory.
			-- (Used for server mechanism).
			-- (This is called by record).
		do
			-- Do nothing
		end;

--invariant

	--has_data: data /= void

end -- class DESTROY
