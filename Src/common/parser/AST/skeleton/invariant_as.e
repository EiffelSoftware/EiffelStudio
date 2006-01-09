indexing

	description: "Description of class invariant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INVARIANT_AS

inherit
	AST_EIFFEL

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like assertion_list; oms_count: like once_manifest_string_count; i_as: like invariant_keyword) is
			-- Create a new INVARIANT AST node.
		require
			valid_oms_count: oms_count >= 0
		do
			full_assertion_list := a
			assertion_list := filter_tagged_list (full_assertion_list)
			once_manifest_string_count := oms_count
			invariant_keyword := i_as
		ensure
			full_assertion_list_set: full_assertion_list = a
			once_manifest_string_count_set: once_manifest_string_count = oms_count
			invariant_keyword_set: invariant_keyword = i_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_invariant_as (Current)
		end

feature -- Roundtrip

	full_assertion_list: like assertion_list
			-- Assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

	invariant_keyword: KEYWORD_AS
			-- Keyword "invariant" associated with this structure

feature -- Attribute

	assertion_list: EIFFEL_LIST [TAGGED_AS]
			-- Assertion list

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if assertion_list /= Void then
					Result := assertion_list.complete_start_location (a_list)
				else
					Result := null_location
				end
			else
				Result := invariant_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if assertion_list /= Void then
					Result := assertion_list.complete_end_location (a_list)
				else
					Result := null_location
				end
			else
				if full_assertion_list /= Void then
					Result := full_assertion_list.complete_end_location (a_list)
				else
					Result := invariant_keyword.complete_end_location (a_list)
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: optimize (order doesn't matter)
			Result := equivalent (assertion_list, other.assertion_list)
		end

feature {COMPILER_EXPORTER}

	set_assertion_list (a: like assertion_list) is
		do
			full_assertion_list := a
			assertion_list := filter_tagged_list (full_assertion_list)
		end

end -- class INVARIANT_AS
