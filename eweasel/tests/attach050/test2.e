
class TEST2
inherit
	ANY
		redefine
			default_create
		end

feature

	default_create
		do
			set_s
		end

	set_s
		once
			s := "Weasel"
		end

	s: STRING

end
