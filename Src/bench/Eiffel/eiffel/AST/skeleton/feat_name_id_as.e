indexing
	description: "Node for Eiffel feature name. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class FEAT_NAME_ID_AS

inherit
	FEATURE_NAME
		rename
			internal_name as feature_name
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name; b: BOOLEAN) is
			-- Create a new FEAT_NAME_ID AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
			is_frozen := b
		ensure
			feature_name_set: feature_name = f
			is_frozen_set: is_frozen = b
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feat_name_id_as (Current)
		end

feature -- Attributes

	feature_name: ID_AS
			-- Feature name

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_frozen = other.is_frozen and then
				equivalent (feature_name, other.feature_name)
		end

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			normal_feature: like Current
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
			elseif feature_name = Void then
				Result := False
			elseif normal_feature.feature_name = Void then
				Result := True
			else
				Result := feature_name < normal_feature.feature_name
			end
		end

invariant
	feature_name_not_void: feature_name /= Void

end -- class FEAT_NAME_ID_AS
