class
	TEST3

feature

	store: detachable TEST2 [ANY, ANY]

	g
		local
			l_store: like store.default_template
		do
			create l_store
		end

end
