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
		require
			positive: f>= 0 
			consistent: f <=l
			not_void: id /= Void
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
		require
			positive: pos >=0
		do
			Result := (pos>first) and then (pos<=last+1)
		end

	first, last: INTEGER

	topic_id: STRING

invariant
	E_TOPIC_LINK_consistent: first <= last and first >= 0
	E_TOPIC_LINK_exists: topic_id /= Void
end -- class E_TOPIC_LINK
