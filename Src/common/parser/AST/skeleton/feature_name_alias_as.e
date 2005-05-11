indexing
	description: "Feature name with alias."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_NAME_ALIAS_AS

inherit
	FEAT_NAME_ID_AS
		rename
			initialize as initialize_id
		redefine
			alias_name,
			internal_alias_name,
			is_binary,
			is_bracket,
			is_equivalent,
			is_unary,
			process,
			set_is_binary,
			set_is_unary
		end

create
	initialize

feature {NONE} -- Creation

	initialize (feature_id: ID_AS; alias_id: STRING_AS; frozen_status: BOOLEAN; convert_status: BOOLEAN) is
			-- Create feature name object with given characteristics.
		require
			feature_id_not_void: feature_id /= Void
			alias_id_not_void: alias_id /= Void
			alias_id_not_empty: not alias_id.value.is_empty
		do
			initialize_id (feature_id, frozen_status)
			alias_name := alias_id.value
			has_convert_mark := convert_status
		ensure
			feature_name_set: feature_name = feature_id
			alias_name_set: alias_name = alias_id.value
			is_frozen_set: is_frozen = frozen_status
			has_convert_mark_set: has_convert_mark = convert_status
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feature_name_alias_as (Current)
		end

feature -- Access

	alias_name: STRING
			-- Operator associated with the feature

	internal_alias_name: STRING is
			-- Operator associated with the feature (if any)
			-- augmented with information about its arity
		do
			Result := get_internal_alias_name
		end

	has_convert_mark: BOOLEAN
			-- Is operator marked with "convert"?

feature -- Status report

	is_bracket: BOOLEAN is
			-- Is feature alias (if any) bracket?
		do
			Result := alias_name.item (1) = '['
		end

	is_binary: BOOLEAN is
			-- Is feature alias (if any) a binary operator?
		do
			Result := not is_bracket and internal_is_binary
		end

	is_unary: BOOLEAN is
			-- Is feature alias (if any) an unary operator?
		do
			Result := not is_bracket and not internal_is_binary
		end

feature -- Status setting

	set_is_binary is
			-- Mark operator as binary.
		do
			internal_is_binary := True
		end

	set_is_unary is
			-- Mark operator as unary.
		do
			internal_is_binary := False
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object?
		do
			Result := Precursor (other) and then other.has_convert_mark = has_convert_mark and then
				other.alias_name /= Void and then other.alias_name.is_equal (alias_name) and then
				other.is_bracket = is_bracket and then other.is_binary = is_binary
		end

feature {NONE} -- Status

	internal_is_binary: BOOLEAN
			-- Is operator binary (unless it is bracket)?

invariant
	alias_name_not_void: alias_name /= Void
	alias_name_not_empty: not alias_name.is_empty

end
