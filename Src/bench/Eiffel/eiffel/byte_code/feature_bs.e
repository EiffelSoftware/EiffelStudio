-- Access to an Eiffel feature

class FEATURE_BS 

inherit

	FEATURE_B
		redefine
			enlarged, code_first, code_next, 
			precomp_code_first, precomp_code_next,
			make_end_byte_code, make_end_precomp_byte_code
		end;

feature 

	enlarged: FEATURE_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		local
			feature_bls: FEATURE_BLS
			feature_bws: FEATURE_BWS
		do
			if context.final_mode then
				!!feature_bls;
				feature_bls.fill_from (Current);
				Result := feature_bls
			else
				!!feature_bws.make;
				feature_bws.fill_from (Current);
				Result := feature_bws
			end;
		end;

feature -- Byte code generation

	code_first: CHARACTER is
			-- Code when Eiffel call is first (no invariant)
		once
				-- It's only possible for creation feature call.  delete it later.
			Result := Bc_sep_feature 
		end;

	code_next: CHARACTER is
			-- Code when Eiffel call is nested (invariant)
		once
			Result := Bc_sep_feature_inv;
		end;

	precomp_code_first: CHARACTER is
			-- Code when Eiffel precompiled call is first (no invariant)
		once
				-- It's only possible for creation feature call. delete it later.
			Result := Bc_sep_pfeature; 
		end;

	precomp_code_next: CHARACTER is
			-- Code when Eiffel precompiled call is nested (invariant)
		once
			Result := Bc_sep_pfeature_inv;
		end;

feature -- Concurrent Eiffel

		make_end_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN;
					real_feat_id: INTEGER; static_type: INTEGER) is
			-- Make final portion of the standard byte code.
		local
			class_type: CL_TYPE_I;
		do
			if  is_first or flag then
				ba.append (code_first);
			else
				ba.append (code_next);
			end;
				-- keep parameter number
			if parameters /= Void then
				ba.append_short_integer (parameters.count);
			else
				ba.append_short_integer (0);
			end;
				-- keep the class name of the target of the feature call
			class_type ?= context_type; -- Can't fail
			ba.append_raw_string (class_type.base_class.name_in_upper);
				-- keep the feature name of the feature call
			ba.append_raw_string (feature_name);
				-- keep the return value's type;
			ba.append_uint32_integer (Context.real_type (type).sk_value)

				-- keep if the acknowledgement for the proc. is necessary
			if attach_loc_to_sep then
				ba.append ('%/001/');
			else
				ba.append ('%/000/');
			end;
				-- Generate feature id
			ba.append_integer (real_feat_id);
			ba.append_short_integer (static_type);
			make_precursor_byte_code (ba)
		end;

	make_end_precomp_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN;
					origin: INTEGER; offset: INTEGER) is
			-- Make final portion of the standard byte code
			-- for a precompiled call.
		local
			class_type: CL_TYPE_I;
		do
			if  is_first or flag then
				ba.append (precomp_code_first);
			else
				ba.append (precomp_code_next);
			end;
				-- keep parameter number
			if parameters /= Void then
				ba.append_short_integer (parameters.count);
			else
				ba.append_short_integer (0);
			end;
				-- keep the class name of the target of the feature call
			class_type ?= context_type; -- Can't fail
			ba.append_raw_string (class_type.base_class.name_in_upper);
				-- keep the feature name of the feature call
			ba.append_raw_string (feature_name);
				-- keep the return value's type;
			ba.append_uint32_integer (Context.real_type (type).sk_value);
				-- keep if the acknowledgement for the proc. is necessary
			if attach_loc_to_sep then
				ba.append ('%/001/');
			else
				ba.append ('%/000/');
			end;
			ba.append_integer (origin);
			ba.append_integer (offset);
			make_precursor_byte_code (ba)
		end;

end
