class OPT_FEAT_BL

inherit

	OPT_FEAT_B
		undefine
			is_polymorphic, free_register, has_call,
			allocates_memory,
			generate_on, basic_register, generate_access,
			register, analyze_on, set_register,
			is_feature_call, generate_special_feature, set_parent,
			generate_parameters_list, generate_access_on_type
		redefine
			parent, is_feature_special, generate_end,
			generate_metamorphose_end, analyze
		end;

	FEATURE_BL
		undefine
			enlarged, inlined_byte_code
		redefine
			fill_from, parent, check_dt_current, is_feature_special,
			generate_end, generate_metamorphose_end, analyze
		end

feature

	parent: NESTED_BL;

	fill_from (f: OPT_FEAT_B) is
		do
			type := f.type;
			parameters := f.parameters;
			array_desc := f.array_desc.enlarged;
			is_item := f.is_item
			access_area := f.access_area;
			precursor_type := f.precursor_type
			enlarge_parameters
		end

	analyze is
		do
			array_desc.analyze
			analyze_on (Current_register)
			get_register
		end;

feature -- Code generation

	check_dt_current (reg: REGISTRABLE) is
		do
		end;

	is_feature_special: BOOLEAN is
		do
		end;

	reg_name (id: INTEGER): STRING is
		do
			!!Result.make (0);
			if id = 0 then
				Result.append ("tmp_result");
			elseif id < 0 then
					-- local
				Result.append ("loc");
				Result.append_integer (-id);
			else
					-- Argument
				Result.append ("arg");
				Result.append_integer (id);
			end
		end

	register_acces (id: INTEGER): STRING is
		do
			if context.byte_code.is_once and then id = 0 then
				Result := "Result"
			else
				!!Result.make (0);
				Result.append ("l[");
				Result.append_integer (context.local_index (reg_name (id)));
				Result.append_character (']');
			end
		end

	type_c (id: INTEGER): TYPE_C is
		do
			Result := System.remover.array_optimizer.array_item_type (id);
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; is_class_separate: BOOLEAN) is
		local
			expr: EXPR_B
			id: INTEGER;
		do
			id := array_desc.array_descriptor;
			if is_item then
				if access_area then
					generated_file.putstring ("RTAA(");
				else
					generated_file.putstring ("RTAUA(");
				end;
			else
				if access_area then
					generated_file.putstring ("RTAP(");
				else
					generated_file.putstring ("RTAUP(");
				end;
			end;
			type_c (id).generate (generated_file)
			generated_file.putstring (gc_comma);
			generated_file.putstring (reg_name (id));
			generated_file.putstring (gc_comma);
			if not access_area then
				generated_file.putstring (register_acces (id));
				generated_file.putstring (gc_comma);
			end;

			expr := parameters @ 1;
			expr.print_register

			if not is_item then
				generated_file.putstring (gc_comma);
					-- Index
				expr := parameters @ 2
				expr.print_register
			end
			generated_file.put_character (')');
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_I;
		basic_type: BASIC_I; file: INDENT_FILE) is
			-- Generate final portion of C code.
		do
			generate_end (gen_reg, class_type, class_type.is_separate)
		end
end
