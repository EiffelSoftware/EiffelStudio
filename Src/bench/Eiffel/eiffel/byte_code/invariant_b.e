-- Block of invariant assertions

class INVARIANT_B 

inherit

	IDABLE;
	SHARED_ENCODER;
	SHARED_BODY_ID;
	BYTE_NODE
		redefine
			make_byte_code
		end;
	ASSERT_TYPE

feature 

	id: INTEGER;
            -- Id of the class to which the current invariant byte code
            -- belongs to

	byte_list: BYTE_LIST [BYTE_NODE];
			-- Invariant byte code list

feature 

	set_id (i: INTEGER) is
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
			i, body_id: INTEGER;
			internal_name: STRING;
		do
				-- Set the control flag for enlarging the assertions
			context.set_assertion_type (In_invariant);

			byte_list.enlarge_tree;
			byte_list.analyze;

				-- Routine's name				
			generated_file.putstring ("void ");
			if context.final_mode then	
				body_id := Invariant_id;
			else
				body_id := associated_class.invariant_feature.body_id;
			end;
			internal_name := Encoder.feature_name
				(System.class_type_of_id (context.current_type.type_id).id,
				body_id);
			generated_file.putstring (internal_name);
				-- Arguments
			generated_file.putstring ("(Current,where)");
			generated_file.new_line;
				-- Arguments declarations
			generated_file.putstring ("char *Current;");
			generated_file.new_line;
			generated_file.putstring ("int where;");
			generated_file.new_line;
			generated_file.putchar ('{');
			generated_file.new_line;
			generated_file.indent;

				-- Generation of temporary variables under the control
				-- of the GC
			context.generate_temporary_ref_variables;
				-- Dynamic type of Current
			if context.dt_current > 1 then
				generated_file.putstring ("int dtype = Dtype(Current);");
				generated_file.new_line;
			end;

				-- Generation of the local variable array
			i := context.ref_var_used;
			if i > 0 then
				generated_file.putstring ("RTLD;");
				generated_file.new_line;
			end;

				-- Generate temporary variables not under the control
				-- of the GC
			context.generate_temporary_nonref_variables;
			
				-- Separate declarations and body with a blank line
			generated_file.new_line;

				-- Generate GC hooks
			context.generate_gc_hooks (True);

			byte_list.generate;
		
				-- Remove gc hooks
			i := context.ref_var_used;
			if i > 0 then
				generated_file.putstring ("RTLE;");
				generated_file.new_line;
			end;
				-- End of C routine
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
			generated_file.new_line;

		end;

feature -- Byte code geenration

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a class invariant clause.
		local
			local_list: LINKED_LIST [TYPE_I];
		do
			Temp_byte_code_array.clear;
				-- Default precond- and postcondition offsets
			Temp_byte_code_array.append_integer (0);
			Temp_byte_code_array.append_integer (0);
		
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
			ba.append (Bc_null);

			from
                local_list := context.local_list;
                Temp_byte_code_array.append_short_integer (local_list.count);
                local_list.start
            until
                local_list.offright
            loop
                Temp_byte_code_array.append_integer (local_list.item.sk_value);
                local_list.forth;
            end;

			Temp_byte_code_array.append (Bc_no_clone_arg);

			context.byte_prepend (ba, Temp_byte_code_array);

				-- Clean the context
			local_list.wipe_out;
		end;

	
	Temp_byte_code_array: BYTE_ARRAY is
            -- Temporary byte code array
        once
            !!Result.make;
        end;

end
