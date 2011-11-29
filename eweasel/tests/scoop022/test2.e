
expanded class TEST2
inherit
	ANY
		redefine
			default_create
		end

feature

	default_create
		do
			s := "Weasel"
		end

	s: $(SEPARATE) STRING


end
