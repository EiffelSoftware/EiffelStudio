note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_SVN_ENGINE

feature -- Access

	svn_engine_provider: SVN_ENGINE_PROVIDER
		once
			create Result.make
		end

end
