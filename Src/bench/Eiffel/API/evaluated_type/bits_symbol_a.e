-- Actual type for bits_symbol: `base_type' is the bits value

class BITS_SYMBOL_A

inherit

	BITS_A
		redefine
			solved_type, dump, append_clickable_signature
		end;

creation

	make

feature

	rout_id: INTEGER;

	feature_name: STRING;

	class_id: INTEGER;

	make (f: FEATURE_I) is
		do
			feature_name := f.feature_name;
			class_id := System.current_class.id;
			rout_id := f.rout_id_set.first;
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_SYMBOL_A is
			-- Calculated type in function of the feauure `f' which has
			-- the type Current and the feautre table `feat_table
		local
			origin_table: HASH_TABLE [FEATURE_I, INTEGER];
			anchor_feature: FEATURE_I;
			vtbt: VTBT;
			veen: VEEN;
			constant: CONSTANT_I;
			bits_value: INTEGER;
			error: BOOLEAN;
			int_value: INT_VALUE_I;
		do
			origin_table := feat_table.origin_table;
			if System.current_class.id /= class_id then
				anchor_feature := System.class_of_id (class_id).feature_table
								.item (feature_name);
			else
				anchor_feature := feat_table.item (feature_name);
			end;
			if anchor_feature = Void then
				!!veen;
				veen.set_class (System.current_class);
				veen.set_feature (f);
				veen.set_identifier (feature_name);
				Error_handler.insert_error (veen);
				Error_handler.raise_error;
			else
				constant ?= anchor_feature;
				error := constant = Void;
				if not error then
					int_value ?= constant.value;
					error := int_value = Void;
					if not error then
						bits_value := int_value.int_val;
						error := bits_value <= 0;
					end;
				end;
				if error then
					!!vtbt;
					vtbt.set_class (feat_table.associated_class);
					vtbt.set_feature (f);
					if bits_value < 0 then
						vtbt.set_value (bits_value);
					end;
					Error_handler.insert_error (vtbt);
					-- Cannot go on here
					Error_handler.raise_error;
				end;
				base_type := bits_value;
			end;
			rout_id := anchor_feature.rout_id_set.first;
			if rout_id < 0 then
				rout_id := - rout_id
			end;
			Result := twin;
		end;

feature -- Trace

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (9);
			Result.append ("BIT ");
			Result.append (feature_name);
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("BIT ");
			a_clickable.put_string (feature_name);
		end;

end
