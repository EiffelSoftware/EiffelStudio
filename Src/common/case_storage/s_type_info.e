class S_TYPE_INFO

creation
	
	make

feature {NONE}

	make (s: STRING; key: like class_key) is
			-- Set id to `s' and set
			-- class_key to `key'.
		require
			both_not_void: s = Void implies key /= Void and then
						key = Void implies s /= Void
		do
			name := s;
			class_key := key
		ensure
			name_set: name = s;
			class_key_set: class_key = key;
		end;

feature

	class_key: S_CLASS_KEY;

	name: STRING

end
