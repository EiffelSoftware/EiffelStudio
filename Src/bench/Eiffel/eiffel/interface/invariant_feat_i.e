-- Invariant procedure

class INVARIANT_FEAT_I 

inherit
	DYN_PROC_I
		redefine
			melt, generate_il
		end

creation
	make
	
feature 

	make (a_class: CLASS_C) is
		do
			set_feature_name ("_invariant")
			!!rout_id_set.make (1)
			rout_id_set.put (System.routine_id_counter.invariant_rout_id)
			written_in := a_class.class_id
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for current feature.
		local
			byte_code: INVARIANT_B
		do
			byte_code := Inv_byte_server.item (written_in)
			byte_code.generate_il
		end

feature -- Byte Code generation

	melt (exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
		local
			byte_code: INVARIANT_B
			melted_feature: MELT_FEATURE
		do
			byte_code := Inv_byte_server.item (written_in)

			Byte_array.clear
			byte_code.make_byte_code (Byte_array)

			melted_feature := Byte_array.melted_feature
			melted_feature.set_real_body_id (exec.real_body_id)
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

			Execution_table.mark_melted (exec)
		end

end
