expanded class A

create
	default_create,
	make

feature {NONE} -- Creation

	make (value: TEST)
			-- Set `item` to `value`.
		do
			item := value
		end

feature -- Access

	item: detachable TEST
			-- Current value (if any).

end
