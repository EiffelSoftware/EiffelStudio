indexing
	description: "Byte code for creation expression"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_B

inherit
	ACCESS_B
		redefine
			make_byte_code, analyze, unanalyze,
			generate, register, get_register,
			enlarged, size, generate_il, is_simple_expr, is_single,
			line_number, set_line_number
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
		do
			create {REGISTER} register.make (Reference_c_type)
		end

feature -- C code generation

	enlarged: CREATION_EXPR_B is
			-- Enlarge current_node
		local
			call_b: CREATION_EXPR_CALL_B
		do
			create Result.make
			Result.set_info (info)
			if call /= Void then
				call_b ?= call.enlarged
				check
					call_b_not_void: call_b /= Void
				end
				Result.set_call (call_b)
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

	unanalyze is
		do
			Precursor {ACCESS_B}
			if call /= Void then
				call.unanalyze
			end
		end

	is_single: BOOLEAN is
			-- True if no call after inline object creation or if call
			-- `is_single'.
		do
			Result := call = Void or else call.is_single
		end

	is_simple_expr: BOOLEAN is
			-- True if no call after inline object creation or if call
			-- `is_simple_expr'.
		do
			Result := call = Void or else call.is_simple_expr
		end

feature -- Access

	info: CREATE_TYPE
			-- Creation info for creation the right type

	call: CREATION_EXPR_CALL_B
			-- Call after creation expression: can be Void.

	line_number: INTEGER
			-- Line number where construct begins in the Eiffel source.
			
feature -- Settings

	set_info (i: CREATE_TYPE) is
			-- Assign `i' to `info'.
		do
			info := i
		ensure
			info_set: info = i
		end

	set_call (n: CREATION_EXPR_CALL_B) is
			-- Assign `i' to `call'.
		do
			call := n
		ensure
			call_set: call = n
		end

	set_line_number (lnr : INTEGER) is
		do
			line_number := lnr
		ensure then
			line_number_set : line_number = lnr
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for creation instruction
		local
			create_type: CREATE_TYPE
			is_external_class: BOOLEAN
			cl_type: CL_TYPE_I
		do
			generate_il_line_info
			create_type ?= info	
			check
				create_type_not_void: create_type /= Void
			end
			cl_type ?= create_type.type
			check
				cl_type_not_void: cl_type /= Void
			end

			if cl_type.is_reference then
				is_external_class := cl_type.base_class.is_external

				if is_external_class then
						-- Creation call on external class.
					check
						call_not_void: call /= Void
					end
						-- An external class has always a feature call
						-- as `default_create' can't be called on them.
					context.set_il_external_creation (True)
					call.set_parent (create {NESTED_B})
					call.set_info (info)
					call.generate_il
					call.set_parent (Void)
					context.set_il_external_creation (False)
				else
						-- Standard creation call
					info.generate_il
					if call /= Void then
						il_generator.duplicate_top
						call.set_info (info)
						call.set_parent (create {NESTED_B})
						call.generate_il
						call.set_parent (Void)
					end
				end
			else
					-- Creation on expanded or basic types.
				if call /= Void then
					il_generator.duplicate_top
					call.set_info (info)
					call.generate_il
				end
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a creation instruction
		do
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

feature

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			creation_expr_b: CREATION_EXPR_B
		do
			creation_expr_b ?= other
			Result := creation_expr_b /= Void
		end

feature -- Type info

	type: TYPE_I is
			-- Current type
		do
			Result := context.creation_type (info.type)
		end

feature -- Generation

	generate is
			-- Generate C code for creation expression
		local
			buf: GENERATION_BUFFER
		do
			generate_line_info

			if call /= Void then
				call.set_info (info)
				call.generate
				generate_frozen_debugger_hook_nested
			else
				info.generate_start (Current)
				info.generate_gen_type_conversion (Current)
				register.print_register
				buf := buffer
				buf.putstring (" = ")
				info.generate
				buf.putchar (';')
				buf.new_line
				info.generate_end (Current)
				if
					context.workbench_mode
					or else context.assertion_level.check_invariant
				then
					buf.putstring ("RTCI(")
					register.print_register
					buf.putstring (gc_rparan_semi_c)
					buf.new_line
				end
			end
		end

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end
	
end -- class CREATION_EXPR_B
