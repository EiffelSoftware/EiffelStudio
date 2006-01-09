indexing
	description	: "AST representation of a require statement."
	date		: "$Date$"
	revision	: "$Revision$"

class REQUIRE_AS

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
			require_keyword := k_as
		ensure
			require_keyword_set: require_keyword = k_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_require_as (Current)
		end

feature -- Roundtrip

	require_keyword: KEYWORD_AS
		-- Keyword "require" accosiated with this structure.

feature -- Properties

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
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
				Result := require_keyword.complete_start_location (a_list)
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
					Result := require_keyword.complete_end_location (a_list)
				end
			end
		end

end -- class REQUIRE_AS
