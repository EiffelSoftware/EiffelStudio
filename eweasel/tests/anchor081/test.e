class TEST
create
	make
feature
	make
		local
			t: TEST2 [PROXY_DESCENDANT]
		do
			create t
		end
end
