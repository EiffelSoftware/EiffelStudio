indexing
	description: "Byte code for creation expression"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_B

inherit
	ACCESS_B
		redefine
			make_byte_code, analyze,
			generate, register, get_register,
			enlarged
		end

creation
	make

feature -- Initialization

	make is
		do
		end

feature -- Register

	register: REGISTRABLE
			-- Where the temporary result is stored

	get_register is
			-- Get a register
		local
			tmp_register: REGISTER
		do
			!! tmp_register.make (Ref_type)
			register := tmp_register
		end

feature -- C code generation

	enlarged: CREATION_EXPR_B is
			-- Enlarge current_node
		do
			!! Result.make
			Result.set_info (info)
			if call /= Void then
				Result.set_call (call.enlarged)
			end
		end
	
feature -- Analyze

	analyze is
			-- Analyze creation node
		do
			info.analyze
			get_register
			if call /= Void then
				call.set_register (register)
				call.set_need_invariant (False)
				call.analyze
				call.free_register
			else
				free_register
			end
		end

feature -- Access

	info: CREATE_TYPE
			-- Creation info for creation the right type

	call: CREATION_FEATURE_B
			-- Call after creation expressioon: can be Void.

	set_info (i: CREATE_TYPE) is
			-- Assign `i' to `info'.
		do
			info := i
		ensure
			info_set: info = i
		end

	set_call (n: CREATION_FEATURE_B) is
			-- Assign `i' to `call'.
		do
			call := n
		ensure
			call_set: call = n
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a creation instruction
		local
			target_type: TYPE_I
			feat: FEATURE_B
			cl_type: CL_TYPE_I
		do
			target_type := Context.real_type (target.type)
			make_breakable (ba)
			if target_type.is_separate then
			else
				ba.append (Bc_create)
			end
		end

feature

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			creation_expr_b: CREATION_EXPR_B
		do
			creation_expr_b ?= other
			Result := creation_expr_b /= Void
		end

	type: TYPE_I is
			-- Current type
		do
			Result := context.current_type
		end

feature -- Generation

	generate is
				-- Generate C code for creation expression
			local
				is_expanded: BOOLEAN
				target_type: CL_TYPE_I
				current_type: CL_TYPE_I
			do
				generate_line_info

				current_type := context.current_type
				target_type ?= Context.real_type (info.type)

				context.set_current_type (target_type)

				if call /= Void then
					call.set_type (target_type)
					call.set_info (info)
					call.generate
				end

				context.set_current_type (current_type)
			end

end -- class CREATION_EXPR_B
