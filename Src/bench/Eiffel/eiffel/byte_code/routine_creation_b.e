class ROUTINE_CREATION_B 

inherit

	EXPR_B
		redefine
			make_byte_code, enlarged
		end

feature  -- Initialization

	init (cl_type: CL_TYPE_I; cl_id: CLASS_ID; f: FEATURE_I; r_type : GEN_TYPE_I) is
			-- Initialization
		require
			valid_type: cl_type /= Void
			valid_id: cl_id /= Void
			valid_feature: f /= Void
			valid_type: r_type /= Void
		do
			class_type := cl_type
			feature_id := f.feature_id
			rout_id := f.rout_id_set.first
			type := r_type
			record_feature (cl_id, feature_id)
		end

	set_ids (cl_type : CL_TYPE_I; r_id: ROUTINE_ID; f_id: INTEGER; r_type: GEN_TYPE_I) is
			-- Set ids and type
		require
			valid_class_type: cl_type /= Void
			valid_routine_id: r_id /= Void
			valid_type: r_type /= Void
		do
			class_type := cl_type
			rout_id := r_id
			feature_id := f_id
			type := r_type
		end
	
feature -- Attributes

	class_type: CL_TYPE_I
			-- Type of the class where feature comes from

	feature_id: INTEGER
			-- Feature id of the addressed feature

	rout_id: ROUTINE_ID
			-- Routine id of the feature

	type: GEN_TYPE_I
			-- Type of routine object

feature -- Address table

	record_feature (cl_id: CLASS_ID; f_id: INTEGER) is
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

	used (r: REGISTRABLE): BOOLEAN is
		do
		end

	enlarged: ROUTINE_CREATION_BL is
			-- Enlarge node
		do
			!!Result
			Result.set_ids (class_type, rout_id, feature_id, type)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a routine creation.
		local
			cl_type_i: CL_TYPE_I
			gen_type : GEN_TYPE_I
		do
			-- First get address
			ba.append (Bc_addr)
			ba.append_integer (feature_id)

			cl_type_i ?= context.real_type (class_type)
			ba.append_short_integer
				   (cl_type_i.associated_class_type.id.id - 1)
			-- Use RTWPPR
			ba.append_short_integer (1)
			-- Now create routine object
			ba.append (Bc_rcreate)
			cl_type_i ?= context.real_type (type)
			gen_type  ?= cl_type_i
			ba.append_short_integer (cl_type_i.type_id - 1)

			if gen_type /= Void then
				ba.append_short_integer (context.current_type.generated_id (False))
				gen_type.make_gen_type_byte_code (ba, True)
			end

			ba.append_short_integer (-1)
		end

end -- class ROUTINE_CREATION_B

