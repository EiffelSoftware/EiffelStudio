class INLINER

inherit
	SHARED_SERVER;
	COMPILER_EXPORTER

creation
	make

feature

	make is
		local
			nb: INTEGER
		do
			inlining_on := System.inlining_on

			nb := System.body_id_counter.total_count
			!! processed_features.make (1, nb)
			!! to_be_inlined.make (1, nb)

			min_inlining_threshold := System.inlining_size
		end

feature {NONE}

	min_inlining_threshold: INTEGER
			-- Byte code smaller than `min_inlining_threshold' will be inlined
			-- even if they are called several times


	processed_features: ARRAY [BOOLEAN];

	to_be_inlined: ARRAY [BOOLEAN];

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

	bid_cid_table: EXTEND_TABLE [CLASS_ID, BODY_ID] is
		once
			Result := Depend_server.bid_cid_table
		end

feature -- Status

	inline (type: TYPE_I; body_id: BODY_ID): BOOLEAN is
			-- Can we inline `f' ?
		require
			is_inlining_enabled: inlining_on
		local
			body_id_id: INTEGER
		do
			body_id_id := body_id.id
			if not processed_features.item (body_id_id) then
				processed_features.put (True, body_id_id)
				if can_be_inlined (type, body_id) then
					to_be_inlined.put (True, body_id_id)
					Result := True
				end
			else
				Result := to_be_inlined.item (body_id_id)
			end
		end

	can_be_inlined (type: TYPE_I; body_id: BODY_ID): BOOLEAN is
			-- Tell us if we can inline the code corresponding to `body_id'
		local
			byte_code: BYTE_CODE;
			body_id_id, size, i: INTEGER
			type_i: TYPE_I	
			types: ARRAY [TYPE_I]
			wc: CLASS_C
		do
 			if byte_server.server_has (body_id) then
 				byte_code := Byte_server.disk_item (body_id)
 			end

			if byte_code /= Void then
				Result := (type = Void or else not (type.is_expanded or else type.is_bit))
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
							Result := not (type_i.is_expanded or else type_i.is_bit)
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
							Result := not (type_i.is_expanded or else type_i.is_bit)
							i := i - 1
						end
					end
				end

				if Result then
					wc := System.class_of_id (bid_cid_table.item (body_id))
					Result := not (wc.is_basic or else (wc.is_special
							and then byte_code.feature_name.is_equal ("make_area")))
				end

				if Result then
					Result := byte_code.size < min_inlining_threshold
				end
			end
		end

end

