expanded class A

feature -- Access

	item: INTEGER
			-- Value.

feature -- Modification

	put (value: like item)
			-- Set `item` to `value`.
		do
			item := value
		ensure
			item_set: item = value
		end

end
