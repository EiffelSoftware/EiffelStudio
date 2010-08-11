class TEST

create
	make, default_create
feature

	make
		do
			(create {TEST1 [INTEGER, TYPED_PREFERENCE [INTEGER]]}).do_something
		end

end
