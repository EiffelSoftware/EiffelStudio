-- Entry for special routine: invariant, dispose, initialization

class SPECIAL_ENTRY 

inherit
	SHARED_BODY_ID;

	ROUT_ENTRY
		redefine
			routine_name, used
		end

feature

	routine_name: STRING is
			-- Internal name
		do
			Result := Encoder.feature_name (System.class_type_of_id (written_type_id).static_type_id, body_index)
		end;

	used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
		do
			remover := System.remover;
			Result :=	remover = Void			-- Workbench mode
						or else System.remover_off		-- Dead code removal disconnected
						or else body_index = Initialization_body_index
						or else remover.is_alive (body_index)	-- Final mode
		end;

end
