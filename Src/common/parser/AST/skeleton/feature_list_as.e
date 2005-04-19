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

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := features.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := features.end_location
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
