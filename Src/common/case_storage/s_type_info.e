class S_TYPE_INFO

creation
	
	make

feature {NONE}

	make (s: STRING; id: like class_id) is
			-- Set id to `s' and set
			-- class_id to `id'.
		require
			valid_s: s = Void implies id > 0; 
			valid_id: id = 0 implies s /= void; 
		do
			name := s;
			class_id := id
		ensure
			name_set: name = s;
			class_id_set: class_id = id;
		end;

feature

	class_id: INTEGER;

	name: STRING;

    is_valid: BOOLEAN is
            -- Is Current valid?
        do
            if name = Void then
                Result := class_id > 0
            else
                Result := class_id = 0
            end
        end

invariant

	is_valid: is_valid

end
