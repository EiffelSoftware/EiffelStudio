indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_CLASS_3 [H -> NEW_CLASS_1, G -> {NEW_CLASS_2 rename common_feature as cf_2 end, NEW_CLASS_1}]

feature -- Access

	feature_in_class3_g: G

	feature_in_class3_h: H

	test_completion is
			--
		do
			feature_in_class3_g.common_feature.adapt_size
		end

end
