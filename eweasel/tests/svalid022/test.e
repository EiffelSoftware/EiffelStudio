class
	TEST
create make

feature
	make is
		do
			string_assignment (Void)
		end

feature
	text: detachable STRING_32

feature -- Basic Operations
	string_assignment (a_text: detachable STRING_GENERAL) is
		do
			text := a_text
		end
end
