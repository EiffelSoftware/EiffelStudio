-- Entry for special routine: invariant, dispose, initialization

class SPECIAL_ENTRY 

inherit

	ROUT_ENTRY
		rename
			body_index as kind,
			set_body_index as set_kind
		redefine
			routine_name
		end

feature

	routine_name: STRING is
			-- Internal name
		do
			Result := Encoder.feature_name
				(System.class_type_of_id (written_type_id).id, kind)
		end;

end
	
