class ROUTINE_CREATION_B 

inherit

	EXPR_B
		redefine
			make_byte_code, enlarged, generate_il,
			has_gcable_variable, has_call, size
		end

feature  -- Initialization

	init (cl_type: CL_TYPE_I; cl_id: INTEGER; f: FEATURE_I; 
		  r_type : GEN_TYPE_I; args : TUPLE_CONST_B;
		  omap, cmap : ARRAY_CONST_B) is
			-- Initialization
		require
			valid_type: cl_type /= Void
			valid_id: cl_id /= 0
			valid_feature: f /= Void
			valid_type: r_type /= Void
			valid_maps: omap /= Void or cmap /= Void
		do
			class_type := cl_type
			if System.il_generation then
				class_id := f.origin_class_id
				feature_id := f.origin_feature_id
			else
				class_id := f.written_in
				feature_id := f.feature_id
			end
			rout_id := f.rout_id_set.first
			type := r_type
			arguments := args
			open_map := omap
			closed_map := cmap
			record_feature (cl_id, feature_id)
		end

	set_ids (cl_type : CL_TYPE_I; r_id: INTEGER; f_id: INTEGER;
			 r_type : GEN_TYPE_I; args : TUPLE_CONST_B;
			 omap, cmap : ARRAY_CONST_B) is
			-- Set ids and type
		require
			valid_class_type: cl_type /= Void
			valid_routine_id: r_id /= 0
			valid_type: r_type /= Void
			valid_maps: omap /= Void or cmap /= Void
		do
			class_type := cl_type
			rout_id := r_id
			feature_id := f_id
			type := r_type
			arguments := args
			open_map := omap
			closed_map := cmap
		end
	
feature -- Attributes

	class_type: CL_TYPE_I
			-- Type of the class where feature comes from

	feature_id: INTEGER
			-- Feature id of the addressed feature
			
	class_id: INTEGER
			-- Class ID which defines current feature.

	rout_id: INTEGER
			-- Routine id of the feature

	type: GEN_TYPE_I
			-- Type of routine object

	arguments: TUPLE_CONST_B
			-- Argument list

	open_map: ARRAY_CONST_B
			-- Index mapping for open arguments

	closed_map: ARRAY_CONST_B
			-- Index mapping for closed arguments

feature -- Address table

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

feature

	has_gcable_variable: BOOLEAN is
			-- Is the expression using a GCable variable ?
		do
			if arguments /= Void then
				Result := arguments.has_gcable_variable
			end

			if open_map /= Void then
				Result := Result or else open_map.has_gcable_variable
			end

			if closed_map /= Void then
				Result := Result or else closed_map.has_gcable_variable
			end
		end

	has_call: BOOLEAN is
			-- Is the expression using a call ?
		do
			if arguments /= Void then
				Result := arguments.has_call
			end

			if open_map /= Void then
				Result := Result or else open_map.has_call
			end

			if closed_map /= Void then
				Result := Result or else closed_map.has_call
			end
		end

	used (r: REGISTRABLE): BOOLEAN is
		do
			if arguments /= Void then
				Result := arguments.used (r)
			end

			if open_map /= Void then
				Result := Result or else open_map.used (r)
			end

			if closed_map /= Void then
				Result := Result or else closed_map.used (r)
			end
		end

	enlarged: ROUTINE_CREATION_BL is
			-- Enlarge node
		local
			omap_enl, cmap_enl : ARRAY_CONST_B
		do
			!!Result

			if open_map /= Void then
				omap_enl := open_map.enlarged
			end
			if closed_map /= Void then
				cmap_enl := closed_map.enlarged
			end

			if arguments /= Void then
				Result.set_ids (class_type, rout_id, feature_id, type,
								arguments.enlarged, omap_enl, cmap_enl)
			else
				Result.set_ids (class_type, rout_id, feature_id, type,
								Void, omap_enl, cmap_enl)
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for routine creation.
		local
			set_rout_disp_feat: FEATURE_I
			real_ty: GEN_TYPE_I
			l_decl_type: CL_TYPE_I
			cl_type: like class_type
		do
			real_ty ?= context.real_type (type)
			(create {CREATE_TYPE}.make (real_ty)).generate_il
			il_generator.duplicate_top

			set_rout_disp_feat := real_ty.base_class.feature_table.
				item_id (feature {PREDEFINED_NAMES}.set_rout_disp_name_id)
			l_decl_type := il_generator.implemented_type (set_rout_disp_feat.origin_class_id,
				real_ty)

			cl_type := il_generator.implemented_type (class_id, class_type)
			il_generator.put_method_token (cl_type, feature_id)

				-- Arguments
			if arguments /= Void then
				arguments.generate_il
			else
				il_generator.put_void
			end

				-- Open map
			if open_map /= Void then
				open_map.generate_il
			else
				il_generator.put_void
			end

				-- Closed map
			if closed_map /= Void then
				closed_map.generate_il
			else
				il_generator.put_void
			end

			il_generator.generate_feature_access (l_decl_type, set_rout_disp_feat.origin_feature_id, True)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a routine creation.
		local
			cl_type_i: CL_TYPE_I
			gen_type : GEN_TYPE_I
		do
				-- Arguments
			if arguments /= Void then
				arguments.make_byte_code (ba)
			end

				-- Open map
			if open_map /= Void then
				open_map.make_byte_code (ba)
			end

				-- Closed map
			if closed_map /= Void then
				closed_map.make_byte_code (ba)
			end

				-- Get address of routine
			ba.append (Bc_addr)
			ba.append_integer (feature_id)

			cl_type_i ?= context.real_type (class_type)
			ba.append_short_integer (cl_type_i.associated_class_type.static_type_id - 1)
				-- Use RTWPPR
			ba.append_short_integer (1)

				-- Get address of true Eiffel routine
			ba.append (Bc_addr)
			ba.append_integer (feature_id)

			cl_type_i ?= context.real_type (class_type)
			ba.append_short_integer (cl_type_i.associated_class_type.static_type_id - 1)
				-- Use RTWPP
			ba.append_short_integer (0)

				-- Now create routine object
			ba.append (Bc_rcreate)

			if arguments /= Void then
					-- We have arguments (a TUPLE) on the stack
				ba.append_short_integer (1)
			else
					-- We don't have arguments on the stack
				ba.append_short_integer (0)
			end

			if open_map /= Void then
					-- We have an open map
				ba.append_short_integer (1)
			else
					-- We don't have an open map
				ba.append_short_integer (0)
			end

			if closed_map /= Void then
					-- We have a closed map
				ba.append_short_integer (1)
			else
					-- We don't have a closed map
				ba.append_short_integer (0)
			end

			cl_type_i ?= context.real_type (type)
			gen_type  ?= cl_type_i
			ba.append_short_integer (cl_type_i.type_id - 1)

			if gen_type /= Void then
				ba.append_short_integer (context.current_type.generated_id (False))
				gen_type.make_gen_type_byte_code (ba, True)
			end

			ba.append_short_integer (-1)
		end

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

end -- class ROUTINE_CREATION_B
