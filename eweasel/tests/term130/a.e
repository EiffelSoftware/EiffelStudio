class A [G -> ANY]

feature
	
	item: G
	
	prune_all (v: like item) is
		local
			res: BOOLEAN
		do
			res := equal (v, item)
		end
		
end

