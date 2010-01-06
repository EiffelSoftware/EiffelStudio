indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_CLASS_1

feature -- Access

	common_feature: STRING_32 is
			--
		do
			print ("Common feature in NEW_CLASS_1%N")
		end

	feature_in_class1: NEW_CLASS_1

invariant
	invariant_clause: True -- Your invariant here

end
