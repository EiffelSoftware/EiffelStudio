note
	description: "Summary description for {IRON_REPO_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_ITERATOR

inherit
	IRON_REPO_VISITOR

feature -- Visit

	visit_package (p: IRON_REPO_PACKAGE)
		do
		end

	visit_package_iterable (it: ITERABLE [IRON_REPO_PACKAGE])
		do
			across
				it as c
			loop
				visit_package (c.item)
			end
		end

end
