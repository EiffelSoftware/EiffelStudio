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
			line_number, set_line_number, has_call, allocates_memory
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
		do
			create Result
			Result.set_info (info)
			Result.set_type (type)
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
				call.analyze_on (register)
			end
		end

	unanalyze is
		do
			Precursor {ACCESS_B}
			if call /= Void then
				call.unanalyze
			end
		end

feature -- Status report

	has_call: BOOLEAN is 
			-- Does current node include a call?
		do
			Result := call /= Void
		end

	allocates_memory: BOOLEAN is True
			-- Current always allocates memory.

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

	info: CREATE_INFO
			-- Creation info for creation the right type

	call: CALL_ACCESS_B
			-- Call after creation expression: can be Void.

	line_number: INTEGER
			-- Line number where construct begins in the Eiffel source.
		
	nested_b: NESTED_B is
			-- Create a fake nested so that `call.is_first' is False.
		do
			create Result
			Result.set_target (Current)
			Result.set_message (call)
		end

feature -- Settings

	set_info (i: like info) is
			-- Assign `i' to `info'.
		require
			i_not_void: i /= Void
		do
			info := i
		ensure
			info_set: info = i
		end

	set_call (c: like call) is
			-- Assign `c' to `call'.
		require
			c_not_void: c /= Void
		do
			call := c
		ensure
			call_set: call = c
		end

	set_line_number (lnr : INTEGER) is
			-- Assign `lnr' to `line_number'.
		do
			line_number := lnr
		ensure then
			line_number_set : line_number = lnr
		end

	set_type (t: like type) is
			-- Assign `t' to `type'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end
		
feature -- IL code generation

	generate_il is
			-- Generate IL code for creation instruction
		local
			is_external_class: BOOLEAN
			cl_type: CL_TYPE_I
			ext_call: EXTERNAL_B
		do
			generate_il_line_info
			cl_type ?= type
			is_external_class := cl_type /= Void and then cl_type.base_class.is_external

			if is_external_class then
					-- Creation call on external class.

				check
					call_not_void: call /= Void
				end
					-- An external class has always a feature call
					-- as `default_create' can't be called on them.
				call.set_parent (nested_b)

				ext_call ?= call
				if ext_call /= Void then
					ext_call.generate_il_creation
				else
						-- External class with a standard Eiffel feature can
						-- only be a NATIVE_ARRAY.
					call.generate_il
				end

				call.set_parent (Void)
			else
					-- Standard creation call
				info.generate_il
				if call /= Void then
					il_generator.duplicate_top
					call.set_parent (nested_b)
					call.generate_il_call (False)
					call.set_parent (Void)
				end
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a creation instruction
		do
				-- Since we have forbidden creation of basic type in
				-- the corresponding Eiffel classes, there is nothing special
				-- that needs to be done.
			ba.append (Bc_create)
			
				-- If there is a call, we need to duplicate newly created object
				-- after its creation. This information is used by the runtime
				-- to do this duplication.
			if call /= Void then
				ba.append ('%/001/')
			else
				ba.append ('%/000/')
			end
			
				-- Create associated object.
			info.make_byte_code (ba)
			
				-- Call creation procedure if any.
			if call /= Void then
				call.set_parent (nested_b)
				call.make_creation_byte_code (ba)
				call.set_parent (Void)
			end
				-- Runtime is in charge to make sure that newly created object
				-- has been duplicated so that we can check the invariant.
			ba.append (Bc_create_inv)
		end

feature -- Comparisons

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			creation_expr_b: CREATION_EXPR_B
		do
			creation_expr_b ?= other
			Result := creation_expr_b /= Void
		end

feature -- Type info

	type: TYPE_I
			-- Current static type of creation.

feature -- Generation

	generate is
			-- Generate C code for creation expression
		local
			buf: GENERATION_BUFFER
		do
			generate_line_info
			info.generate_start (Current)
			info.generate_gen_type_conversion (Current)
			register.print_register
			buf := buffer
			buf.putstring (" = ")
			info.generate
			buf.putchar (';')
			buf.new_line
			info.generate_end (Current)

			if call /= Void then
				call.set_parent (nested_b)
				call.generate_parameters (register)
				call.generate_on (register)
				call.set_parent (Void)
				buf.putchar (';')
				buf.new_line				
				generate_frozen_debugger_hook_nested
			end
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

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end
	
end -- class CREATION_EXPR_B
