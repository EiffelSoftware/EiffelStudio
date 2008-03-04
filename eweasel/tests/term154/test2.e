class TEST2 [G]

feature -- Access

	list_creator (a_lower, a_upper: INTEGER): ARRAYED_LIST [G] is
		do
			create Result.make (10)
		ensure
			result_not_void: Result /= Void
		end

end
