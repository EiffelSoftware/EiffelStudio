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

	 initialize (a_as: KEYWORD_AS) is
			-- Create a new ALL AST node.
		do
			-- Do nothing.
			all_keyword := a_as
		ensure
			all_keyword_set: all_keyword = a_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_all_as (Current)
		end

feature -- Roundtrip

	all_keyword: KEYWORD_AS
		-- Keyword "all" assoicated with this structure

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := null_location
			else
				Result := all_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := null_location
			else
				Result := all_keyword.complete_end_location (a_list)
			end
		end

end -- class ALL_AS
