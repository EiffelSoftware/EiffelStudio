-- Controler of multi-branch instruction

class INSPECT_CONTROL 

inherit

	SHARED_ERROR_HANDLER;
	SHARED_AST_CONTEXT;
	COMPILER_EXPORTER

creation

	make
	
feature 

	node: INSPECT_AS;
			-- Node currently checked

	feature_table: FEATURE_TABLE;
			-- Feature table of the class where `node' is written in.

	integer_type: BOOLEAN;
			-- Type of the inspect expression

	interval: INTERVAL_AS;
			-- Current interval processed

	unique_found: BOOLEAN;
			-- Is a unique feature involved in the choices ?

	positive_value_found: BOOLEAN;
			-- Is a positive value involved in the choices ?

	positive_value: INTEGER;
			-- One of the positive values found (error report)

	unique_names: LINKED_SET [STRING];
			-- Set of unique names already used 
	
	last_class: CLASS_C;
			-- Class for controling uniques

	int_intervals: SORTED_TWO_WAY_LIST [INT_INTER_B];
			-- Sorted list of integer intervals

	char_intervals: SORTED_TWO_WAY_LIST [CHAR_INTER_B];
			-- Sorted list of character intervals

	make is
		do
			!!unique_names.make;
			!!int_intervals.make;
			!!char_intervals.make;
		end;

	wipe_out is
		do
			unique_names.wipe_out;
			positive_value_found := False;
			unique_found := False;
			integer_type := False;
			node := Void;
			feature_table := Void;
			interval := Void;
			int_intervals.wipe_out;
			char_intervals.wipe_out;
			last_class := Void;
		end;

	set_node (n: like node) is
			-- Assign `n' to `node'.
		do
			node := n;
		end;

	set_character_type is
			-- Set `integer_type' to `False'.
		do
			integer_type := False;
		end;

	set_integer_type is
			-- Set `inpect_type' to `True'.
		do
			integer_type := True;
		end;

	set_interval (i: INTERVAL_AS) is
			-- Assign `i' to `interval'.
		do
			interval := i;
		end;

	set_feature_table (t: FEATURE_TABLE) is
			-- Assign `t' to `feature_table'.
		do
			feature_table := t;
		end;

	integer_interval: INT_INTER_B is
			-- Process integer interval.
		require
			interval_exists: interval /= Void;
			good_integer_interval: interval.good_integer_interval;
		local
			first_int, second_int: INT_VAL_B;
			lower, upper: ATOMIC_AS;
			vomb3: VOMB3;
		do
			lower := interval.lower;
			first_int := make_integer (lower);
			upper := interval.upper;
			if (upper = Void) then
				second_int := first_int;
			else
				second_int := make_integer (upper);
			end;
			!!Result.make (first_int, second_int);
			if Result.is_good_range then
				from
					int_intervals.start;
				until	
					int_intervals.after
				loop
					if not Result.disjunction (int_intervals.item) then
							-- Error
						!!vomb3;
						context.init_error (vomb3);
						vomb3.set_interval (Result.intersection (int_intervals.item));
						Error_handler.insert_error (vomb3);
					end;
					int_intervals.forth;
				end;
				int_intervals.extend (Result);
			else
				Result := Void
			end;
		end;

	character_interval: CHAR_INTER_B is
			-- Process character interval.
		require
			interval_exists: interval /= Void;
			good_character_interval: interval.good_character_interval;
		local
			first_char, second_char: CHAR_VAL_B;
			upper: ATOMIC_AS;
			vomb3: VOMB3;
		do
			first_char := interval.lower.make_character;
			upper := interval.upper;
			if upper = Void then
				second_char := first_char;
			else
				second_char := upper.make_character;
			end;
			!!Result.make (first_char, second_char);
			if Result.is_good_range then
				from
					char_intervals.start;
				until
					char_intervals.after
				loop
					if not Result.disjunction (char_intervals.item) then
							-- Error
						!!vomb3;
						context.init_error (vomb3);
						vomb3.set_interval (Result.intersection (char_intervals.item));
						Error_handler.insert_error (vomb3);
					end;
					char_intervals.forth;
				end;
				char_intervals.extend (Result);
			else
				Result := Void
			end;
		end;

	make_integer (bound: ATOMIC_AS): INT_VAL_B is
			-- Integer bound associated to `bound'.
		require
			good_argument: bound /= Void
			consistency: bound.good_integer
		local
			int_const_val: INT_CONST_VAL_B
			int_bound: INTEGER_AS
			id: ID_AS
			constant_i: CONSTANT_I
			integer_value: INT_VALUE_I
			constant_name: STRING
			written_class: CLASS_C
			int_value: INTEGER
			make_vomb5: BOOLEAN
			vomb5: VOMB5
			vomb4: VOMB4
			vomb6: VOMB6
		do
			if bound.is_integer then
				int_bound ?= bound;
				int_value := int_bound.value;
				!!Result.make (int_value);
				if int_value > 0 then
					positive_value_found := True;
					positive_value := int_value;
					make_vomb5 := not unique_names.is_empty;
				end;
			else
				id ?= bound;
				constant_i ?= feature_table.item (id);
				integer_value ?= constant_i.value;
				int_value := integer_value.int_val;
				!!int_const_val.make (int_value, constant_i);
				Result := int_const_val;
				constant_name := constant_i.feature_name;
				if constant_i.is_unique then
					unique_found := True;
					if unique_names.has (constant_name) then
							-- Error
						!!vomb4;
						context.init_error (vomb4);
						vomb4.set_unique_feature (constant_i);
						Error_handler.insert_error (vomb4);
					else
						unique_names.extend (constant_name);
						written_class := constant_i.written_class;
						if last_class = Void then
							last_class := written_class;
						elseif last_class /= written_class then
								-- Error
							!!vomb6;
							context.init_error (vomb6);
							vomb6.set_unique_feature (constant_i);
							vomb6.set_written_class (last_class);
							Error_handler.insert_error (vomb6);
						end;
					end;
					make_vomb5 := positive_value_found;
				else
					if int_value > 0 then
						positive_value_found := True;
						positive_value := int_value;
						make_vomb5 := not unique_names.is_empty;
					end;
				end;
			end;
			if make_vomb5 then
				!!vomb5;
				context.init_error (vomb5);
				vomb5.set_positive_value (positive_value);
				Error_handler.insert_error (vomb5);
			end;
		end;
			
end
