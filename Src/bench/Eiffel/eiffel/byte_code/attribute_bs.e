-- Access to an Eiffel attribute

class
	ATTRIBUTE_BS 

inherit
	ATTRIBUTE_B
		redefine
			enlarged, code_next, precomp_code_next, 
			make_end_byte_code, make_end_precomp_byte_code
		end

feature 

	enlarged: ATTRIBUTE_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		local
			attr_bls: ATTRIBUTE_BLS
			attr_bws: ATTRIBUTE_BWS
		do
			if context.final_mode then
				!! attr_bls
				attr_bls.fill_from (Current)
				Result := attr_bls
			else
				!! attr_bws
				attr_bws.fill_from (Current)
				Result := attr_bws
			end
		end

feature -- Byte code generation

	code_next: CHARACTER is
			-- Byte code when access is nested (invariant)
		once
			Result := Bc_sep_attribute_inv; 
		end

	precomp_code_next: CHARACTER is
			-- Byte code when precompiled access is nested (invariant)
		once
			Result := Bc_sep_pattribute_inv
		end


	make_end_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN
				real_feat_id: INTEGER; static_type: INTEGER) is
		-- Make final portion of the standard byte code.
	local
		class_type: CL_TYPE_I
	do
		ba.append (code_next)
			-- keep the class name of the target of the attribute call
		class_type ?= context_type; -- Can't fail
		ba.append_raw_string (class_type.base_class.name_in_upper)
			-- keep the attribute name of the attribute call
		ba.append_raw_string (attribute_name)
			-- Generate attribute id
		ba.append_integer (real_feat_id)
		ba.append_short_integer (static_type)
		make_precursor_byte_code (ba)
	end

	make_end_precomp_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN
					origin: INTEGER; offset: INTEGER) is
			-- Make final portion of the standard byte code
			-- for a precompiled call.
		local
			class_type: CL_TYPE_I
		do
			ba.append (precomp_code_next)
				-- keep the class name of the target of the attribute call
			class_type ?= context_type; -- Can't fail
			ba.append_raw_string (class_type.base_class.name_in_upper)
				-- keep the attribute name of the attribute call
			ba.append_raw_string (attribute_name)
			ba.append_integer (origin)
			ba.append_integer (offset)
			make_precursor_byte_code (ba)
		end
																	
end
