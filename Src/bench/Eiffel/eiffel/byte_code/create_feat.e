indexing
	description: "Creation of an object bounded to type of a feature during execution."
	date: "$Date$"
	revision: "$Revision$"

class CREATE_FEAT 

inherit
	CREATE_INFO
		redefine
			generate_cid, make_gen_type_byte_code, generate_reverse,
			generate_cid_array, generate_cid_init
		end

	SHARED_TABLE
		export
			{NONE} all
		end

	SHARED_DECLARATIONS
		export
			{NONE} all
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

	SHARED_GEN_CONF_LEVEL
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (f_id, f_rout_id: INTEGER; a_class: CLASS_C) is
			-- Initialize Current with `f_id' and `f_name_id'
			-- in context of class `a_class_id'.
		require
			valid_f_id: f_id > 0
			valid_f_rout_id: f_rout_id > 0
			valid_class: a_class /= Void
		do
			feature_id := f_id
			routine_id := f_rout_id

				-- It is faster to force the same value again
				-- in `type_set' than testing if it is already
				-- present or not and then insert it.
			System.type_set.force (f_rout_id)
			
				-- Add it to current class too for IL code generation.
			if System.il_generation then
				a_class.extend_type_set (f_rout_id)
			end
		ensure
			feature_id_set: feature_id = f_id
			routine_id_set: routine_id = f_rout_id
		end
		
feature -- Access

	feature_id: INTEGER
			-- Feature ID to create.

	routine_id: INTEGER
			-- Routine ID of feature.

feature -- C code generation

	analyze is
			-- We need Dtype(Current).
		local
			entry: POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				entry := Eiffel_table.poly_table (routine_id)
				if entry /= Void and then (not entry.has_one_type or else is_generic) then
					context.mark_current_used
					context.add_dt_current
				end
			else
				context.mark_current_used
				context.add_dt_current
			end
		end

	generate is
			-- Generate the creation type of the feature.
		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			gen_type: GEN_TYPE_I
			buffer: GENERATION_BUFFER
		do
			buffer := context.buffer
			buffer.putstring ("RTLN(")

			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table = Void then
					-- Creation with `like feature' where
					-- feature is deferred and has no effective
					-- version anywhere.
					-- Create anything - cannot be called anyway

					buffer.putint (0)
				else
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							buffer.putstring ("typres")
						else
							buffer.putint (table.first.feature_type_id - 1)
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (routine_id)

						buffer.putstring ("RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putchar (',')
						buffer.putstring (table_name)
						buffer.putstring (", ")
						buffer.putstring (table_name)
						buffer.putstring ("_gen_type")
						buffer.putstring (", ")
						context.Current_register.print_register
						buffer.putstring (", ")
						buffer.putint (table.min_type_id - 1)
						buffer.putchar (')')

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (routine_id)
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name)
					end
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("RTWPCT(")
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma)
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("RTWCT(")
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1)
					buffer.putstring (gc_comma)
					buffer.putint (feature_id)
				end

				buffer.putstring (gc_comma)
				context.Current_register.print_register
				buffer.putchar (')')
			end
			buffer.putchar (')')
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for an anchored creation type.
		local
			l_type_feature: TYPE_FEATURE_I
		do
				-- Generate call to feature that will give the type we want to create.
			generate_il_type

				-- Evaluate the computed type and create a corresponding object type.
			il_generator.generate_current
			il_generator.create_type
			
			l_type_feature := context.class_type.
				associated_class.anchored_features.item (routine_id)
				
			il_generator.generate_check_cast (Void,
				context.real_type (l_type_feature.type.actual_type.type_i))
		end

	generate_il_type is
			-- Generate IL code to load type of anchored creation type.
		local
			l_decl_type: CL_TYPE_I
			l_type_feature: TYPE_FEATURE_I
		do
				-- Generate call to feature that will give the type we want to create.
			l_type_feature := context.class_type.
				associated_class.anchored_features.item (routine_id)

			il_generator.generate_current
			l_decl_type := il_generator.implemented_type (l_type_feature.origin_class_id,
				context.current_type)
			il_generator.generate_feature_access (l_decl_type,
				l_type_feature.origin_feature_id, 0, True, True)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an anchored creation type.
		local
			rout_info: ROUT_INFO
		do
			if context.current_type.base_class.is_precompiled then
				ba.append (Bc_pclike)
				ba.append_short_integer (context.class_type.static_type_id-1)
				rout_info := System.rout_info_table.item (routine_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append (Bc_clike)
				ba.append_short_integer
					(context.current_type.associated_class_type.static_type_id - 1)
				ba.append_integer (feature_id)
			end
		end

feature -- Genericity

	generate_gen_type_conversion (node : BYTE_NODE) is

		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= type_to_create

			if gen_type /= Void then
				node.generate_gen_type_conversion (gen_type)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			gen_type: GEN_TYPE_I
		do
			buffer.putint (Like_pfeature_type)
			buffer.putstring (", ")
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table = Void then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					buffer.putint (Internal_type)
					buffer.putchar (',')
					buffer.putint (Internal_type)
					buffer.putchar (',')
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							buffer.putint (Internal_type)
							buffer.putchar (',')
							gen_type.generate_cid (buffer, final_mode, True)
						else
							buffer.putint (table.first.feature_type_id - 1)
							buffer.putchar (',')
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (routine_id)

						buffer.putstring ("RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putchar (',')
						buffer.putstring (table_name)
						buffer.putstring (", ")
						buffer.putstring (table_name)
						buffer.putstring ("_gen_type")
						buffer.putstring (", ")
						context.Current_register.print_register
						buffer.putstring (", ")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring ("), ")

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (routine_id)
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name)
					end
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("RTWPCT(")
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma)
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("RTWCT(")
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1)
					buffer.putstring (gc_comma)
					buffer.putint (feature_id)
				end

				buffer.putstring (gc_comma)
				context.Current_register.print_register
				buffer.putstring ("), ")
			end
		end

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			gen_type: GEN_TYPE_I
		do
			buffer.putint (Like_pfeature_type)
			buffer.putstring (", ")
			dummy := idx_cnt.next
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table = Void then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					buffer.putint (Internal_type)
					buffer.putchar (',')
					buffer.putint (Internal_type)
					buffer.putchar (',')
					dummy := idx_cnt.next
					dummy := idx_cnt.next
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							buffer.putint (Internal_type)
							buffer.putchar (',')
							dummy := idx_cnt.next
							gen_type.generate_cid_array (buffer, 
													final_mode, True, idx_cnt)
						else
							buffer.putint (table.first.feature_type_id - 1)
							buffer.putchar (',')
							dummy := idx_cnt.next
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (routine_id)

						buffer.putstring ("0, ")
						dummy := idx_cnt.next

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (routine_id)
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name)
					end
				end
			else
				buffer.putstring ("0, ")
				dummy := idx_cnt.next
			end
		end

	generate_cid_init (buffer : GENERATION_BUFFER; 
					   final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy: INTEGER
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			gen_type: GEN_TYPE_I
		do
			dummy := idx_cnt.next
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table = Void then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					dummy := idx_cnt.next
					dummy := idx_cnt.next
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							dummy := idx_cnt.next
							gen_type.generate_cid_init (buffer, final_mode, True, idx_cnt)
						else
							dummy := idx_cnt.next
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (routine_id)

						buffer.putstring ("typarr[")
						buffer.putint (idx_cnt.value)
						buffer.putstring ("] = RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putchar (',')
						buffer.putstring (table_name)
						buffer.putstring (", ")
						buffer.putstring (table_name)
						buffer.putstring ("_gen_type")
						buffer.putstring (", ")
						context.Current_register.print_register
						buffer.putstring (", ")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring (");")
						buffer.new_line
						dummy := idx_cnt.next
					end
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("typarr[")
					buffer.putint (idx_cnt.value)
					buffer.putstring ("] = RTWPCT(")
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma)
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("typarr[")
					buffer.putint (idx_cnt.value)
					buffer.putstring ("] = RTWCT(")
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1)
					buffer.putstring (gc_comma)
					buffer.putint (feature_id)
				end

				buffer.putstring (gc_comma)
				context.Current_register.print_register
				buffer.putstring (");")
				buffer.new_line
				dummy := idx_cnt.next
			end
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		local
			rout_info: ROUT_INFO
		do
			if context.current_type.base_class.is_precompiled then
				ba.append_short_integer (Like_pfeature_type)
				ba.append_short_integer (context.class_type.static_type_id-1)
				rout_info := System.rout_info_table.item (routine_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append_short_integer (Like_feature_type)
				ba.append_short_integer
					(context.current_type.associated_class_type.static_type_id - 1)
				ba.append_integer (feature_id)
			end
		end

	type_to_create : CL_TYPE_I is

		local
			table : POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table /= Void and then table.has_one_type then
					Result ?= table.first.type
				end
			end
		end

	generate_reverse (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table = Void then
					-- Creation with `like feature' where
					-- feature is deferred and has no effective
					-- version anywhere.
					-- Create anything - cannot be called anyway

					buffer.putstring ("0")
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type

						buffer.putint (table.first.feature_type_id - 1)
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (routine_id)

						buffer.putstring ("RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putchar (',')
						buffer.putstring (table_name)
						buffer.putstring (", ")
						buffer.putstring (table_name)
						buffer.putstring ("_gen_type")
						buffer.putstring (", ")
						context.Current_register.print_register
						buffer.putstring (", ")
						buffer.putint (table.min_type_id - 1)
						buffer.putchar (')')

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (routine_id)
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name)
					end
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("RTWPCT(")
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma)
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("RTWCT(")
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1)
					buffer.putstring (gc_comma)
					buffer.putint (feature_id)
				end

				buffer.putstring (gc_comma)
				context.Current_register.print_register
				buffer.putstring (")")
			end
		end

invariant
	inserted_in_type_set: System.type_set.has (routine_id)
	
end -- class CREATE_FEAT
