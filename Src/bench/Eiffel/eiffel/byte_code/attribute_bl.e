-- Enlarged access to an Eiffel attribute

class ATTRIBUTE_BL  

inherit
	ATTRIBUTE_B
		redefine
			generate, print_register, free_register,
			basic_register, generate_access_on_type,
			is_polymorphic, has_call, generate_on, generate_access,
			analyze_on, analyze, set_parent, parent, set_register, register
		end

	SHARED_TABLE

	SHARED_WORKBENCH

	SHARED_DECLARATIONS

feature 

	parent: NESTED_B
			-- Parent of the current call

	set_parent (p: NESTED_B) is
			-- Assign `p' to `parent'
		do
			parent := p
		end

	register: REGISTRABLE
			-- In which register the expression is stored

	basic_register: REGISTRABLE
			-- Register used to store the metamorphosed simple type
	
	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
			register := r
		end

	print_register is
			-- Print register or generate
		do
			if real_type (type).is_none then
				buffer.putstring ("(EIF_REFERENCE) 0")
			else
				{ATTRIBUTE_B} Precursor
			end
		end

	free_register is
			-- Free registers
		do
			{ATTRIBUTE_B} Precursor	
			if basic_register /= Void then
				basic_register.free_register
			end
		end

	analyze is
			-- Analyze attribute
		do
debug
io.error.putstring ("In attribute_bl%N")
io.error.putstring (attribute_name)
io.error.new_line
end
			if not type.is_none then
				analyze_on (Current_register)
				get_register
			end
debug
io.error.putstring ("Out attribute_bl%N")
end
		end
	
	analyze_on (reg: REGISTRABLE) is
			-- Analyze access to attribute on `reg'
		local
			tmp_register: REGISTER
		do
debug
io.error.putstring ("In attribute_bl [analyze_on]: ")
io.error.putstring (attribute_name)
io.error.new_line
end
			if reg.is_current then
				context.mark_current_used
			end
				-- Check whether we'll need to compute the dynamic type
				-- of current or not.
			check_dt_current (reg)
			if context_type.is_basic then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
				!!tmp_register.make (Reference_c_type)
				basic_register := tmp_register
			end
debug
io.error.putstring ("Out attribute_bl [analyze_on]: ")
io.error.putstring (attribute_name)
io.error.new_line
end
		end

	generate is
			-- Generation of access
		do
			if not real_type (type).is_none then
				{ATTRIBUTE_B} Precursor
			end
		end

	generate_on (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		do
			generate_attribute (reg)
		end

	generate_access is
			-- Generate access to attribute
		do
			generate_attribute (Current_register)
		end

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_I
		do
				-- Do nothing if `reg' is not the current entity
			if reg.is_current then
				class_type ?= context_type
				if class_type /= Void then
					if Eiffel_table.is_polymorphic (routine_id, class_type.type_id, False) >= 0 then
						context.add_dt_current
					end
				end
			end
		end

	is_polymorphic: BOOLEAN is
			-- Is access polymorphic ?
		local
			class_type: CL_TYPE_I
			type_i: TYPE_I
		do
			type_i := context_type
			if not type_i.is_basic then
				class_type ?= type_i;	-- Cannot fail
				Result := Eiffel_table.is_polymorphic (routine_id, class_type.type_id, False) >= 0
			end
		end

	generate_attribute (reg: REGISTRABLE) is
			-- Generate attribute or NONE instance.
		do
			if type.is_none then
				buffer.putstring ("(EIF_REFERENCE) 0")
			else
					-- Generate attribute
				do_generate (reg)
			end
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate attribute in a `typ' context
		local
			table_name: STRING
			offset_class_type: CLASS_TYPE
			type_c: TYPE_C
			type_i: TYPE_I
			buf: GENERATION_BUFFER
			array_index: INTEGER
		do
			buf := buffer
			type_i := real_type (type)
			type_c := type_i.c_type
				-- No need to use dereferencing if object is an expanded
				-- or if it is a bit.
			if not type_i.is_true_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				buf.putchar ('*')
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (buf)
			end
			buf.putchar ('(')
			reg.print_register
--			if reg.is_predefined or reg.register /= No_register then
--				buf.putstring (gc_plus)
--			else
--				buf.putstring (" +")
--				buf.new_line
--				buf.indent
--			end
			array_index := Eiffel_table.is_polymorphic (routine_id, typ.type_id, False)
			if array_index >= 0 then
					-- The access is polymorphic, which means the offset
					-- is not a constant and has to be computed.
				table_name := Encoder.table_name (routine_id)
				buf.putstring (" + (")
				buf.putstring (table_name)
				buf.putchar ('-')
				buf.putint (array_index)
				buf.putchar (')')
				buf.putchar ('[')
				if reg.is_current then
					context.generate_current_dtype
				else
					buf.putstring (gc_upper_dtype_lparan)
					reg.print_register
					buf.putchar (')')
				end
				buf.putchar (']')
					-- Mark attribute offset table used.
				Eiffel_table.mark_used (routine_id)
					-- Remember external attribute offset declaration
				Extern_declarations.add_attribute_table (table_name)
			else
					-- Hardwire the offset
				offset_class_type := system.class_type_of_id (typ.type_id)
					--| In this instruction, we put `False' as second
					--| arguments. This means we won't generate anything if there is nothing
					--| to generate. Remember that `True' is used in the generation of attributes
					--| table in Final mode.
				offset_class_type.skeleton.generate_offset (buf, attribute_id, False)
			end
			buf.putchar (')')
--			if not (reg.is_predefined or reg.register /= No_register) then
--				buf.exdent
--			end
		end

	fill_from (a: ATTRIBUTE_B) is
			-- Fill in node with attribute `a'
		do
			attribute_name_id := a.attribute_name_id
			attribute_id := a.attribute_id
			type := a.type
			routine_id := a.routine_id
		end

	has_call: BOOLEAN is true
			-- The expression has at least one call
			-- Not really true but it should accelerate semi-strict boolean
			-- operations on attributes (avoid useless access).

end
