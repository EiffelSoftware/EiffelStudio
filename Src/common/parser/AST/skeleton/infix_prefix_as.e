indexing
	description: "Abstract description of an Eiffel infixed or prefixed feature name."
	date: "$Date$"
	revision: "$Revision$"

class INFIX_PREFIX_AS

inherit
	FEATURE_NAME
		rename
			alias_name as visual_name,
			internal_alias_name as internal_name,
			is_binary as is_infix,
			is_unary as is_prefix
		redefine
			is_infix, is_prefix, visual_name,
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (op: STRING_AS; b: BOOLEAN; inf: BOOLEAN) is
			-- Create a new INFIX AST node.
			-- `b' is `is_frozen', `inf' is `is_infix'.
		require
			op_not_void: op /= Void
		do
			is_infix := inf
			is_frozen := b
			visual_name := op.value
			create internal_name.initialize (get_internal_alias_name)
			internal_name.set_position (op.line, op.column, op.position, internal_name.count)
		ensure
			is_frozen_set: is_frozen = b
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_infix_prefix_as (Current)
		end

feature -- Properties

	is_infix: BOOLEAN
			-- is the feature name an infixed notation ?

	is_prefix: BOOLEAN is
			-- Is the feature a prefix notation?
		do
			Result := not is_infix
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (internal_name_id, other.internal_name_id) and
				is_infix = other.is_infix and
				is_frozen = other.is_frozen
		end

feature -- Access

	visual_name: STRING
			-- Visual name of fix operator

	internal_name: ID_AS
			-- Internal name used by the compiler

feature -- Conveniences

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			infix_feature: INFIX_PREFIX_AS
			normal_feature: FEAT_NAME_ID_AS
		do
			normal_feature ?= other
			infix_feature ?= other

			check
				Void_normal_feature: normal_feature = Void implies infix_feature /= Void
				Void_infix_feature: infix_feature = Void implies normal_feature /= Void
			end

			if infix_feature = Void then
				Result := False
			else
				Result := visual_name < infix_feature.visual_name
			end
		end

end -- class INFIX_PREFIX_AS
