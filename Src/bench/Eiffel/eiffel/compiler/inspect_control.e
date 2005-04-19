indexing
	description: "Controler of multi-branch instruction"
	date: "$Date$"
	revision: "$Revision$"

class INSPECT_CONTROL

inherit
	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialize
	
	make is
		do
			create unique_names.make
			create intervals.make
			create unique_constant
			create inspect_checker
		end

feature -- Access

	node: INSPECT_AS
			-- Node currently checked

	feature_table: FEATURE_TABLE
			-- Feature table of the class where `node' is written in.

	type: TYPE_A
			-- Type of inspect expression

	interval: INTERVAL_AS
			-- Current interval processed

	positive_value_found: BOOLEAN
			-- Is a positive value involved in the choices ?

	positive_value: ATOMIC_AS
			-- One of the positive values found (error report)

	unique_names: LINKED_SET [STRING]
			-- Set of unique names already used 
	
	last_class: CLASS_C
			-- Class for controling uniques

	intervals: SORTED_TWO_WAY_LIST [INTERVAL_B]
			-- Sorted list of intervals

feature -- Settings

	wipe_out is
		do
			unique_names.wipe_out
			positive_value := Void
			type := Void
			node := Void
			feature_table := Void
			interval := Void
			intervals.wipe_out
			last_class := Void
		end

	set_node (n: like node) is
			-- Assign `n' to `node'.
		do
			node := n
		ensure
			node_set: node = n
		end

	set_type (expression_type: like type) is
			-- Set `type' to `expression_type'.
		require
			valid_type: expression_type.is_character or expression_type.is_integer or expression_type.is_natural
		do
			type := expression_type
		ensure
			type_set: type = expression_type
		end

	set_interval (i: INTERVAL_AS) is
			-- Assign `i' to `interval'.
		do
			interval := i
		end

	set_feature_table (t: FEATURE_TABLE) is
			-- Assign `t' to `feature_table'.
		do
			feature_table := t
		end

feature -- Record dependances

	record_dependances (a_node: INTERVAL_AS) is
			-- Record potential dependances.
		require
			a_node_not_void: a_node /= Void
			good_interval: is_good_interval (a_node)
		local
			l_constant_i: CONSTANT_I
			l_depend_unit: DEPEND_UNIT
			l_id: ID_AS
		do
			l_id ?= a_node.lower
			if l_id /= Void then
				l_constant_i ?= context.current_class.feature_table.item (l_id)
				create l_depend_unit.make (context.current_class.class_id, l_constant_i)
				context.supplier_ids.extend (l_depend_unit)
			end
			l_id ?= a_node.upper
			if l_id /= Void then
				l_constant_i ?= context.current_class.feature_table.item (l_id)
				create l_depend_unit.make (context.current_class.class_id, l_constant_i)
				context.supplier_ids.extend (l_depend_unit)
			end
		end

feature -- Status report

	is_good_interval (an_interval: INTERVAL_AS): BOOLEAN is
			-- Is the current interval a good one?
			-- (Are its bounds constant and of the same type
			-- as inspect expression?)
		require
			an_interval_not_void: an_interval /= Void
		local
			l_atomic: ATOMIC_AS
		do
			Result := inspect_checker.is_valid_inspect_value (feature_table, an_interval.lower, type)
			if Result then
				l_atomic := an_interval.upper
				Result := l_atomic = Void or else
					inspect_checker.is_valid_inspect_value (feature_table, l_atomic, type)
			end
		end

	interval_byte_node: INTERVAL_B is
			-- Calculate a byte node that corresponds to the current interval
		require
			non_void_type: type /= Void
			interval_exists: interval /= Void
			good_integer_interval: is_good_interval (interval)
		local
			l_atomic: ATOMIC_AS
			lower_bound: INTERVAL_VAL_B
			upper_bound: INTERVAL_VAL_B
			vomb3: VOMB3
			i: like intervals
		do
			l_atomic := interval.lower
			lower_bound := inspect_value (l_atomic)
			l_atomic ?= interval.upper
			if l_atomic = Void then
				upper_bound := lower_bound
			else
				upper_bound := inspect_value (l_atomic)
			end
			if lower_bound <= upper_bound then
				Result := lower_bound.inspect_interval (upper_bound)
				from
					i := intervals
					i.start
				until
					i.after
				loop
					if not Result.disjunction (i.item) then
							-- Error
						create vomb3
						context.init_error (vomb3)
						vomb3.set_interval (Result.intersection (i.item))
						vomb3.set_location (interval.end_location)
						Error_handler.insert_error (vomb3)
					end
					i.forth
				end
				i.extend (Result)
			end
		end

feature {NONE} -- Implementation: Access

	unique_constant: AST_UNIQUE_CONSTANT
			-- Get UNIQUE_I instance from an ATOMIC_AS instance if it represents a unique constant

	inspect_checker: AST_INSPECT_VALUE_GENERATOR
			-- Check and generate `inspect_value' for an ATOMIC_AS node

feature {NONE} -- Implementation

	inspect_value (bound: ATOMIC_AS): INTERVAL_VAL_B is
			-- Inspect value associated to `bound'
		require
			type_not_void: type /= Void
			bound_not_void: bound /= Void
			valid_bound_type: inspect_checker.is_valid_inspect_value (feature_table, bound, type)
		local
			constant_i: CONSTANT_I
			constant_name: STRING
			written_class: CLASS_C
			make_vomb5: BOOLEAN
			vomb5: VOMB5
			vomb4: VOMB4
			vomb6: VOMB6
		do
			Result := inspect_checker.inspect_value (feature_table, bound, type)
			constant_i := unique_constant.unique_constant (feature_table, bound)
			if constant_i /= Void then
				constant_name := constant_i.feature_name
				if unique_names.has (constant_name) then
						-- Error
					create vomb4
					context.init_error (vomb4)
					vomb4.set_unique_feature (constant_i)
					vomb4.set_location (bound.start_location)
					Error_handler.insert_error (vomb4)
				else
					unique_names.extend (constant_name)
					written_class := constant_i.written_class
					if last_class = Void then
						last_class := written_class
					elseif last_class /= written_class then
							-- Error
						create vomb6
						context.init_error (vomb6)
						vomb6.set_unique_feature (constant_i)
						vomb6.set_written_class (last_class)
						vomb6.set_location (bound.start_location)
						Error_handler.insert_error (vomb6)
					end
				end
				make_vomb5 := positive_value /= Void
			elseif Result.is_allowed_unique_value then
				positive_value := bound
				make_vomb5 := not unique_names.is_empty
			end
			if make_vomb5 then
				create vomb5
				context.init_error (vomb5)
				vomb5.set_positive_value (positive_value)
				vomb5.set_location (bound.start_location)
				Error_handler.insert_error (vomb5)
			end
		ensure
			result_not_void: Result /= Void
		end

invariant
	valid_type: type /= Void implies (type.is_integer or type.is_character)

end
