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

	inlining_on: BOOLEAN;
			-- In inlining on ?

	processed_features: ARRAY [BOOLEAN];

	to_be_inlined: ARRAY [BOOLEAN];

feature -- Current inlined feature

	set_inlined_feature (bc: INLINED_FEAT_B) is
		do
			inlined_feature := bc
		end

	inlined_feature: INLINED_FEAT_B

feature

	current_feature_inlined: BOOLEAN;

	set_current_feature_inlined is
		do
			current_feature_inlined := True
		end

	reset is
		do
			current_feature_inlined := False
		end

feature

	inline (body_id: BODY_ID): BOOLEAN is
			-- Can we inline `f' ?
		local
			body_id_id: INTEGER
		do
			Result := to_be_inlined.item (body_id.id)
		end

	process (f: FEATURE_I) is
			-- Analyze `f' to see if it can be inlined
		require
			good_argument: f /= Void
		local
			byte_code: BYTE_CODE;
			body_id: BODY_ID;
			body_id_id, size: INTEGER
		do
			if inlining_on then
				body_id := f.body_id;
				body_id_id := body_id.id
				if not processed_features.item (body_id_id) then
					processed_features.put (True, body_id_id)
					if f.can_be_inlined then
						byte_code := Byte_server.item (body_id)
						size := byte_code.size
						if size < min_inlining_threshold then
							to_be_inlined.put (True, body_id_id);
debug ("RECORD")
	io.error.new_line;
	io.error.putstring (f.written_class.name);
	io.error.putstring (" ");
	io.error.putstring (f.feature_name);
	io.error.putstring (" can be inlined%N");
end
						end;
					end
				end
			end
		end

end

