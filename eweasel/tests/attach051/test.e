class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Tests
		local
			attached_local: $CLASS
			detachable_local: detachable $CLASS
		do
			attached_local := detachable_local -- OK, because attached status is checked on use when required.
			attached_attribute := detachable_local -- Error, because attribute can be used somewhere else.
		end

feature {NONE} -- Access

	attached_attribute: $CLASS

end
