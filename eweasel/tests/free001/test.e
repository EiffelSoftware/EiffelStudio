class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
		end

feature {NONE} -- Tests

	x: detachable TEST
		attribute
		ensure
			is_class: class
		end

	y: detachable TEST
		attribute
		ensure
			is_class: class
		end

	z
		once ("OBJECT")
		ensure
			is_class: class
		end

	w
		once ("OBJECT")
		ensure
			is_class: class
		end

end