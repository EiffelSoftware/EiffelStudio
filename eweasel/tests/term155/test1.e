class TEST1

feature -- Operations

	element: TEST3

	view: TEST5
		do
		end

	create_element
			-- Create element
		require
			view.elements.count > 0
		do
		end

end
