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

	COMPILER_EXPORTER

creation
	
	make

feature {NONE} -- Initialization

	make (s: STRING; id: CLASS_ID) is
			-- Set id to `s' and set
			-- class_id to `id'.
		require
			valid_s: s = Void implies id.id > 0; 
			valid_id: id.id = 0 implies s /= void; 
		do
			if s /= Void then
				free_text_name := clone (s);
				free_text_name.to_upper;
			end;
			class_id := id.id
			complete_class_id := id
		ensure
			class_id_set: class_id = id.id;
		end;

feature -- Properties

	class_id: INTEGER;
			-- Class id for Current class type

	complete_class_id: CLASS_ID

	real_class_ids: LINKED_LIST [CLASS_ID] is
			-- List container Current class_id if positive
		do
			!! Result.make;
			if complete_class_id.dummy_id /= 0 then
				Result.put_front (complete_class_id)
			end;
		ensure then
			has_current: class_id /= 0 implies 
							(Result.has (complete_class_id) and then
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
