note
	description: "Summary description for {IRON_REPO_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPO_VISITOR

feature -- Visit

	visit_package (p: IRON_REPO_PACKAGE)
		deferred
		end

	visit_package_iterable (it: ITERABLE [IRON_REPO_PACKAGE])
		deferred
		end

end
