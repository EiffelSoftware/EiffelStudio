indexing

	description: "Explicit class type information.";
	date: "$Date$";
	revision: "$Revision $"

class S_CLASS_TYPE_INFO

inherit

	S_TYPE_INFO
		redefine
			real_class_ids
		end

creation
	
	make

feature {NONE} -- Initialization

	make (s: STRING; id: like class_id) is
			-- Set id to `s' and set
			-- class_id to `id'.
		require
			valid_s: s = Void implies id > 0; 
			valid_id: id = 0 implies s /= void; 
		do
			if s /= Void then
				free_text_name := clone (s);
				free_text_name.to_upper;
			end;
			class_id := id
		ensure
			class_id_set: class_id = id;
		end;

feature -- Properties

	class_id: INTEGER;
			-- Class id for Current class type

	real_class_ids: LINKED_LIST [INTEGER] is
			-- List container Current class_id if positive
		do
			!! Result.make;
			if class_id /= 0 then
				Result.put_front (class_id)
			end;
		ensure then
			has_current: class_id /= 0 implies 
							(Result.has (class_id) and then
							Result.count = 1);
		end;

	is_valid: BOOLEAN is
			-- Is Current valid?
		do
			if free_text_name = Void then
				Result := class_id > 0
			else
				Result := True
			end
		ensure then
			ok: Result implies (free_text_name /= Void or else
						(class_id > 0))
		end;

feature -- Output

	string_value: STRING is
		do
			Result := clone (free_text_name)
		ensure then
			output: equal (Result, free_text_name)
		end;

invariant

	is_valid: is_valid

end -- class S_CLASS_TYPE_INFO
