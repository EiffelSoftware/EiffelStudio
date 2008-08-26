class
	TEST

create
	make,
	default_create

feature

	make is
		do
			(create {TEST}).item := 4
		end

	item: INTEGER assign set_item

	set_item (new_item: INTEGER) is
		do
			item := new_item
		end

end
