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

	initialize (cr: BOOLEAN; fn: FEATURE_NAME; t: EIFFEL_LIST [EIFFEL_TYPE]) is
			-- Create a new CONVERT_FEAT_AS clause AST node.
		do
			is_creation_procedure := cr
			feature_name := fn
			conversion_types := t
		ensure
			is_creation_procedure_set: is_creation_procedure = cr
			feature_name_set: feature_name = fn
			conversion_types_set: conversion_types = t
		end

feature -- Access

	is_creation_procedure: BOOLEAN
			-- Is current conversion feature specified as a creation procedure?
			
	feature_name: FEATURE_NAME
			-- Name of conversion feature.
			
	conversion_types: EIFFEL_LIST [AST_EIFFEL]
			-- Types	 to which we can either convert to or from.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_convert_feat_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

end -- class CONVERT_FEAT_AS
