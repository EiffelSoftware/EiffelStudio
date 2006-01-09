indexing
	description: "Abstract syntax node representing a conversion feature."
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERT_FEAT_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (cr: BOOLEAN; fn: FEATURE_NAME; t: TYPE_LIST_AS; l_as, r_as, c_as: SYMBOL_AS) is
			-- Create a new CONVERT_FEAT_AS clause AST node.
		require
			fn_not_void: fn /= Void
			t_not_void: t /= Void
			t_not_empty: not t.is_empty
		do
			is_creation_procedure := cr
			feature_name := fn
			conversion_types := t
			lparan_symbol := l_as
			rparan_symbol := r_as
			colon_symbol := c_as
		ensure
			is_creation_procedure_set: is_creation_procedure = cr
			feature_name_set: feature_name = fn
			conversion_types_set: conversion_types = t
			lparan_symbol_set: lparan_symbol = l_as
			rparan_symbol_set: rparan_symbol = r_as
			colon_symbol_set: colon_symbol = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_convert_feat_as (Current)
		end

feature -- Roundtrip

	lparan_symbol: SYMBOL_AS
		-- Symbol "(" associated with this structure

	rparan_symbol: SYMBOL_AS
		-- Symbol ")" associated with this structure

	colon_symbol: SYMBOL_AS
		-- Symbol colon associated with this structure

feature -- Access

	is_creation_procedure: BOOLEAN
			-- Is current conversion feature specified as a creation procedure?

	feature_name: FEATURE_NAME
			-- Name of conversion feature.

	conversion_types: TYPE_LIST_AS
			-- Types to which we can either convert to or from.

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := feature_name.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := conversion_types.complete_end_location (a_list)
			else
				if rparan_symbol /= Void then
					Result := rparan_symbol.complete_end_location (a_list)
				else
					Result := conversion_types.complete_end_location (a_list)
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_creation_procedure = other.is_creation_procedure and
				feature_name.is_equivalent (other.feature_name) and
				conversion_types.is_equivalent (other.conversion_types)
		end

invariant
	feature_name_not_void: feature_name /= Void
	conversion_types_not_void: conversion_types /= Void
	conversion_types_not_empty: not conversion_types.is_empty

end -- class CONVERT_FEAT_AS
