-- Entry for special routine: invariant, dispose, initialization

class SPECIAL_ENTRY 

inherit

	SHARED_BODY_ID;
	ROUT_ENTRY
		rename
			body_index as kind,
			set_body_index as set_kind
		redefine
			routine_name, used
		end

feature

	routine_name: STRING is
			-- Internal name
		do
			Result := Encoder.feature_name
				(System.class_type_of_id (written_type_id).id, kind)
		end;

		used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
		do
			remover := System.remover;
			Result :=	remover = Void			-- Workbench mode
						or else
						System.remover_off		-- Dead code removal disconnected
						or else
						kind = Initialization_id
						or else
						remover.is_body_alive (kind)	-- Final mode
		end;

end

