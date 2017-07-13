class TEST

create
	make

feature

	make
		do
			;({ARRAY [INTEGER_8]} <<>>).do_nothing
			;({ARRAY [INTEGER_8]} <<1>>).do_nothing
			;({ARRAY [INTEGER_8]} <<1, 2>>).do_nothing
			;({ARRAY [INTEGER_8]} <<1, 256>>).do_nothing -- Error

			;({ARRAY [COMPARABLE]} <<>>).do_nothing
			;({ARRAY [COMPARABLE]} <<1>>).do_nothing
			;({ARRAY [COMPARABLE]} <<1, 2>>).do_nothing
			;({ARRAY [COMPARABLE]} <<1, "">>).do_nothing
			;({ARRAY [COMPARABLE]} <<1, Current>>).do_nothing -- Error
			;({ARRAY [COMPARABLE]} <<1, create {separate STRING}.make_empty>>).do_nothing -- Error in SCOOP
			;({ARRAY [COMPARABLE]} <<1, Void>>).do_nothing -- Error

			;({ARRAY [detachable COMPARABLE]} <<>>).do_nothing
			;({ARRAY [detachable COMPARABLE]} <<1>>).do_nothing
			;({ARRAY [detachable COMPARABLE]} <<1, 2>>).do_nothing
			;({ARRAY [detachable COMPARABLE]} <<1, "">>).do_nothing
			;({ARRAY [detachable COMPARABLE]} <<1, Current>>).do_nothing -- Error
			;({ARRAY [detachable COMPARABLE]} <<1, create {separate STRING}.make_empty>>).do_nothing -- Error in SCOOP
			;({ARRAY [detachable COMPARABLE]} <<1, Void>>).do_nothing

			;({ARRAY [separate COMPARABLE]} <<>>).do_nothing
			;({ARRAY [separate COMPARABLE]} <<1>>).do_nothing
			;({ARRAY [separate COMPARABLE]} <<1, 2>>).do_nothing
			;({ARRAY [separate COMPARABLE]} <<1, "">>).do_nothing
			;({ARRAY [separate COMPARABLE]} <<1, Current>>).do_nothing -- Error
			;({ARRAY [separate COMPARABLE]} <<1, create {separate STRING}.make_empty>>).do_nothing
			;({ARRAY [separate COMPARABLE]} <<1, Void>>).do_nothing -- Error

			;({ARRAY [detachable separate COMPARABLE]} <<>>).do_nothing
			;({ARRAY [detachable separate COMPARABLE]} <<1>>).do_nothing
			;({ARRAY [detachable separate COMPARABLE]} <<1, 2>>).do_nothing
			;({ARRAY [detachable separate COMPARABLE]} <<1, "">>).do_nothing
			;({ARRAY [detachable separate COMPARABLE]} <<1, Current>>).do_nothing -- Error
			;({ARRAY [detachable separate COMPARABLE]} <<1, create {separate STRING}.make_empty>>).do_nothing
			;({ARRAY [detachable separate COMPARABLE]} <<1, Void>>).do_nothing
		end

end
