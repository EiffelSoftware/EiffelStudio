

class TEST4
inherit
	ANY

feature 

	elements: LIST [like anchored_view_element]

	anchored_view_element: TEST2
		do
		ensure
			result_void: Result = Void
		end

end
