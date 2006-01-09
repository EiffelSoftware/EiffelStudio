indexing
	description: "Abstract description of an Eiffel infixed or prefixed feature name."
	date: "$Date$"
	revision: "$Revision$"

class INFIX_PREFIX_AS

inherit
	FEATURE_NAME
		rename
			internal_alias_name as internal_name,
			is_binary as is_infix,
			is_unary as is_prefix
		export
			{AST_VISITOR} frozen_keyword
		redefine
			alias_name,
			is_equivalent,
			is_infix, is_prefix, visual_name

		end

create
	initialize

feature {NONE} -- Initialization

	initialize (op: STRING_AS; inf: BOOLEAN; l:KEYWORD_AS) is
			-- Create a new INFIX AST node.
			-- `inf' is `is_infix', `l' is a start location.
		require
			op_not_void: op /= Void
		do
			is_infix := inf
			alias_name := op
			create internal_name.initialize (get_internal_alias_name)
			internal_name.set_position (l.line, l.column, l.position, op.position - l.position + op.location_count)
			infix_prefix_keyword := l
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_infix_prefix_as (Current)
		end

feature -- Roundtrip

	infix_prefix_keyword: KEYWORD_AS
		-- Keyword "infix" or "prefix" associated with this structure.

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

	alias_name: STRING_AS
			-- Operator name associated with the feature

	visual_name: STRING is
			-- Visual name of fix operator
		do
			Result := alias_name.value
		end

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

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if frozen_keyword /= Void then
				Result := frozen_keyword.complete_start_location (a_list)
			end
			if Result = Void or else Result.is_null then
				if a_list = Void then
						-- Non-roundtrip mode
					Result := internal_name.complete_start_location (a_list)
				else
						-- Roundtrip mode
					Result := infix_prefix_keyword.complete_start_location (a_list)
				end
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := internal_name.complete_end_location (a_list)
		end

invariant
	alias_name_not_void: alias_name /= Void

end
