class OPT_FEAT_BL

inherit

	OPT_FEAT_B
		undefine
			is_polymorphic, free_register, has_call,
			generate_on, basic_register, generate_access,
			analyze, register, analyze_on, set_register,
			is_feature_call, generate_access_on_type,
			generate_special_feature, set_parent,
			generate_parameters_list
		redefine
			parent
		end;

	FEATURE_BL
		undefine
			enlarged
		redefine
			fill_from, parent
		end

feature

	parent: NESTED_BL;

	fill_from (f: OPT_FEAT_B) is
		do
			type := f.type;
			parameters := f.parameters;
			array_desc := f.array_desc;
			is_item := f.is_item
			enlarge_parameters
		end

end
