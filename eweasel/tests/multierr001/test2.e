class
	TEST2[G->FILE_NAME,H->TARGET[G]]
inherit
	TEST1[G,H]
		redefine
			foo
		end

feature
	foo : VARIABLE[H]

	bar: VARIABLE [H]

end
