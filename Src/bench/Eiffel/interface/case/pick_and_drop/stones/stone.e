indexing

	description: 
		"Object that can be dragged and dropped into a hole.";
	date: "$Date$";
	revision: "$Revision $"

deferred class STONE 

inherit

	ONCES
	CONSTANTS

feature -- Properties

	data: DATA is
			-- Data associated with stone
		deferred
		end;

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		deferred
		end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		deferred
		end

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with 
	--		-- Current stone during transport.
	--	deferred
	--	end;

	destroy_command: DESTROY is
			-- Destroy command to remove Current stone and its
			-- data.
		deferred
		end;

feature -- Management

	free_information is
		do
		end;

	request_for_information is
		do
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		require
			command_exists: com /= Void
		deferred
		end
		
feature -- Removal

	destroy_data is
		local
			l: LINKED_LIST [DESTROY];
			destroy_entities_u: DESTROY_ENTITIES_U;
			dest: like destroy_command
		do
			dest := destroy_command;
			if dest /= Void then
				!! l.make;
				l.put_front (dest);
				!! destroy_entities_u.make (l);
			end;
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		require
			valid_stone: a_stone /= Void;
			--compatible: a_stone.stone_type = stone_type
		deferred
		end

end -- class STONE
