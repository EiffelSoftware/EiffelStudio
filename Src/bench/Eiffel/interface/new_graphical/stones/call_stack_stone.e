indexing
	description: 
		"Stone representating a breakable point."
	date: "$Date$"
	revision: "$Revision $"

class
	CALL_STACK_STONE 

inherit
	FEATURE_STONE
		rename
			make as feature_make,
			is_valid as fvalid
		redefine
			stone_cursor,
			X_stone_cursor,
			synchronized_stone,
			same_as
		select
			class_stone_make
		end

	OBJECT_STONE
		rename
			make as obj_make
		undefine
			file_name,
			header,
			stone_signature,
			origin_text,
			history_name
		redefine
			stone_cursor,
			X_stone_cursor,
			synchronized_stone,
			is_valid,
			same_as
		select
			is_valid
		end

	SHARED_APPLICATION_EXECUTION

create
	make
	
feature {NONE} -- Initialization

	make (level_num: INTEGER) is
			-- Initialize `level_number' to `level_num'.
		require
			level_num: level_num > 0
		local
			elem: EIFFEL_CALL_STACK_ELEMENT
			prev_feat: E_FEATURE
			cur_feat: E_FEATURE
			l_dynclass: CLASS_C
			curr_cs: EIFFEL_CALL_STACK
		do
			level_number := level_num
			curr_cs := Application.status.current_call_stack
			if curr_cs /= Void then
				elem ?= curr_cs.i_th (level_num)
				if elem /= Void then
					l_dynclass := elem.dynamic_class
					
					obj_make (elem.object_address, " ", l_dynclass)
						--| We try to give the feature relative to the dynamic class.
						--| However, in case of a Precursor, we fall back to the feature in its static context.
					prev_feat := elem.routine
					check
						prev_feat_not_void: prev_feat /= Void
					end
					if l_dynclass /= Void and then l_dynclass.has_feature_table then
						cur_feat := l_dynclass.feature_with_body_index (prev_feat.body_index)
					end
					if cur_feat = Void then
							-- We are in a Precursor.
						cur_feat := prev_feat
					end
					feature_make (cur_feat)
				end
			end
		end
 
feature -- Access

	same_as (other: STONE): BOOLEAN is
		local
			conv: CALL_STACK_STONE
		do
			conv ?= other
			if conv /= Void then
				Result := Precursor {OBJECT_STONE} (other) and then
						Precursor {FEATURE_STONE} (other)
			end
		end

	level_number: INTEGER
			-- Level number of call stack

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_setstop
		end

	synchronized_stone: CLASSI_STONE is
		do
			if is_valid then
				Result := twin
			else
				Result := Precursor {FEATURE_STONE}
			end
		end

	is_valid: BOOLEAN is
		do
			Result := fvalid and then Precursor {OBJECT_STONE} and then
					Application.status.current_call_stack.count >= level_number
		end

end -- class BREAKABLE_STONE
