class TEST
create
	make

feature
	make
		local
			b: B
		do
			create b
			b.f
		end

	e: detachable E
		-- Just to ensure E is in the system

end
