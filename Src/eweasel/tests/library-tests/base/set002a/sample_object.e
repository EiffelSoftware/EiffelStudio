class 
	SAMPLE_OBJECT

create

	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Set `item' to `n'.
		do
			item := n
		ensure
			item_set: item = n
		end

feature -- Access

	item: INTEGER

end -- class SAMPLE_OBJECT
