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
			enlarged, size
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
				call.set_info (info)
				call.analyze
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
			target_type: CL_TYPE_I
			current_type: CL_TYPE_I
		do
			current_type := context.current_type
			target_type ?= Context.real_type (info.type)

			make_breakable (ba);
			if target_type.is_separate then
				
			else
				ba.append (Bc_create)
				ba.append (Bc_create_exp)
				if call /= Void then
					ba.append ('%/001/')
				else
					ba.append ('%/000/')
				end
				info.make_byte_code (ba)
				if call /= Void then
					call.set_info (info)
					call.make_creation_byte_code (ba)
				end
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
			Result := context.real_type (info.type)
		end

feature -- Generation

	generate is
				-- Generate C code for creation expression
			local
				is_expanded: BOOLEAN
				target_type: CL_TYPE_I
				current_type: CL_TYPE_I
				buf: GENERATION_BUFFER
			do
				generate_line_info

				current_type := context.current_type
				target_type ?= Context.real_type (info.type)

				context.set_current_type (target_type)

				if call /= Void then
					call.set_type (target_type)
					call.set_info (info)
					call.generate
				else
					info.generate_start (Current)
					info.generate_gen_type_conversion (Current)
					register.print_register
					buf := buffer
					buf.putstring (" = RTLN(")
					info.generate
					buf.putstring (");")
					buf.new_line
					info.generate_end (Current)
					if
						context.workbench_mode
						or else context.assertion_level.check_invariant
					then
						buf.putstring ("RTCI(")
						register.print_register
						buf.putstring (gc_rparan_comma)
						buf.new_line
					end
				end

				context.set_current_type (current_type)
			end

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end
	
end -- class CREATION_EXPR_B
