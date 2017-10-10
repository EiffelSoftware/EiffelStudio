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
		note
			option: instance_free
		attribute
		end

	y: detachable TEST
		note
			option: "instance_free"
		attribute
		end

	z
		note
			option: instance_free
		once ("OBJECT")
		end

	w
		note
			option: "instance_free"
		once ("OBJECT")
		end

end