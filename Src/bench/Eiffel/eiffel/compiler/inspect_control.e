-- Controler of multi-branch instruction

class INSPECT_CONTROL 

inherit

	SHARED_ERROR_HANDLER
	SHARED_AST_CONTEXT
	COMPILER_EXPORTER
	SHARED_WORKBENCH
		export
			{NONE} all
		end

create

	make
	
feature 

	node: INSPECT_AS
			-- Node currently checked

	feature_table: FEATURE_TABLE
			-- Feature table of the class where `node' is written in.

	type: TYPE_A
			-- Type of inspect expression

	interval: INTERVAL_AS
			-- Current interval processed

	unique_found: BOOLEAN
			-- Is a unique feature involved in the choices ?

	positive_value_found: BOOLEAN
			-- Is a positive value involved in the choices ?

	positive_value: INTEGER
			-- One of the positive values found (error report)

	unique_names: LINKED_SET [STRING]
			-- Set of unique names already used 
	
	last_class: CLASS_C
			-- Class for controling uniques

	intervals: SORTED_TWO_WAY_LIST [INTERVAL_B]
			-- Sorted list of intervals

	make is
		do
			create unique_names.make
			create intervals.make
		end

	wipe_out is
		do
			unique_names.wipe_out
			positive_value_found := False
			unique_found := False
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
			valid_type: expression_type.is_integer or else expression_type.is_character
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

	interval_byte_node: INTERVAL_B is
			-- Calculate a byte node that corresponds to the current interval
		require
			non_void_type: type /= Void
			interval_exists: interval /= Void
			good_integer_interval: interval.is_good_interval
		local
			upper: ATOMIC_AS
			lower_bound: INTERVAL_VAL_B
			upper_bound: INTERVAL_VAL_B
			vomb3: VOMB3
			i: like intervals
		do
			lower_bound := make_bound (interval.lower)
			upper := interval.upper
			if upper = Void then
				upper_bound := lower_bound
			else
				upper_bound := make_bound (upper)
			end
			Result := lower_bound.make_interval (upper_bound)
			if Result.is_good_range then
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
						Error_handler.insert_error (vomb3)
					end
					i.forth
				end
				i.extend (Result)
			else
				Result := Void
			end
		end

feature {NONE} -- Implementation

	make_bound (bound: ATOMIC_AS): INTERVAL_VAL_B is
			-- Create bound associated to `bound'.
		require
			type_not_void: type /= Void
			bound_not_void: bound /= Void
			valid_bound_type: bound.is_inspect_value (type)
		do
			if type.is_character then
				Result := bound.make_character
			else
				Result := make_integer (bound)
			end
		ensure
			result_not_void: Result /= Void
		end

	make_integer (bound: ATOMIC_AS): INT_VAL_B is
			-- Integer bound associated to `bound'.
		require
			type_not_void: type /= Void
			bound_not_void: bound /= Void
			valid_bound_type: bound.good_integer
		local
			int_bound: INTEGER_CONSTANT
			id: ID_AS
			static: STATIC_ACCESS_AS
			constant_i: CONSTANT_I
			integer_value: INTEGER_CONSTANT
			constant_name: STRING
			written_class: CLASS_C
			int_value: INTEGER
			make_vomb5: BOOLEAN
			vomb5: VOMB5
			vomb4: VOMB4
			vomb6: VOMB6
		do
			if bound.is_integer then
				int_bound ?= bound
				int_value := int_bound.integer_32_value
				Result := int_bound.make_integer
				if int_value > 0 then
					positive_value_found := True
					positive_value := int_value
					make_vomb5 := not unique_names.is_empty
				end
			else
				id ?= bound
				if id /= Void then
					constant_i ?= feature_table.item (id)
				else
					static ?= bound
					constant_i := static.associated_constant
				end
				integer_value ?= constant_i.value
				int_value := integer_value.integer_32_value
				Result := bound.make_integer
				constant_name := constant_i.feature_name
				if constant_i.is_unique then
					unique_found := True
					if unique_names.has (constant_name) then
							-- Error
						create vomb4
						context.init_error (vomb4)
						vomb4.set_unique_feature (constant_i)
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
							Error_handler.insert_error (vomb6)
						end
					end
					make_vomb5 := positive_value_found
				else
					if int_value > 0 then
						positive_value_found := True
						positive_value := int_value
						make_vomb5 := not unique_names.is_empty
					end
				end
			end
			if make_vomb5 then
				create vomb5
				context.init_error (vomb5)
				vomb5.set_positive_value (positive_value)
				Error_handler.insert_error (vomb5)
			end
		ensure
			result_not_void: Result /= Void
		end
			
invariant
	valid_type: type /= Void implies (type.is_integer or type.is_character)

end
