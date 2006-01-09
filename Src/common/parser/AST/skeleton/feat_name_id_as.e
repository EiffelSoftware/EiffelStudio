indexing
	description: "Node for Eiffel feature name. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class FEAT_NAME_ID_AS

inherit
	FEATURE_NAME
		rename
			internal_name as feature_name
		export
			{AST_VISITOR}frozen_keyword
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name) is
			-- Create a new FEAT_NAME_ID AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
		ensure
			feature_name_set: feature_name = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feat_name_id_as (Current)
		end

feature -- Access

	feature_name: ID_AS
			-- Feature name

	internal_alias_name: STRING is
			-- Operator associated with the feature (if any)
			-- augmented with information about its arity
		do
				-- Void here
		end

	alias_name: STRING_AS is
			-- Operator name associated with the feature (if any)
		do
				-- Void here
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_frozen = other.is_frozen and then
				equivalent (feature_name, other.feature_name)
		end

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			normal_feature: FEAT_NAME_ID_AS
			infix_feature: INFIX_PREFIX_AS
		do
			normal_feature ?= other
			infix_feature ?= other
			check
				Void_normal_feature: normal_feature = Void implies infix_feature /= Void
				Void_infix_feature: infix_feature = Void implies normal_feature /= Void
			end

			if infix_feature /= Void then
				Result := True
			else
				Result := feature_name < normal_feature.feature_name
			end
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if frozen_keyword /= Void then
				Result := frozen_keyword.complete_start_location (a_list)
			end
			if Result = Void or else Result.is_null then
				Result := feature_name.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := feature_name.complete_end_location (a_list)
		end

invariant
	feature_name_not_void: feature_name /= Void

end -- class FEAT_NAME_ID_AS
