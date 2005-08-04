indexing
	description: "Byte code for creating an instance of TYPE [X] type."
	date: "$Date$"
	revision: "$Revision$"

class TYPE_EXPR_B 

inherit
	EXPR_B
		redefine
			register, set_register, analyze, generate,
			propagate, print_register, unanalyze,
			make_byte_code, generate_il,
			is_simple_expr, allocates_memory
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (v: like type_data) is
			-- Assign `v' to `type_data'.
		require
			v_not_void: v /= Void
		do
			type_data := v
		ensure
			type_data_set: type_data = v
		end

feature -- Access

	type_data: GEN_TYPE_I
			-- Character value

	type: CL_TYPE_I is
			-- String type
		do
			if is_dotnet_type then
				Result := system_type_type
			else
				Result := type_data
			end
		end

	register: REGISTRABLE
			-- Where type object is kept to ensure it is GC safe

feature -- Properties

	is_dotnet_type: BOOLEAN
			-- Is current a manifest System.Type constant?

	used (r: REGISTRABLE): BOOLEAN is
			-- Register `r' is not used for type computation
		do
		end

	is_simple_expr: BOOLEAN is True
			-- A type expression is a simple expression

	allocates_memory: BOOLEAN is True
			-- Current always allocates memory.

feature -- Settings

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r
		end

	set_is_dotnet_type (v: like is_dotnet_type) is
			-- Set `is_dotnet_type' with `v'.
		do
			is_dotnet_type := v
		ensure
			is_dotnet_type_set: is_dotnet_type = v
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a manifest type.
		local
			l_type_creator: CREATE_TYPE
		do
			if is_dotnet_type then
				il_generator.put_type_instance (
					context.real_type (type_data.true_generics.item (1)))
			else
				fixme ("Instance should be unique.")
				create l_type_creator.make (context.real_type (type_data))
				l_type_creator.generate_il
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest type
		local
			l_type_creator: CREATE_TYPE
		do
			fixme ("Instance should be unique.")
			ba.append (Bc_create)
				-- There is no feature call:
			ba.append_boolean (False)

			create l_type_creator.make (context.real_type (type_data))
			l_type_creator.make_byte_code (ba)

				-- Runtime is in charge to make sure that newly created object
				-- has been duplicated so that we can check the invariant.
			ba.append (bc_create_inv)			
		end

feature -- Code analyzis

	propagate (r: REGISTRABLE) is
			-- Propagate `r'
		do
			if not context.propagated then
				if r = No_register and r.c_type.same_class_type (c_type) then
					register := r
					context.set_propagated
				end
			end
		end

	unanalyze is
			-- Undo analysis work.
		do
			register := Void
		end

	analyze is
			-- Analyze the type
		do
				-- We get a register to store the type because of the garbage
				-- collector: assume we write f("one", "two"), then the GC
				-- could be invoked while allocating "two" and move "one" right
				-- under the back of the C (without notifying it, how could I?).
			get_register
		end

feature -- C code generation

	generate is
			-- Generate the type
		local
			buf: GENERATION_BUFFER
			l_type_creator: CREATE_TYPE
		do
			fixme ("Instance should be unique.")
			buf := buffer
			create l_type_creator.make (context.real_type (type_data))
			l_type_creator.generate_start (Current)
			l_type_creator.generate_gen_type_conversion (Current)
			register.print_register
			buf.put_string (" = ")
			l_type_creator.generate
			buf.put_character (';')
			buf.put_new_line
			l_type_creator.generate_end (Current)
		end

	print_register is
			-- Print the type (or the register in which it is held)
		do
			register.print_register
		end

feature {NONE} -- Implementation: types

	system_type_type: CL_TYPE_I is
			-- Type of SYSTEM_TYPE.
		require
			il_generation: System.il_generation
		once
			create Result.make (System.system_type_id)
		ensure
			system_type_type_not_void: Result /= Void
		end

invariant
	type_data_not_void: type_data /= Void
	type_data_generics_count: type_data.meta_generic.count = 1

end
