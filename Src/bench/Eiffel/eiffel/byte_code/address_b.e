indexing
	description: "Result of applying `$' on an Eiffel routine"
	date: "$Date$"
	revision: "$Revision$"

class ADDRESS_B

inherit
	EXPR_B
		redefine
			print_register, make_byte_code, generate_il
		end

	SHARED_C_LEVEL
		export
			{NONE} all
		end

	SHARED_TABLE
		export
			{NONE} all
		end

	SHARED_DECLARATIONS
		export
			{NONE} all
		end

	SHARED_INCLUDE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (cl_id: INTEGER; f: FEATURE_I) is
			-- Initialization.
		require
			valid_class_id: cl_id > 0
			f_not_void: f /= Void
		do
			if System.il_generation then
				feature_id := f.origin_feature_id
				internal_data := f.origin_class_id
			else
				feature_id := f.feature_id
				internal_data := f.rout_id_set.first
			end
			feature_type := f.type.actual_type.type_i.c_type
			record_feature (cl_id, feature_id)
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_address_b (Current)
		end

feature -- Access

	feature_id: INTEGER
			-- Feature id of feature.

	routine_id: INTEGER is
			-- Routine ID of feature.
		require
			not_il_generation: not System.il_generation
		do
			Result := internal_data
		ensure
			valid_id: Result > 0
		end

	class_id: INTEGER is
			-- Class ID of feature.
		require
			il_generation: System.il_generation
		do
			Result := internal_data
		ensure
			valid_id: Result > 0
			valid_class: System.class_of_id (Result) /= Void
		end

	feature_type: TYPE_C
			-- Address type.

feature -- Status report

	type: POINTER_I is
			-- Expression type of $ operator.
		once
			create Result
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- C code generation

	print_register is
			-- Generate feature address
		local
			internal_name: STRING
			table_name: STRING
			rout_table: ROUT_TABLE
			buf: GENERATION_BUFFER
			array_index: INTEGER
			class_type: CLASS_TYPE
			class_type_id: INTEGER
			l_rout_id: INTEGER
		do
			buf := buffer
			if context.workbench_mode then
				buf.put_string ("(EIF_POINTER) RTWPP(")
				buf.put_static_type_id (context.class_type.static_type_id)
				buf.put_string (gc_comma)
				buf.put_integer (feature_id)
				buf.put_character (')')
			else
				l_rout_id := routine_id
				class_type := context.class_type
				class_type_id := class_type.type_id
				array_index := Eiffel_table.is_polymorphic (l_rout_id, class_type_id, True)
				if array_index = -2 then
						-- Function pointer associated to a deferred feature
						-- without any implementation
					buf.put_string ("NULL")
				elseif array_index >= 0 then
					table_name := "f"
					table_name.append (Encoder.address_table_name (feature_id,
								class_type.static_type_id))

					buf.put_string ("(EIF_POINTER) ")
					buf.put_string (table_name)

						-- Mark table used
					Eiffel_table.mark_used (l_rout_id)

						-- Remember extern declarations
					Extern_declarations.add_routine (feature_type, table_name)
				else
					rout_table ?= Eiffel_table.poly_table (l_rout_id)
					rout_table.goto_implemented (class_type_id)
					if rout_table.is_implemented then
						internal_name := rout_table.feature_name
						buf.put_string ("(EIF_POINTER) ")
						buf.put_string (internal_name)

						shared_include_queue.put (
							System.class_type_of_id (rout_table.item.written_type_id).header_filename)
					else
							-- Call to a deferred feature without implementation
						buf.put_string ("NULL")
					end
				end
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for function pointer address.
		local
			target_type: CL_TYPE_I
			target_feature_id: like feature_id
		do
			target_type := context.current_type
			if target_type.is_expanded then
				target_feature_id := target_type.base_class.feature_of_rout_id (
					system.class_of_id (class_id).feature_of_feature_id (feature_id).rout_id_set.first
				).feature_id
			else
				target_type := il_generator.implemented_type (class_id, target_type)
				target_feature_id := feature_id
			end
			il_generator.generate_routine_address (target_type, target_feature_id)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a function pointer address
		do
			ba.append (Bc_addr)
			ba.append_integer (feature_id)
			ba.append_short_integer (context.class_type.static_type_id - 1)
				-- Use RTWPP
			ba.append_short_integer (0)
		end

feature {NONE} -- Implementation: access

	internal_data: INTEGER
			-- Hold value of `routine_id' in normal Eiffel generation
			-- or `class_id' in IL code generation.

feature {NONE} -- Address table

	record_feature (cl_id: INTEGER; f_id: INTEGER) is
			-- Record the feature in the address table if it is not there.
			-- A refreezing will occur.
		local
			address_table: ADDRESS_TABLE
		do
			address_table := System.address_table

			if not address_table.has (cl_id, f_id) then
					-- Record the feature
				address_table.record (cl_id, f_id)
			end
		end

end -- class ADDRESS_B
