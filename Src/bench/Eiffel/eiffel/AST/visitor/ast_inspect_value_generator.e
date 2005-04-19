indexing
	description: "Check validity of inspect value of an ATOMIC_AS node"
	date: "$Date$"
	revision: "$Revision$"

class
	AST_INSPECT_VALUE_GENERATOR

inherit
	AST_NULL_VISITOR
		redefine
			process_static_access_as,
			process_id_as,
			process_char_as,
			process_integer_as
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

feature -- Access

	is_valid_inspect_value (a_feat_tbl: FEATURE_TABLE; a_node: ATOMIC_AS; a_type: TYPE_A): BOOLEAN is
			-- Associated UNIQUE_I instance of `a_node' if `a_node' represents a unique constant.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_node_not_void: a_node /= Void
			a_type_not_void: a_type /= Void
		do
			current_feature_table := a_feat_tbl
			expected_value_type := a_type
			is_for_validity := True
			a_node.process (Current)
			Result := is_valid
			current_feature_table := Void
			expected_value_type := Void
		end

	inspect_value (a_feat_tbl: FEATURE_TABLE; a_node: ATOMIC_AS; a_type: TYPE_A): INTERVAL_VAL_B is
			-- Last computed instance.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_node_not_void: a_node /= Void
			a_type_not_void: a_type /= Void
			is_valid: is_valid_inspect_value (a_feat_tbl, a_node, a_type)
		do
			current_feature_table := a_feat_tbl
			expected_value_type := a_type
			is_for_validity := False
			a_node.process (Current)
			Result := last_interval
			last_interval := Void
			current_feature_table := Void
			expected_value_type := Void
		ensure
			inspect_value_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	current_feature_table: FEATURE_TABLE
			-- Feature table in which we resolve `unique_constant'

	is_valid: BOOLEAN
			-- Is last computation valid?

	is_for_validity: BOOLEAN
			-- Is visitor doing validity or generation?

	expected_value_type: TYPE_A
			-- Expected type for inspect value

	last_interval: INTERVAL_VAL_B
			-- Last computed interval node

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		local
			l_constant_i: CONSTANT_I
			l_type: TYPE_A
		do
				-- At this stage `l_as' has already been type checked thus `l_type' will be valid.
			l_type := type_checker.solved_type (l_as.class_type)
			l_constant_i ?= l_type.associated_class.feature_table.item (l_as.feature_name)
			if is_for_validity then
				is_valid := l_constant_i /= Void and then l_constant_i.value.valid_type (expected_value_type)
			else
				check
					l_constant_i_not_void: l_constant_i /= Void
				end
				last_interval := l_constant_i.value.inspect_value (expected_value_type)
			end
		end

	process_id_as (l_as: ID_AS) is
		local
			l_constant_i: CONSTANT_I
		do
			l_constant_i ?= current_feature_table.item (l_as)
			if is_for_validity then
				is_valid := l_constant_i /= Void and then l_constant_i.value.valid_type (expected_value_type)
			else
				check
					l_constant_i_not_void: l_constant_i /= Void
				end
				last_interval := l_constant_i.value.inspect_value (expected_value_type)
			end
		end

	process_char_as (l_as: CHAR_AS) is
		do
			if is_for_validity then
				is_valid := expected_value_type.is_character
			else
				create {CHAR_VAL_B} last_interval.make (l_as.value)
			end
		end

	process_integer_as (l_as: INTEGER_CONSTANT) is
		do
			if is_for_validity then
				is_valid := l_as.valid_type (expected_value_type)
			else
				last_interval := l_as.inspect_value (expected_value_type)
			end
		end
		
end
