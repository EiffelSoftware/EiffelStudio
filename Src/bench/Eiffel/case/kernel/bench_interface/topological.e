indexing

	description: "Topological element.";
	date: "$Date$";
	revision: "$Revision $"

deferred class TOPOLOGICAL

inherit

	PART_COMPARABLE

feature -- Properties

	topological_id: INTEGER is
			-- Id of topological item
		deferred
		end;

	successors: LINKED_LIST [like Current] is
			-- Successors
		deferred
		end;

end -- class TOPOLOGICAL
