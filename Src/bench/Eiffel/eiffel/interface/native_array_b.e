indexing
	description: "Compiled class NATIVE_ARRAY"
	date: "$Date$"
	revision: "$Revision$"

class NATIVE_ARRAY_B

inherit
	CLASS_C
		redefine
			check_validity, new_type, is_native_array
		end

	SPECIAL_CONST
		
creation
	make
	
feature -- Validity

	check_validity is
			-- Check validity of class ARRAY
		local
			stop, error: BOOLEAN
			special_error: SPECIAL_ERROR
			l_feat_tbl: like feature_table
			l_feat: FEATURE_I
			to_special_p, parent_t: CL_TYPE_A
			done: BOOLEAN
		do
			l_feat_tbl := feature_table
				-- First check if current class has one formal generic parameter
			if (generics = Void) or else generics.count /= 1 then
				create special_error.make (Case_20, Current)
				Error_handler.insert_error (special_error)
			end

				-- Second, check if there is only one creation procedure 
				-- having only one integer argument
			error := creators = Void
			if not error then
				from
					creators.start
				until
					done or else creators.after
				loop
					l_feat := l_feat_tbl.item (creators.key_for_iteration)
					if
						l_feat.feature_name.is_equal (Make_signature.feature_name) and then
						l_feat.same_signature (Make_signature)
					then
						done := True
					else
						creators.forth
					end
				end
				error := not done
			end
			if error then
				create  special_error.make (Case_21, Current)
				Error_handler.insert_error (special_error)
			end

				-- Third, check if class has a feature item and infix "@" (INTEGER): Generic #1
			l_feat := l_feat_tbl.item_id (feature {PREDEFINED_NAMES}.item_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (Item_signature)
			then
				create special_error.make (Case_22, Current)
				Error_handler.insert_error (special_error)
			end
			
			l_feat := l_feat_tbl.item_id (feature {PREDEFINED_NAMES}.infix_at_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (Infix_at_signature)
			then
				create special_error.make (Case_23, Current)
				Error_handler.insert_error (special_error)
			end
	
				-- Fourth, check if class has a feature put (Generic #1, INTEGER)
			l_feat := l_feat_tbl.item_id (feature {PREDEFINED_NAMES}.put_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (Put_signature)
			then
				create special_error.make (Case_24, Current)
				Error_handler.insert_error (special_error)
			end

				-- Fourth, check if class has a feature count, INTEGER)
			l_feat := l_feat_tbl.item_id (feature {PREDEFINED_NAMES}.count_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (Count_signature)
			then
				create special_error.make (Case_25, Current)
				Error_handler.insert_error (special_error)
			end
		end

feature -- Generic derivation

	new_type (data: CL_TYPE_I): NATIVE_ARRAY_CLASS_TYPE is
			-- New class type for class NATIVE_ARRAY.
		do
			create Result.make (data)
		end

feature -- Status report

	is_native_array: BOOLEAN is True
			-- Is the class special ?

feature {NONE}

	Make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
		once
			create  args.make (1)
			args.put_i_th (Integer_type, 1)
			create  Result
			Result.set_arguments (args)
			Result.set_feature_name_id (feature {PREDEFINED_NAMES}.make_name_id)
		end

	Count_signature: DYN_FUNC_I is
			-- Required signature for feature `count' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
		once
			create args.make (0)
			create Result
			Result.set_arguments (args)
			Result.set_type (Integer_type)
			Result.set_feature_name_id (feature {PREDEFINED_NAMES}.count_name_id)
		ensure
			item_signature_not_void: Result /= Void
		end

	Item_signature: DYN_FUNC_I is
			-- Required signature for feature `item' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
			f: FORMAL_A
		once
			create args.make (1)
			args.put_i_th (Integer_type, 1)
			create Result
			Result.set_arguments (args)
			create f
			f.set_position (1)
			Result.set_type (f)
			Result.set_feature_name_id (feature {PREDEFINED_NAMES}.item_name_id)
		ensure
			item_signature_not_void: Result /= Void
		end

	Infix_at_signature: DYN_FUNC_I is
			-- Required signature for feature `infix "@"' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
			f: FORMAL_A
		once
			create args.make (1)
			args.put_i_th (Integer_type, 1)
			create Result
			Result.set_arguments (args)
			create f
			f.set_position (1)
			Result.set_type (f)
			Result.set_feature_name_id (feature {PREDEFINED_NAMES}.infix_at_name_id)
		ensure
			item_signature_not_void: Result /= Void
		end

	Put_signature: DYN_PROC_I is
			-- Required signature for feature `put' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
			f: FORMAL_A
		once
			create f
			f.set_position (1)
			create args.make (2)
			args.put_i_th (Integer_type, 1)
			args.put_i_th (f, 2)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id (feature {PREDEFINED_NAMES}.put_name_id)
		ensure
			put_signature_not_void: Result /= Void
		end

end -- end of NATIVE_ARRAY_B
