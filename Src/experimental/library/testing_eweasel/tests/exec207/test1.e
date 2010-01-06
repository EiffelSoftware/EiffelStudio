
class TEST1
feature

	formatter: TEST1 is
		do
			Result := Current
		end
		
	composed_path_1 (a_r: ARRAY [STRING]): STRING is
			-- 
		do
			if a_r /= Void and a_r.valid_index (1) then
				Result := a_r.item (1)
			end
		end

	composed_path_2 (a_r: TUPLE [STRING]): STRING is
			-- 
		do
			if a_r /= Void and a_r.valid_index (1) then
				Result ?= a_r.item (1)
			end
		end
		
end
