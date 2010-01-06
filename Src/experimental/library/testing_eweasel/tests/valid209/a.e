deferred class
	A

feature -- Cration
	make
		do
		end

feature -- Testing

	generic: GENERIC [like Current]

	foo
		do
			create generic
		end
end
