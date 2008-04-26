class TEST1

feature -- Operations

	element: TEST3

	view: TEST5
		do
		end

	create_element
			-- Create element
		require
			tag1: view.elements.count > 0
			tag2: view.elements.has (view.elements.item)
			tag3: view.elements.equal (view.elements.item, view.elements.item)
			tag4: [view.elements.count, view.elements.count] /= Void
			tag5: << view.elements.count, view.elements.count >> /= Void
			tag6: (agent equal (view.elements.count, view.elements.count)) /= Void
--			tag7: {a: ANY} view.elements.item
			tag8: view.elements.equal (create {STRING}.make (10), "")
		do
		end

end
