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
			is_equivalent,
			process
		end

create
	initialize

feature {NONE} -- Creation

	initialize (feature_id: ID_AS; alias_id: like alias_name; frozen_status: BOOLEAN; convert_status: BOOLEAN) is
			-- Create feature name object with given characteristics.
		require
			feature_id_not_void: feature_id /= Void
			alias_id_not_void: alias_id /= Void
		do
			initialize_id (feature_id, frozen_status)
			alias_name := alias_id
			has_convert_mark := convert_status
		ensure
			feature_name_set: feature_name = feature_id
			alias_name_set: alias_name = alias_id
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

	alias_name: STRING_AS
			-- Operator associated with the feature

	has_convert_mark: BOOLEAN
			-- Is operator marked with "convert"?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object?
		do
			Result := Precursor (other) and then has_convert_mark = other.has_convert_mark and then
				equivalent (alias_name, other.alias_name)
		end

invariant
	alias_name_not_void: alias_name /= Void

end
