-- Block of invariant assertions

class INVARIANT_B 

inherit
	ASSERT_TYPE

	BYTE_NODE
		redefine
			make_byte_code, generate_il
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	SHARED_BODY_ID

feature 

	byte_list: BYTE_LIST [BYTE_NODE];
			-- Invariant byte code list

feature 

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (class_id);
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
			body_index: INTEGER;
			internal_name: STRING;
			buf: GENERATION_BUFFER
		do
			buf := buffer

				-- Set the control flag for enlarging the assertions
			context.set_assertion_type (In_invariant);

			byte_list.enlarge_tree;
			byte_list.analyze;
				-- For invariant, we always need the GC hook.
			context.force_gc_hooks

				--| Always mark current as used in all modes
			context.mark_current_used;

				-- Routine's name				
			if context.final_mode then	
				body_index := Invariant_body_index;
			else
				body_index := associated_class.invariant_feature.body_index;
			end;

			internal_name := Encoder.feature_name (
				System.class_type_of_id (context.current_type.type_id).static_type_id,
				body_index)

			buf.generate_function_signature ("void", internal_name,
					True, Context.header_buffer,
					<<"Current", "where">>, <<"EIF_REFERENCE", "int">>);

			buf.indent;

				-- Generation of temporary variables under the control
				-- of the GC
			context.generate_temporary_ref_variables;
				-- Dynamic type of Current
			if context.dt_current > 1 then
				buf.putstring ("RTCDT;");
				buf.new_line;
			end;

				-- Generation of the local variable array
			i := context.ref_var_used;
			if i > 0 then
				buf.putstring ("RTLD;");
				buf.new_line;
			end;

				-- Generate temporary variables not under the control
				-- of the GC
			context.generate_temporary_nonref_variables;
			
				-- Separate declarations and body with a blank line
			buf.new_line;

				-- Generate GC hooks
			context.generate_gc_hooks (True);

			byte_list.generate;
		
				-- Remove gc hooks
			i := context.ref_var_used;
			if i > 0 then
				buf.putstring ("RTLE;%N");
			end;
				-- End of C routine
			buf.exdent;
			buf.putstring ("}%N%N");
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for a class invariant clause.
		local
			end_of_assertion: IL_LABEL
		do
			context.local_list.wipe_out
			context.set_assertion_type (In_invariant);

			end_of_assertion := il_label_factory.new_label
			il_generator.generate_in_assertion_test (end_of_assertion)
			il_generator.generate_set_assertion_status

			byte_list.generate_il

			il_generator.generate_restore_assertion_status
			il_generator.mark_label (end_of_assertion)
			il_generator.generate_return
		end

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

				-- no Routine id
			Temp_byte_code_array.append_integer (0)
				-- no Real body id ( -1 because it's an invariant. We can't set a breakpoint )
			Temp_byte_code_array.append_integer (-1)

				-- Void result type
			Temp_byte_code_array.append_integer (Void_c_type.sk_value);
				-- No arguments
			Temp_byte_code_array.append_short_integer (0);
				-- No name
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
