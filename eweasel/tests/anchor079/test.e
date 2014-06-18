class TEST 

create
	make

feature

	make
		local
			t: TEST1 [PROXY_PROXIABLE_DATA_IDENTIFIED, BASE_OBJECT_VIEW [ANY, PROXY_PROXIABLE_DATA_IDENTIFIED]]
		do
			create t
		end

end
