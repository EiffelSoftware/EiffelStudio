indexing

	description: 
		"Basic class type that does not have explicit %
		%declaration of class types. Basic class type %
		%are `like features', `formal' type and %
		%`like current' type";
	date: "$$";
	revision: "$Revision$"

class S_BASIC_TYPE_INFO

inherit

	S_TYPE_INFO
		redefine
			is_not_actual_class_type
		end

creation

	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Set free_text_nam to 'a_name'.
		require
			valid_name: a_name /= Void
		do
			free_text_name := a_name;
		ensure
			free_text_name_set: free_text_name = a_name
		end;

feature -- Access

	is_not_actual_class_type: BOOLEAN is True
			-- Is Current a basic formal or like feature or
			-- like argument or like_current type?

	is_valid: BOOLEAN is
			-- Is Current valid?
		do	
			Result := free_text_name /= Void
		ensure then
			is_valid_implies: Result implies free_text_name /= Void
		end;

feature -- Output

	string_value: STRING is
		do
			Result := clone (free_text_name)
		ensure then
			Output: equal (Result, free_text_name)
		end;

invariant

	valid_free_text_name: free_text_name /= Void

end -- class S_BASIC_TYPE_INFO
