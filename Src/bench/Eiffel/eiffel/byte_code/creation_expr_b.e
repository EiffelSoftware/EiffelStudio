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
		
	count_register: REGISTER
			-- Store size of SPECIAL instance to create is stored if needed.

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
		local
			l_call: like call
			l_type: like type
		do
			l_type := real_type (type)
			if not l_type.is_basic then
				info.analyze
				get_register
				l_call := call
				if l_call /= Void then
					if l_call.routine_id = system.special_make_id then
						check
							is_special_call_valid: is_special_call_valid
						end
						l_call.parameters.first.analyze
					else
						l_call.set_parent (nested_b)
						l_call.set_register (register)
						l_call.set_need_invariant (False)
						l_call.analyze_on (register)
						l_call.set_parent (Void)
					end
				end
			else
				create {REGISTER} register.make (l_type.c_type)
			end
		end

	unanalyze is
			-- Unanalyze creation code
		local
			l_call: like call
		do
			if not real_type (type).is_basic then
				Precursor {ACCESS_B}
				l_call := call
				if l_call /= Void then
					if l_call.routine_id = system.special_make_id then
						check
							is_special_call_valid: is_special_call_valid
						end
						l_call.parameters.first.unanalyze	
					else
						l_call.unanalyze
					end
				end
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
			-- Assign `c' to `call'. `c' maybe Void in case of call
			-- to `default_create' from ANY.
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
			line_number_set: line_number = lnr
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
			ext_call: EXTERNAL_B
		do
			if type.is_external then
					-- Creation call on external class.
				if call /= Void then
					call.set_parent (nested_b)
					ext_call ?= call
					if ext_call /= Void then
						ext_call.generate_il_creation
					else
							-- External class with a standard Eiffel feature can
							-- only be a NATIVE_ARRAY.
						call.generate_il_call (False)
					end
					call.set_parent (Void)
				else
						-- We called `default_create' on an external class.
					info.generate_il
				end
			else
				if real_type (type).is_basic then
					il_generator.put_default_value (real_type (type))
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
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a creation instruction
		local
			l_basic_type: BASIC_I
			l_special_type: GEN_TYPE_I
			l_class_type: SPECIAL_CLASS_TYPE
			l_call: like call
		do
			l_basic_type ?= real_type (type)
			if l_basic_type /= Void then
					-- Special cases for basic types where nothing needs to be created, we
					-- simply need to push a default value as their creation procedure
					-- is `default_create' and it does nothing.
				l_basic_type.make_default_byte_code (ba)
			else
				l_call := call
				if l_call /= Void and then l_call.routine_id = system.special_make_id then
					l_special_type ?= context.creation_type (type)
					check
						is_special_call_valid: is_special_call_valid
						is_special_type: l_special_type /= Void and then
							l_special_type.base_class.lace_class = system.special_class
					end
					l_class_type ?= l_special_type.associated_class_type
					check
						l_class_type_not_void: l_class_type /= Void
					end
					l_call.parameters.first.make_byte_code (ba)
					ba.append (Bc_spcreate)
					info.make_byte_code (ba)
					l_class_type.make_creation_byte_code (ba)
				else
					ba.append (Bc_create)
						-- If there is a call, we need to duplicate newly created object
						-- after its creation. This information is used by the runtime
						-- to do this duplication.
					ba.append_boolean (l_call /= Void)
					
						-- Create associated object.
					info.make_byte_code (ba)
					
						-- Call creation procedure if any.
					if l_call /= Void then
						l_call.set_parent (nested_b)
						l_call.make_creation_byte_code (ba)
						l_call.set_parent (Void)
					end
				end
					-- Runtime is in charge to make sure that newly created object
					-- has been duplicated so that we can check the invariant.
				ba.append (Bc_create_inv)
			end
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
			l_basic_type: BASIC_I
			l_call: like call
			l_special_creation: BOOLEAN
			l_special_type: GEN_TYPE_I
			l_class_type: SPECIAL_CLASS_TYPE
		do
			buf := buffer
			generate_line_info

			l_basic_type ?= real_type (type)
			l_call := call
			l_special_creation := l_basic_type = Void and then
				l_call /= Void and then l_call.routine_id = system.special_make_id
			if l_basic_type /= Void then
				register.print_register
				buf.put_string (" = ")
				l_basic_type.generate_default_value (buf)
				buf.put_character (';')
				buf.put_new_line
			elseif l_special_creation then
				check
					is_special_call_valid: is_special_call_valid
				end
				l_special_type ?= context.creation_type (type)
				check
					is_special_type: l_special_type /= Void and then
						l_special_type.base_class.lace_class = system.special_class
				end
				l_class_type ?= l_special_type.associated_class_type
				check
					l_class_type_not_void: l_class_type /= Void
				end
				l_call.parameters.first.generate
				info.generate_start (Current)
				info.generate_gen_type_conversion (Current)
				l_class_type.generate_creation (buf, info, register, l_call.parameters.first)
				info.generate_end (Current)
			else
				info.generate_start (Current)
				info.generate_gen_type_conversion (Current)
				register.print_register
				buf.put_string (" = ")
				info.generate
				buf.put_character (';')
				buf.put_new_line
				info.generate_end (Current)
	
				if call /= Void then
					call.set_parent (nested_b)
					call.generate_parameters (register)
					call.generate_on (register)
					call.set_parent (Void)
					buf.put_character (';')
					buf.put_new_line				
					generate_frozen_debugger_hook_nested
				end
				if
					context.workbench_mode
					or else context.assertion_level.check_invariant
				then
					buf.put_string ("RTCI(")
					register.print_register
					buf.put_string (gc_rparan_semi_c)
					buf.put_new_line
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
	
feature {NONE} -- Assertion support

	is_special_call_valid: BOOLEAN is
			-- Is current creation call a call to SPECIAL.make?
		do
			Result := call /= Void and then call.parameters /= Void and then
				call.parameters.count = 1
		ensure
			is_special_call_valid: Result implies
				(call /= Void and then call.parameters /= Void and then
				call.parameters.count = 1)
		end
		
end -- class CREATION_EXPR_B
