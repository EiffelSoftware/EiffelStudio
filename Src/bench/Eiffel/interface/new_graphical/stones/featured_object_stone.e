indexing
	description: 
		"Stone representating a feature related to an object."
	date: "$Date$"
	revision: "$Revision $"

class
	FEATURED_OBJECT_STONE 

inherit
	FEATURE_STONE
		rename
			make as feature_make
		redefine
			is_valid,
			stone_cursor,
			X_stone_cursor,
			same_as
		end

create
	make
	
feature {NONE} -- Initialization

	make (addr: STRING; a_feature: E_FEATURE) is
		do
			feature_make (a_feature)
			object_address := addr
		end

feature -- Access

	object_address: STRING

	same_as (other: STONE): BOOLEAN is
		local
			conv: like Current
		do
			conv ?= other
			if conv /= Void then
				Result := Precursor {FEATURE_STONE} (conv) 
				if Result then
					if object_address = Void and conv.object_address = Void then
						Result := True
					else
						Result := object_address /= Void 
							and then conv.object_address /= Void
							and then object_address.is_equal (conv.object_address)
					end
				end
			end
		end

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			if object_address /= Void then
				Result := cursors.cur_client_link
			else
				Result := Precursor {FEATURE_STONE}
			end
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			if object_address /= Void then
				Result := cursors.cur_x_client_link
			else
				Result := Precursor {FEATURE_STONE}
			end			
		end

	is_valid: BOOLEAN is
		do
			Result := Precursor {FEATURE_STONE}
		end

end -- class FEATURED_OBJECT_STONE
