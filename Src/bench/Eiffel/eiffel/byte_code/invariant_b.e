-- Block of invariant assertions

class INVARIANT_B 

inherit

	IDABLE;
	SHARED_BODY_ID;
	BYTE_NODE
		redefine
			make_byte_code
		end;
	ASSERT_TYPE

feature 

	id: CLASS_ID;
			-- Id of the class to which the current invariant byte code
			-- belongs to

	byte_list: BYTE_LIST [BYTE_NODE];
			-- Invariant byte code list

feature 

	set_id (i: CLASS_ID) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (id);
		end;

	set_byte_list (b: like byte_list) is
			-- Assign `b' to `byte_list'.
		do
			byte_list := b;
		end; -- set_byte_list

	generate_invariant_routine is
			-- Generate invariant routine
		require
			has_invariant: byte_list /= Void
		local
			i: INTEGER;
			body_id: BODY_ID;
			internal_name: STRING;
			f: INDENT_FILE
		do
				-- Set the control flag for enlarging the assertions
			context.set_assertion_type (In_invariant);

			byte_list.enlarge_tree;
			byte_list.analyze;
				--| Always mark current as used in all modes
			context.mark_current_used;

				-- Routine's name				
			if context.final_mode then	
				body_id := Invariant_body_id;
			else
				body_id := associated_class.invariant_feature.body_id;
			end;
			internal_name := body_id.feature_name
				(System.class_type_of_id (context.current_type.type_id).id);

			f := generated_file
			f.generate_function_signature ("void", internal_name,
					True, Context.extern_declaration_file,
					<<"Current", "where">>, <<"EIF_REFERENCE", "int">>);

			f.indent;

				-- Generation of temporary variables under the control
				-- of the GC
			context.generate_temporary_ref_variables;
				-- Dynamic type of Current
			if context.dt_current > 1 then
				f.putstring ("int dtype = Dtype(Current);");
				f.new_line;
			end;

				-- Generation of the local variable array
			i := context.ref_var_used;
			if i > 0 then
				f.putstring ("RTLD;");
				f.new_line;
			end;

				-- Generate temporary variables not under the control
				-- of the GC
			context.generate_temporary_nonref_variables;
			
				-- Separate declarations and body with a blank line
			f.new_line;

				-- Generate GC hooks
			context.generate_gc_hooks (True);

			byte_list.generate;
		
				-- Remove gc hooks
			i := context.ref_var_used;
			if i > 0 then
				f.putstring ("RTLE;%N");
			end;
				-- End of C routine
			f.exdent;
			f.putstring ("}%N%N");
		end;

feature -- Byte code geenration

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a class invariant clause.
		local
			local_list: LINKED_LIST [TYPE_I];
		do
			local_list := context.local_list;
			local_list.wipe_out;
			Temp_byte_code_array.clear;
				-- Default precond- and postcondition offsets
			--Temp_byte_code_array.append_integer (0);
			--Temp_byte_code_array.append_integer (0);
		
			Temp_byte_code_array.append (Bc_start);

			Temp_byte_code_array.append_integer (0);
				-- Void result type
			Temp_byte_code_array.append_integer (Void_c_type.sk_value);
				-- No arguments
			Temp_byte_code_array.append_short_integer (0);
				-- Not a once
			Temp_byte_code_array.append ('%U');

				-- No rescue
			ba.append ('%U');
			context.set_assertion_type (In_invariant);
			byte_list.make_byte_code (ba);
			ba.append (Bc_inv_null);

			from
				Temp_byte_code_array.append_short_integer (local_list.count);
				local_list.start
			until
				local_list.after
			loop
				Temp_byte_code_array.append_integer (local_list.item.sk_value);
				local_list.forth;
			end;

			Temp_byte_code_array.append (Bc_no_clone_arg);

			context.byte_prepend (ba, Temp_byte_code_array);
		end;

	
	Temp_byte_code_array: BYTE_ARRAY is
			-- Temporary byte code array
		once
			!!Result.make;
		end;

end
