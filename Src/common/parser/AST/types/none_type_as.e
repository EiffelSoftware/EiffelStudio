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

	initialize (c: like class_name_literal) is
		do
			class_name_literal := c
		ensure
			class_name_literal_set: class_name_literal = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_none_type_as (Current)
		end

feature -- Roundtrip

	class_name_literal: ID_AS
			-- Class name literal

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := null_location
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
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
