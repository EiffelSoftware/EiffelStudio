-- Entry for special routine: invariant, dispose, initialization

class SPECIAL_ENTRY 

inherit
	SHARED_BODY_ID;

	ROUT_ENTRY
		redefine
			body_id, routine_name, used
		end

feature -- Kind

	body_id: BODY_ID
			-- Kind of special routine

	set_body_id (bid: BODY_ID) is
			-- Set `body_id' to `bid'.
		do
			body_id := bid
		end

feature

	routine_name: STRING is
			-- Internal name
		do
			Result := body_id.feature_name (System.class_type_of_id (written_type_id).id)
		end;

	used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
		do
			remover := System.remover;
			Result :=	remover = Void			-- Workbench mode
						or else System.remover_off		-- Dead code removal disconnected
						or else equal (body_id, Initialization_body_id)
						or else remover.is_body_alive (body_id)	-- Final mode
		end;

end
