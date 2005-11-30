indexing
	description: "Byte code associated to agent creation"
	date: "$Date$"
	revision: "$Revision$"

class ROUTINE_CREATION_B

inherit
	EXPR_B
		redefine
			enlarged,
			has_gcable_variable, has_call, size,
			allocates_memory
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_routine_creation_b (Current)
		end

feature  -- Initialization

	init (cl_type: CL_TYPE_I; cl_id: INTEGER; f: FEATURE_I;
		  r_type : GEN_TYPE_I; args : TUPLE_CONST_B;
		  omap: ARRAY_CONST_B) is
			-- Initialization
		require
			valid_type: cl_type /= Void
			valid_id: cl_id /= 0
			valid_feature: f /= Void
			valid_type: r_type /= Void
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
			open_positions := omap
			record_feature (cl_id, feature_id)
		end

	set_ids (cl_type : CL_TYPE_I; r_id: INTEGER; f_id: INTEGER;
			 r_type : GEN_TYPE_I; args : TUPLE_CONST_B;
			 omap: ARRAY_CONST_B) is
			-- Set ids and type
		require
			valid_class_type: cl_type /= Void
			valid_routine_id: r_id /= 0
			valid_type: r_type /= Void
		do
			class_type := cl_type
			rout_id := r_id
			feature_id := f_id
			type := r_type
			arguments := args
			open_positions := omap
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

	open_positions: ARRAY_CONST_B
			-- Index mapping for open arguments

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

feature -- Status report

	allocates_memory: BOOLEAN is True
			-- Current always allocates memory.

	has_gcable_variable: BOOLEAN is
			-- Is the expression using a GCable variable ?
		do
			if arguments /= Void then
				Result := arguments.has_gcable_variable
			end

			if open_positions /= Void then
				Result := Result or else open_positions.has_gcable_variable
			end
		end

	has_call: BOOLEAN is
			-- Is the expression using a call ?
		do
			if arguments /= Void then
				Result := arguments.has_call
			end

			if open_positions /= Void then
				Result := Result or else open_positions.has_call
			end
		end

	used (r: REGISTRABLE): BOOLEAN is
		do
			if arguments /= Void then
				Result := arguments.used (r)
			end

			if open_positions /= Void then
				Result := Result or else open_positions.used (r)
			end
		end

	enlarged: ROUTINE_CREATION_BL is
			-- Enlarge node
		local
			omap_enl : ARRAY_CONST_B
		do
			create Result

			if open_positions /= Void then
				omap_enl := open_positions.enlarged
			end

			if arguments /= Void then
				Result.set_ids (class_type, rout_id, feature_id, type,
								arguments.enlarged, omap_enl)
			else
				Result.set_ids (class_type, rout_id, feature_id, type,
								Void, omap_enl)
			end
		end

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

end -- class ROUTINE_CREATION_B
