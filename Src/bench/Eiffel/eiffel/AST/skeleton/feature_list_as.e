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

feature -- Export status computing

	update (export_adapt: EXPORT_ADAPTATION; export_status: EXPORT_I; parent: PARENT_C) is
			-- Update `export_adapt' with `export_status'.
		local
			feature_name: STRING
			vlel3: VLEL3
		do
			from
				features.start
			until
				features.after
			loop
				feature_name := features.item.internal_name
				if not export_adapt.has (feature_name) then
					export_adapt.put (export_status, feature_name)
				else
					create vlel3
					vlel3.set_class (System.current_class)
					vlel3.set_parent (parent.parent)
					vlel3.set_feature_name (feature_name)
					vlel3.set_location (features.item.start_location)
					Error_handler.insert_error (vlel3)
				end
				features.forth
			end
		end
		
invariant
	features_not_void: features /= Void
			
end -- class FEATURE_LIST_AS
