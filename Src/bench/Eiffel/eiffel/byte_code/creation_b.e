-- Creation instruction

class CREATION_B 

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged,
			make_byte_code, is_unsafe,
			optimized_byte_node,
			assigns_to,
			calls_special_features, size,
			inlined_byte_code, pre_inlined_code, generate_il
		end
	
feature 

	target: ACCESS_B;
			-- Target to create

	info: CREATE_INFO;
			-- Creation info for creating the right type

	call: NESTED_B;
			-- Call after creation: can be Void

	set_target (t: ACCESS_B) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	set_info (i: CREATE_INFO) is
			-- Assign `i' to `info'
		do
			info := i;
		end;

	set_call (n: NESTED_B) is
			-- Assign `i' to `call'.
		do
			call := n;
		end;

feature -- C code generation

	need_enlarging: BOOLEAN is true;
			-- This node needs enlarging

	enlarged: CREATION_BL is
			-- Enlarge current node
		do
			!!Result;
			Result.set_target (target.enlarged);
			Result.set_info (info);
			if call /= Void then
				Result.set_call (call.enlarged);
			end;
			Result.set_line_number (line_number)
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for creation instruction
		local
			target_type: TYPE_I
			create_type: CREATE_TYPE
			create_feat: CREATE_FEAT
			is_native_array, is_external: BOOLEAN
			cl_type: CL_TYPE_I
			class_c: CLASS_C
			native_array_class: NATIVE_ARRAY_B
			f: FEATURE_B
		do
			generate_il_line_info
			target_type := Context.real_type (target.type)

			if target_type.is_reference then

					-- Analyze type of creation
				create_type ?= info	
				if create_type /= Void then
					cl_type ?= create_type.type
					check
						cl_type_not_void: cl_type /= Void
					end
					class_c := cl_type.base_class
					is_native_array := class_c.is_native_array
					is_external := class_c.is_external
				else
					create_feat ?= info
					if create_feat /= Void then
						is_native_array := create_feat.is_array (target.type)
						is_external := create_feat.is_external (target.type)
					end
				end

				if is_native_array then
					native_array_class ?= class_c
					is_native_array := native_array_class /= Void
				end

					-- Issue current object if needed for assignment
				target.generate_il_start_assignment

				if is_external and then not is_native_array then
					context.set_il_external_creation (True)
					if System.java_generation then
						info.generate_il
						il_generator.duplicate_top
					end
						-- Creation call on an external class.
					if call /= Void then
						call.message.generate_il
					end
					context.set_il_external_creation (False)
					target.generate_il_assignment (target_type)
				else
					if not is_native_array then
							-- Standard creation call
						info.generate_il
						target.generate_il_assignment (target_type)
						if call /= Void then
							call.generate_il
						end
					else
							-- Creation call on an NATIVE_ARRAY.
						check
							call_not_void: call /= Void
						end
						f ?= call.message
						check
							f_not_void: f /= Void
							f_name_is_make: f.feature_name.is_equal ("make")
						end

						if create_feat /= Void then
								-- If it is a creation of an attribute
								-- we have to generate `count' first and then
								-- the `create_feat' will generate correct IL
								-- code
							f.parameters.generate_il
							create_feat.generate_il
						else
								-- We have to generate ourself the IL code.
							f.generate_il_array_creation
						end
						target.generate_il_assignment (target_type)
					end
				end
			else
					-- Creation on expanded or basic types
					-- Issue current object if needed for assignment
				target.generate_il_start_assignment
				target.generate_il_assignment (target_type)
				if call /= Void then
					call.message.generate_il	
				end
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a creation instruction
		local
			target_type: TYPE_I;
			basic_type: BASIC_I
			feat: FEATURE_B;
			cl_type: CL_TYPE_I;
		do
debug
	info.trace;
end;
			target_type := Context.real_type (target.type);
			context.generate_melted_debugger_hook (ba);
			if target_type.is_separate then
				ba.append (Bc_sep_create);
				cl_type ?= target_type -- can't be fail
				ba.append_raw_string (cl_type.associated_class_type.associated_class.name_in_upper);
				if call = Void then
					ba.append_raw_string ("_no_cf");
				else
					feat ?= call.message; -- Can't Fail here
					ba.append_raw_string (feat.feature_name);
				end;
				target.make_assignment_code (ba, target_type);
				if call /= Void then
					call.make_creation_byte_code (ba);
				end;
				ba.append (Bc_sep_create_end);
			else
				if target_type.is_basic then
					basic_type ?= target_type
					if basic_type.is_bit then
						ba.append (Bc_create)
						ba.append (Bc_bit)
					end
					basic_type.make_basic_creation_byte_code (ba)
					target.make_assignment_code (ba, target_type)
					if call /= Void then
						call.make_creation_byte_code (ba)
					end
				else
					ba.append (Bc_create);
					info.make_byte_code (ba);
					target.make_assignment_code (ba, target_type);
					if call /= Void then
						call.make_creation_byte_code (ba);
					end;
					target.make_byte_code (ba);
					ba.append (Bc_create_inv);
				end
			end;
		end;

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := target.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if call /= Void then
				Result := call.calls_special_features (array_desc)
			end
		end

	is_unsafe: BOOLEAN is
		do
			if call /= Void then
				Result := call.is_unsafe
			end
		end;

	optimized_byte_node: like Current is
		do
			Result := Current
				-- The current call won't be optimized:
				-- `item' and `put' are NOT creation routines
			if call /= Void then
				call ?= call.optimized_byte_node
			end
		end;

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

	pre_inlined_code: like Current is
			-- This routine should NEVER be called
		do
		end

	inlined_byte_code: like Current is
		do
			Result := Current
				-- The special register makes it difficult to
				-- inline
			if call /= Void then
				call := call.inlined_byte_code
			end
		end

end
