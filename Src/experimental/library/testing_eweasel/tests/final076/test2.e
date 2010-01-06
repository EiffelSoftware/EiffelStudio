
deferred class TEST2
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
		do
			s := hamster
		end

	hamster: STRING
		deferred
		end

	s: STRING

end
