indexing
	description	: "AST representation of an `ensure' structure."
	date		: "$Date$"
	revision	: "$Revision$"

class ENSURE_AS

inherit
	ASSERT_LIST_AS
		redefine
			process
		end

create
	make

feature -- Initialization

	make (a: like assertions; k_as: KEYWORD_AS) is
			-- Create new REQUIRE AST node.
		do
			initialize (a)
			ensure_keyword := k_as
		ensure
			ensure_keyword_set: ensure_keyword = k_as
		end

feature -- Roundtrip

	ensure_keyword: KEYWORD_AS
		-- Keyword "rensure" accosiated with this structure.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_ensure_as (Current)
		end

feature -- Properties

	is_then: BOOLEAN is
			-- Is the assertion list an ensure then part ?
		do
			-- Do nothing
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if assertions /= Void then
					Result := assertions.complete_start_location (a_list)
				else
					Result := null_location
				end
			else
				Result := ensure_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if assertions /= Void then
					Result := assertions.complete_end_location (a_list)
				else
					Result := null_location
				end
			else
				if full_assertion_list /= Void then
					Result := full_assertion_list.complete_end_location (a_list)
				else
					Result := ensure_keyword.complete_end_location (a_list)
				end
			end
		end

end -- class ENSURE_AS
