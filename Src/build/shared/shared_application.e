indexing
	description: "Shared application graph."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_APPLICATION
	
feature -- Access

	Shared_app_graph: APP_GRAPH is
		once
			create Result.make
		end

end -- class SHARED_APPLICATION

