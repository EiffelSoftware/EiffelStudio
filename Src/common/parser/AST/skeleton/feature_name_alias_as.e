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
			end_location,
			has_convert_mark,
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

	initialize (feature_id: ID_AS; alias_id: STRING_AS; convert_status: BOOLEAN; a_as, c_as: KEYWORD_AS) is
			-- Create feature name object with given characteristics.
		require
			feature_id_not_void: feature_id /= Void
			alias_id_not_void: alias_id /= Void
			alias_id_not_empty: not alias_id.value.is_empty
			valid_alias_name:
				is_bracket_alias_name (alias_id.value) or else
				is_valid_binary_operator (alias_id.value) or else
				is_valid_unary_operator (alias_id.value)
		do
			initialize_id (feature_id)
			alias_name := alias_id
			has_convert_mark := convert_status
			if not is_bracket then
					-- Make sure we do not get "prefix %"or%"" or alike
				if is_valid_unary_operator (alias_id.value) then
					set_is_unary
				else
					set_is_binary
				end
			end
			alias_keyword := a_as
			convert_keyword := c_as
		ensure
			feature_name_set: feature_name = feature_id
			alias_name_set: alias_name = alias_id
			has_convert_mark_set: has_convert_mark = convert_status
			alias_keyword_set: alias_keyword = a_as
			convert_keyword_set: convert_keyword = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feature_name_alias_as (Current)
		end

feature -- Roundtrip

	alias_keyword: KEYWORD_AS
		-- Keyword "alias" associated with this structure.

	convert_keyword: KEYWORD_AS
		-- Keyword "convert" associated with this structure.

feature -- Access

	alias_name: STRING_AS
			-- Operator associated with the feature

	internal_alias_name: STRING is
			-- Operator associated with the feature (if any)
			-- augmented with information about its arity in case of operator alias
		do
			if is_bracket then
				Result := alias_name.value
			else
				Result := get_internal_alias_name
			end
		end

	has_convert_mark: BOOLEAN
			-- Is operator marked with "convert"?

feature -- Status report

	is_bracket: BOOLEAN is
			-- Is feature alias (if any) bracket?
		do
			Result := alias_name.value.item (1) = '['
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

feature -- Location

	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := alias_name
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object?
		do
				-- There is no need to check whether both alias names are Bracket,
				-- because there is a check that they have the same alias name
			Result :=
				Precursor (other) and then equivalent (alias_name, other.alias_name) and then
				other.has_convert_mark = has_convert_mark and then other.is_binary = is_binary
		end

feature {NONE} -- Status

	internal_is_binary: BOOLEAN
			-- Is operator binary (unless it is bracket)?

invariant

	alias_name_not_void: alias_name /= Void
	alias_name_not_empty: not alias_name.value.is_empty

end -- class FEATURE_NAME_ALIAS_AS
