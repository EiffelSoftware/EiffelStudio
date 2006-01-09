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

	initialize (f: like feature_name; a_as: like address_symbol) is
			-- Create a new ADDRESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
			address_symbol := a_as
		ensure
			feature_name_set: feature_name = f
			address_symbol_set: address_symbol = a_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_as (Current)
		end

feature -- Roundtrip

	address_symbol: SYMBOL_AS
			-- Symbol "$" associated with this structure

feature -- Attribute

	feature_name: FEATURE_NAME
			-- Feature name to address

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := feature_name.complete_start_location (a_list)
			else
				Result := address_symbol.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := feature_name.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name)
		end

end -- class ADDRESS_AS
