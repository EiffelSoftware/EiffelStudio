-- Invariant procedure

class INVARIANT_FEAT_I 

inherit
	DYN_PROC_I
		redefine
			melt, execution_unit,
			can_be_inlined
		end

	SHARED_ROUT_ID

creation

	make
	
feature 

	make (a_class: CLASS_C) is
		do
			feature_name := "_invariant";
			!!rout_id_set.make (1);
			rout_id_set.put (Invariant_rout_id);
			written_in := a_class.id;
		end;

	melt (dispatch: DISPATCH_UNIT; exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
		local
			byte_code: INVARIANT_B;
			melted_feature: MELT_FEATURE;
		do
			byte_code := Inv_byte_server.item (written_in);

			Byte_array.clear;
			byte_code.make_byte_code (Byte_array);

			melted_feature := Byte_array.melted_feature;
			melted_feature.set_real_body_id (dispatch.real_body_id);
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature);
			end;

			Dispatch_table.mark_melted (dispatch);
			Execution_table.mark_melted (exec);
		end;

	execution_unit (cl_type: CLASS_TYPE): INV_EXECUTION_UNIT is
			-- Execution unit
		do
			!!Result.make (cl_type, Current);
		end;

feature -- Inlining

	can_be_inlined: BOOLEAN is False
			-- An invariant is not inlined

end
