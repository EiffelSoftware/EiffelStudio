class TEST

create
	default_create, make

feature

	make is
		local
			l_det_s: TUPLE [detachable STRING]
			l_att_s: TUPLE [attached STRING]
			sd: detachable STRING
			sa: attached STRING
		do
			sa := ""
			l_det_s := [sd]
			l_att_s := [sa]

			if not l_det_s.valid_type_for_index (Void, 1) then
				io.put_string ("Not OK 1%N")
			end
			if l_det_s.valid_type_for_index (create {TEST}, 1) then
				io.put_string ("Not OK 2%N")
			end
			if not l_det_s.valid_type_for_index ("STRING", 1) then
				io.put_string ("Not OK 3%N")
			end
			if l_att_s.valid_type_for_index (Void, 1) then
				io.put_string ("Not OK 4%N")
			end
			if l_att_s.valid_type_for_index (create {TEST}, 1) then
				io.put_string ("Not OK 5%N")
			end
			if not l_att_s.valid_type_for_index ("STRING", 1) then
				io.put_string ("Not OK 6%N")
			end
		end

end
