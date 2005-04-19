indexing
	description: 
		"AST representation of an Eiffel function pointer."
	date: "$Date$"
	revision: "$Revision$"

class
	ADDRESS_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name) is
			-- Create a new ADDRESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
		ensure
			feature_name_set: feature_name = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_as (Current)
		end

feature -- Attribute

	feature_name: FEATURE_NAME
			-- Feature name to address

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := feature_name.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := feature_name.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name)
		end

end -- class ADDRESS_AS
