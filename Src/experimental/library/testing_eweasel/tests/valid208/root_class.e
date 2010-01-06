class
        ROOT_CLASS
create
	make
feature -- Init
	make is
		do
			create b.make
		end
	a: A
	b: B
end
