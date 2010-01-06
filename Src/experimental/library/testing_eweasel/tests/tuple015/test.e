class TEST

create
	default_create, make

feature

	make is
		local
			l_det_s: TUPLE [STRING]
			l_att_s: TUPLE [!STRING]
		do
			create l_det_s
			create l_att_s

			if not l_det_s.valid_type_for_index (Void, 1) then
				io.put_string ("Not OK%N")
			end
			if l_det_s.valid_type_for_index (create {TEST}, 1) then
				io.put_string ("Not OK%N")
			end
			if not l_det_s.valid_type_for_index ("STRING", 1) then
				io.put_string ("Not OK%N")
			end
			if l_att_s.valid_type_for_index (Void, 1) then
				io.put_string ("Not OK%N")
			end
			if l_att_s.valid_type_for_index (create {TEST}, 1) then
				io.put_string ("Not OK%N")
			end
			if not l_att_s.valid_type_for_index ("STRING", 1) then
				io.put_string ("Not OK%N")
			end
		end

end
