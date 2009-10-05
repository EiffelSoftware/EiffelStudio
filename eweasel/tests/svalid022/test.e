class
	TEST
create make

feature
	make is
		do
		end

feature
	text: $TARGET_MARK A

feature -- Basic Operations

	string_assignment (a_text: $SOURCE_MARK B) is
		do
			text := a_text
		end
end
