indexing
	description: "List of feature names.";
	date: "$Date$";
	revision: "$Revision$"

class FEATURE_LIST_AS

inherit
	FEATURE_SET_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like features) is
			-- Create a new FEATURE_LIST AST node.
		require
			f_not_void: f /= Void
		do
			features := f
		ensure
			features_set: features = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feature_list_as (Current)
		end

feature -- Attributes

	features: EIFFEL_LIST [FEATURE_NAME]
			-- List of feature names

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := features.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := features.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (features, other.features)
		end

invariant
	features_not_void: features /= Void

end -- class FEATURE_LIST_AS
