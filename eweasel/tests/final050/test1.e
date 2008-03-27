class TEST1

feature -- Operations

	element: TEST3

	view: TEST5
		do
		end

	create_element
			-- Create element
		do
			view.elements.extend (element)
		end

end
