class S_TYPE_INFO

creation
	
	make

feature {NONE}

	make (s: STRING; id: like class_id) is
			-- Set id to `s' and set
			-- class_id to `id'.
		require
			both_not_void: s = Void implies id > 0 and then
						id = 0 implies s /= Void
		do
			name := s;
			class_id := id
		ensure
			name_set: name = s;
			class_id_set: class_id = id;
		end;

feature

	class_id: INTEGER;

	name: STRING

end
