-- Invariant execution unit

class INV_EXECUTION_UNIT 

inherit

	EXECUTION_UNIT
		redefine
			is_valid, make, real_pattern_id
		end

creation

	make

	
feature 

	real_pattern_id: INTEGER is do end;

	make (cl_type: CLASS_TYPE; f: INVARIANT_FEAT_I) is
			-- Initialization
		do
			class_type := cl_type;
			body_id := f.body_id;
			type := Void_c_type;
		end;

	is_valid: BOOLEAN is
			-- Is the invariant execution unit still valid ?
		local
			assoc: CLASS_C;
		do
			assoc := associated_class;
			Result := assoc /= Void and then assoc.has_invariant and then
				assoc.invariant_feature.body_id = body_id
		end;

	associated_class: CLASS_C is
			-- Associated class
		local
			ct: CLASS_TYPE;
		do
			ct := System.class_type_of_id (type_id);
					-- Class type is still in the system
			if ct /= Void then
				Result := ct.associated_class;
			end;
		end;

end
