class TEST

create
	make

feature

	 make
		do
			(create {A [B [STRING]]}.make).do_nothing;
			(create {A [C [STRING]]}.make).do_nothing
		end

end
