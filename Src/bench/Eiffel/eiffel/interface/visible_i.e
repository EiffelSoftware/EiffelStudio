-- Feature external visibility controler

class VISIBLE_I 

inherit

	SHARED_CODE_FILES;
	SHARED_WORKBENCH;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end;

feature

	renamings: HASH_TABLE [STRING, STRING];
			-- Renaming table

	is_visible (feat: FEATURE_I): BOOLEAN is
			-- Is feature name `feat_name' visible ?
		do
			-- Do nothing
		end;

	nb_visible (a_class: CLASS_C): INTEGER is
			-- Number of visible items from the class `a_class'.
		require
			good_argument: a_class /= Void
		do
		end;

	visible_table_size (a_class: CLASS_C): INTEGER is
			-- Size of the visible features table
		require
			good_argument: a_class /= Void
		do
			Result := prime_size (nb_visible (a_class));
		end;

	
feature {NONE}

	primes: PRIMES is
			-- Prime number evaluator
		once
			!!Result;
		end;

	prime_size (i: INTEGER): INTEGER is
			-- Prime number greater than 5 * i / 4
		do
			Result := primes.higher_prime ((5 * i) // 4);
		end;

	cecil_file: INDENT_FILE is
		do
			Result := System.cecil_file
		end;

feature 

	real_name (feat: FEATURE_I): STRING is
			-- Real external name for `feat'.
		require
			good_argument: feat /= Void;
			is_visible (feat)
		local
			feature_name: STRING;
		do
			feature_name := feat.feature_name;
			if renamings /= Void and then renamings.has (feature_name) then
				Result := renamings.found_item
			else
				Result := feature_name
			end;
		end;

	set_renamings (t: like renamings) is
			-- Assign `t' to `renamings'.
		do
			renamings := t;
		end;

	mark_visible (remover: REMOVER; feat_table: FEATURE_TABLE) is
			-- Mark visible features from `feat_table'.
		do
			-- Do nothing
		end;

	has_visible: BOOLEAN is
			-- Has the current object some visible features ?
		do
			-- Do nothing
		end;

	generate_cecil_table (a_class: CLASS_C) is
			-- Generate cecil table
		require
			has_visible;
		do
		end;

	make_byte_code (ba: BYTE_ARRAY; tbl: FEATURE_TABLE) is
			-- Produce byte code for current visible clause
		do
		end;

	trace is
		do
			io.error.putstring (generator);
		end;

end
