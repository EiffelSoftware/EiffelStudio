class INLINER

inherit
	SHARED_SERVER
	COMPILER_EXPORTER
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

creation
	make

feature

	make is
		local
			nb: INTEGER
		do
			inlining_on := System.inlining_on

			nb := System.body_index_counter.count
			!! processed_features.make (1, nb)
			!! to_be_inlined.make (1, nb)

			min_inlining_threshold := System.inlining_size
		end

feature {NONE}

	min_inlining_threshold: INTEGER
			-- Byte code smaller than `min_inlining_threshold' will be inlined
			-- even if they are called several times

	processed_features: ARRAY [BOOLEAN]
			-- Is item at index `body_index' to be processed?

	to_be_inlined: ARRAY [BOOLEAN]
			-- Is item at ìndex `body_index' to be processed?

feature -- Current inlined feature

	set_inlined_feature (bc: INLINED_FEAT_B) is
		do
			inlined_feature := bc
		end

	inlined_feature: INLINED_FEAT_B

feature  -- Status

	inlining_on: BOOLEAN;
			-- In inlining on ?

	current_feature_inlined: BOOLEAN;

	set_current_feature_inlined is
		do
			current_feature_inlined := True
		end

	reset is
		do
			current_feature_inlined := False
		end

feature -- Conversion

	bindex_cid_table: EXTEND_TABLE [INTEGER, INTEGER] is
			-- Table with `body_index' as keys and `class_id' as items.
		once
			Result := Depend_server.bindex_cid_table
		end

feature -- Status

	inline (type: TYPE_I; body_index: INTEGER): BOOLEAN is
			-- Can we inline `f' ?
		require
			is_inlining_enabled: inlining_on
		do
			if not processed_features.item (body_index) then
				processed_features.put (True, body_index)
				if can_be_inlined (type, body_index) then
					to_be_inlined.put (True, body_index)
					Result := True
				end
			else
				Result := to_be_inlined.item (body_index)
			end
		end

	can_be_inlined (type: TYPE_I; body_index: INTEGER): BOOLEAN is
			-- Tell us if we can inline the code corresponding to `body_index'
		local
			byte_code: BYTE_CODE;
			i: INTEGER
			type_i: TYPE_I	
			types: ARRAY [TYPE_I]
			wc: CLASS_C
			cid: INTEGER
		do
				-- Make sure we can find the BYTE_CODE
 			if byte_server.server_has (body_index) then
 				byte_code := Byte_server.disk_item (body_index)
 			end

				-- A feature call can be inlined only if it is not a call
				-- to a deferred feature or a once. Previously this computation
				-- was done in FEATURE_I and its descendants. This computation was
				-- not done in the case of the following descendants and was returning
				-- always false:
				--  * EXTERNAL_I
				--  * INVARIANT_FEAT_I
				--  * ONCE_PROC_I
				--  * DEF_PROC_I
				--  * CONSTANT_I
				-- For INVARIANT_FEAT_I, EXTERNAL_I and CONSTANT_I, the current feature
				-- won't be called because their version of `inlined_byte_code' does
				-- not call this computation. Only for ONCE_PROC_I and DEF_PROC_I, we
				-- have to do a special check, and since the information is in BYTE_CODE
				-- we can do it easily in order to avoid the inlining.
			if
				byte_code /= Void and then
				not byte_code.is_deferred and then
				not byte_code.is_once
			then
				Result := (type = Void or else not (type.is_true_expanded or else type.is_bit))
					and then (byte_code.rescue_clause = Void)

				if Result then
					types := byte_code.locals
					if types /= Void then
						from
							i := types.count
						until
							i = 0 or else not Result
						loop
							type_i := types.item (i)
							Result := not (type_i.is_true_expanded or else type_i.is_bit)
							i := i - 1
						end
					end
				end

				if Result then
					types := byte_code.arguments
					if types /= Void then
						from
							i := types.count
						until
							i = 0 or else not Result
						loop
							type_i := types.item (i)
							Result := not (type_i.is_true_expanded or else type_i.is_bit)
							i := i - 1
						end
					end
				end

				if Result then
					cid := bindex_cid_table.item (body_index)
					wc := System.class_of_id (cid)
					Result := not (wc.is_basic or else (wc.is_special
							and then byte_code.feature_name_id = Names_heap.make_area_name_id))
				end

				if Result then
					Result := byte_code.size <= min_inlining_threshold
				end
			end
		end

end

