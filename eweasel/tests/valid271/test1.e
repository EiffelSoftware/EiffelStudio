class TEST1 [G]
create
	make
feature
	make
		do
			if {G} ~ {STRING} then
				print ("STRING%N")
			elseif {G} ~ {RAW_FILE} then
				print ("RAW_FILE%N")
			end
		end

end
