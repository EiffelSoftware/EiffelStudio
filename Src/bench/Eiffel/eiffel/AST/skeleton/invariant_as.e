indexing

	description: "Description of class invariant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INVARIANT_AS

inherit
	AST_EIFFEL
		redefine
			type_check, byte_node
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like assertion_list; oms_count: like once_manifest_string_count) is
			-- Create a new INVARIANT AST node.
		require
			valid_oms_count: oms_count >= 0
		do
			assertion_list := a
			once_manifest_string_count := oms_count
		ensure
			assertion_list_set: assertion_list = a
			once_manifest_string_count_set: once_manifest_string_count = oms_count
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_invariant_as (Current)
		end

feature -- Attribute

	assertion_list: EIFFEL_LIST [TAGGED_AS]
			-- Assertion list

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if assertion_list /= Void then
				Result := assertion_list.start_location
			else
				Result := null_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if assertion_list /= Void then
				Result := assertion_list.end_location
			else
				Result := null_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: optimize (order doesn't matter)
			Result := equivalent (assertion_list, other.assertion_list)
		end

feature -- Type check and byte code

	type_check is
			-- Type check invariant clause
		do
			if assertion_list /= Void then
					-- Set the access id analysis level to `is_checking_invariant': only
				   -- features are taken into account.
				context.begin_expression
				context.set_is_checking_invariant (True)
				assertion_list.type_check
					-- Reset the level
				context.set_is_checking_invariant (False)
				context.pop (1)
			end
		end

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Invariant byte code
		do
			if assertion_list /= Void then
					-- Intialization of the access line
				context.access_line.start

				Result := assertion_list.byte_node
			end
		end
	
feature {COMPILER_EXPORTER}

	set_assertion_list (a: like assertion_list) is
		do
			assertion_list := a
		end

end -- class INVARIANT_AS
