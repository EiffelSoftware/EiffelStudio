indexing
	description: "Byte node for a creation instruction"
	date: "$Date$"
	revision: "$Revision$"

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
	
feature -- Access

	target: ACCESS_B
			-- Target to create

	info: CREATE_INFO
			-- Creation info for creating the right type

	call: NESTED_B
			-- Call after creation: can be Void

feature -- Settings

	set_target (a_target: ACCESS_B) is
			-- Assign `a_target' to `target'.
		require
			t_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

	set_info (an_info: CREATE_INFO) is
			-- Assign `an_info' to `info'\
		require
			an_info_not_void: an_info /= Void
		do
			info := an_info
		ensure
			info_set: info = an_info
		end

	set_call (n: NESTED_B) is
			-- Assign `i' to `call'.
		do
			call := n
		ensure
			call_set: call = n
		end

feature -- C code generation

	need_enlarging: BOOLEAN is True
			-- This node needs enlarging

	enlarged: CREATION_BL is
			-- Enlarge current node
		do
			create Result
			Result.set_target (target.enlarged)
			Result.set_info (info)
			if call /= Void then
				Result.set_call (call.enlarged)
			end
			Result.set_line_number (line_number)
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for creation instruction
		local
			target_type: TYPE_I
			create_type: CREATE_TYPE
			is_external: BOOLEAN
			cl_type: CL_TYPE_I
		do
			generate_il_line_info
			target_type := Context.real_type (target.type)

			if target_type.is_reference then

					-- Analyze type of creation
				create_type ?= info	
				if create_type /= Void then
					cl_type ?= create_type.type
				else
					cl_type ?= target_type
				end

				is_external := cl_type /= Void and then cl_type.base_class.is_external

					-- Issue current object if needed for assignment
				target.generate_il_start_assignment

				if is_external then
						-- Creation call on an external class.
					context.set_il_external_creation (True)
					check
						call_not_void: call /= Void
					end
						-- An external class has always a feature call
						-- as `default_create' can't be called on them.
					call.message.generate_il
					context.set_il_external_creation (False)
					target.generate_il_assignment (target_type)
				else
						-- Standard creation call for a normal Eiffel class.
					info.generate_il
					target.generate_il_assignment (target_type)
					if call /= Void then
						call.generate_il
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
			target_type: TYPE_I
			basic_type: BASIC_I
			feat: FEATURE_B
			cl_type: CL_TYPE_I
		do
			debug
				info.trace
			end

			target_type := Context.real_type (target.type)
			generate_melted_debugger_hook (ba)
			if target_type.is_separate then
				ba.append (Bc_sep_create)
				cl_type ?= target_type -- can't be fail
				ba.append_raw_string (cl_type.associated_class_type.associated_class.name_in_upper)
				if call = Void then
					ba.append_raw_string ("_no_cf")
				else
					feat ?= call.message; -- Can't Fail here
					ba.append_raw_string (feat.feature_name)
				end
				target.make_assignment_code (ba, target_type)
				if call /= Void then
					call.make_creation_byte_code (ba)
				end
				ba.append (Bc_sep_create_end)
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
					ba.append (Bc_create)
					info.make_byte_code (ba)
					target.make_assignment_code (ba, target_type)
					if call /= Void then
						call.make_creation_byte_code (ba)
					end
					target.make_byte_code (ba)
					ba.append (Bc_create_inv)
				end
			end
		end

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
		end

	optimized_byte_node: like Current is
		do
			Result := Current
				-- The current call won't be optimized:
				-- `item' and `put' are NOT creation routines
			if call /= Void then
				call ?= call.optimized_byte_node
			end
		end

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
			check
				not_called: False
			end
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
