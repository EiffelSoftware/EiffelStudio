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

	make is
		do
			create unique_names.make
			create intervals.make
		end

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
			lower_bound := inspect_value (interval.lower)
			upper := interval.upper
			if upper = Void then
				upper_bound := lower_bound
			else
				upper_bound := inspect_value (upper)
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

feature {NONE} -- Implementation

	inspect_value (bound: ATOMIC_AS): INTERVAL_VAL_B is
			-- Inspect value associated to `bound'
		require
			type_not_void: type /= Void
			bound_not_void: bound /= Void
			valid_bound_type: bound.is_valid_inspect_value (type)
		local
			constant_i: CONSTANT_I
			constant_name: STRING
			written_class: CLASS_C
			make_vomb5: BOOLEAN
			vomb5: VOMB5
			vomb4: VOMB4
			vomb6: VOMB6
		do
			Result := bound.inspect_value (type)
			constant_i := bound.unique_constant
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
