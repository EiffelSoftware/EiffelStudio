indexing
	description: "Node for NONE type."
	date: "$Date$"
	revision: "$Revision$"

class NONE_TYPE_AS

inherit
	TYPE_AS

create
	initialize

feature {NONE} -- Initialize

	initialize is
		do
		end
		
feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_none_type_as (Current)
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

feature -- Comparison

	is_equivalent (o: like Current): BOOLEAN is
		do
			Result := True
		end

feature -- Output

	dump: STRING is "NONE"
			-- Dumped trace

end -- class NONE_TYPE_AS
