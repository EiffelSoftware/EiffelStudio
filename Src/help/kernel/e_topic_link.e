indexing
	description: "A hyperlink to a topic on a E_TOPIC_DISPLAY"
	author: "Vincent Brendel"

class
	E_TOPIC_LINK

inherit
	
creation
	make

feature -- Initialization

	make(f, l: INTEGER; id: STRING) is
			-- Initialize
		do
			first := f
			last := l
			topic_id := id
		ensure
			first_set: first = f
			last_set: last = l
			topic_id_set: topic_id = id
		end

	is_in_region(pos: INTEGER): BOOLEAN is
		do
			Result := (pos>=first) and then (pos<=last)
		end

	first, last: INTEGER

	topic_id: STRING

end -- class E_TOPIC_LINK
