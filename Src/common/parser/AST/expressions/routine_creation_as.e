indexing
	description: "Abstract description of an Eiffel routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE_CREATION_AS

inherit
	EXPR_AS

--create
--	initialize

feature {NONE} -- Initialization

	initialize (t: like target; f: like feature_name; o: like operands; ht: BOOLEAN) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		require
			f_not_void: f /= Void
		do
			target := t
			feature_name := f
			internal_operands := o
			has_target := ht
		ensure
			target_set: target = t
			feature_name_set: feature_name = f
			internal_operands_set: internal_operands = o
			has_target_set: has_target = ht
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_routine_creation_as (Current)
		end

feature -- Roundtrip

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with this structure

	set_lparan_symbol (s_as: SYMBOL_AS) is
			-- Set `lparan_symbol' with `s_as'.
		do
			lparan_symbol := s_as
		ensure
			lparan_symbol_set: lparan_symbol = s_as
		end

	set_rparan_symbol (s_as: SYMBOL_AS) is
			-- Set `rparan_symbol' with `s_as'.
		do
			rparan_symbol := s_as
		ensure
			rparan_symbol_set: rparan_symbol = s_as
		end

feature -- Attributes

	target: OPERAND_AS
			-- Target operand used when the feature will be called.

	feature_name: ID_AS
			-- Feature name.

	operands : EIFFEL_LIST [OPERAND_AS] is
			-- List of operands used by the feature when called.
		do
			if internal_operands = Void or else internal_operands.is_empty then
				Result := Void
			else
				Result := internal_operands
			end
		end

	has_target: BOOLEAN
			-- Does Current has a target?

feature -- Roundtrip

	internal_operands : EIFFEL_LIST [OPERAND_AS]
			-- Internal list of operands used by the feature when called.

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if target /= Void then
				Result := target.start_location
			end
			if Result = Void or else Result.is_null then
				Result := feature_name.start_location
			end
		end

	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if operands /= Void then
				Result := operands.end_location
			else
				Result := feature_name.end_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target) and then
					  has_target = other.has_target
		end

invariant
	feature_name_not_void: feature_name /= Void

end -- class ROUTINE_CREATION_AS


