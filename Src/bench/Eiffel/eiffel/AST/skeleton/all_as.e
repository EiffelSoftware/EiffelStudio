indexing
	description: "AST representation of an `all' structure."
	date: "$Date$"
	revision: "$Revision$"

class ALL_AS

inherit
	FEATURE_SET_AS

create
	initialize

feature {NONE} -- Initialization

	 initialize is
			-- Create a new ALL AST node.
		do
			-- Do nothing.
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_all_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := null_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := null_location
		end

feature -- Initialization

	update (export_adapt: EXPORT_ADAPTATION; export_status: EXPORT_I; parent: PARENT_C) is
			-- Update `export_adapt' with `export_status'.
		local
			vlel1: VLEL1
		do
			if export_adapt.all_export = Void then
				export_adapt.set_all_export (export_status)
			else
				create vlel1
				vlel1.set_class (System.current_class)
				vlel1.set_parent (parent.parent)
				vlel1.set_location (start_location)
				Error_handler.insert_error (vlel1)
			end
		end

end -- class ALL_AS
