note
	description: "Summary description for {EIFFEL_TEST_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_CONFIGURATION

inherit
	EIFFEL_TEST_CONFIGURATION_I

feature -- Access

	new_parent_name: !STRING
	create_new_parent: BOOLEAN
	parent: !EIFFEL_CLASS_I
	tags: !DS_LINEAR [!STRING]
	new_location: !CONF_CLUSTER
	name: !STRING
	covered_classes: !DS_BILINEAR [!CLASS_I]
	covered_features: !DS_BILINEAR [!FEATURE_I]

end
