indexing
	description: "Node for NONE type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class NONE_TYPE_AS

inherit
	TYPE_AS
		redefine
			append_to
		end

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
		
feature

	append_to (st: STRUCTURED_TEXT) is
		do
			actual_type.append_to (st)
		end

	actual_type: NONE_A is
			-- Actual integer type
		once
			create Result
		end

	dump: STRING is "NONE"
			-- Dumped trace

end -- class NONE_TYPE_AS
