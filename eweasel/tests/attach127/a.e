expanded class A

create
	default_create,
	make

feature {NONE} -- Creation

	make (value: TEST)
			-- Make a qualified call on `value`.
		do
			item := value
		end

feature -- Access

	item: detachable TEST
			-- Current value (if any).

end
