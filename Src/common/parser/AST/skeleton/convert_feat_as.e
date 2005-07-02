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

	initialize (cr: BOOLEAN; fn: FEATURE_NAME; t: TYPE_LIST_AS) is
			-- Create a new CONVERT_FEAT_AS clause AST node.
		require
			fn_not_void: fn /= Void
			t_not_void: t /= Void
			t_not_empty: not t.is_empty
		do
			is_creation_procedure := cr
			feature_name := fn
			conversion_types := t
		ensure
			is_creation_procedure_set: is_creation_procedure = cr
			feature_name_set: feature_name = fn
			conversion_types_set: conversion_types = t
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_convert_feat_as (Current)
		end

feature -- Access

	is_creation_procedure: BOOLEAN
			-- Is current conversion feature specified as a creation procedure?
			
	feature_name: FEATURE_NAME
			-- Name of conversion feature.
			
	conversion_types: TYPE_LIST_AS
			-- Types to which we can either convert to or from.

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := feature_name.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := conversion_types.end_location
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
