class S_GENERIC_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature {NONE}

    make (s: STRING; t: like constraint_type) is
            -- Set name to `s' and set
            -- type to `t'.
		require
			valid_s: s /= Void
        do
            name := s;
            constraint_type := t
        ensure
            name_set: name = s;
            type_set: constraint_type = t
        end;

feature

	constraint_type: S_TYPE_INFO

	name: STRING

end


