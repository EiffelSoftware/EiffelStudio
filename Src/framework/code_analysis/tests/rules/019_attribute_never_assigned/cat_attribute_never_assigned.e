class
	CAT_ATTRIBUTE_NEVER_ASSIGNED

feature -- Test

	variable_not_read (a: INTEGER)
		local
			l: INTEGER
		do
			l := a
		end

	attrib: INTEGER

end
