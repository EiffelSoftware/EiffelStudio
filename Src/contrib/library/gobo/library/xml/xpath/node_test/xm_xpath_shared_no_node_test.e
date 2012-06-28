indexing

	description:

		"Singleton object that fail to match against any node"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_SHARED_NO_NODE_TEST

feature -- Access

	empty_item: XM_XPATH_NO_NODE_TEST is
			-- Singleton
		once
			create Result.make
		end

end
