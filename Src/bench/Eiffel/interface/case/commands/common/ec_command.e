indexing

	description: 
		"Abstract notion of an EiffelCase command that can be executed. %
		%May be associated to a button, a hole, a menu entry, ...";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	EC_COMMAND

inherit

	EV_COMMAND
		rename
			execute as work
		end;

	CONSTANTS -- for `Stone_types'

	ONCES

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current command.
		deferred
		end;

	work (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			--Windows.popdown_error_window;
			execute (args, data)
		end

feature {HOLE} -- Properties

	stone_type: INTEGER is
			-- Stone type of hole associated to Current 
			-- command (if any).
			--| Put here to avoid the need for specific heirs
			--| of HOLE which would (re)define that `stone_type'
		do
			--| To be redefined in appropriate heirs
			check
				not_called: False
			end
		end

feature {HOLE} -- Access

	compatible (dropped: STONE): BOOLEAN is 
			-- Is dropped stone compatible with the hole associated
			-- to Current command?
			--| Put here to avoid the need for specific heirs
			--| of HOLE which would (re)define that `compatible'
		do 
			--Result := (stone_type = Stone_types.any_type) 
			--		or else (dropped.stone_type = stone_type)
		end

feature -- Stone processing

		-- The following routines come from HOLE...
		-- Each descendant is supposed to redefine the routine(s) it needs
		-- to do its specific processing. They are called by routine 
		-- `receive' of class HOLE. Other routines should never be called.
		--| Allows passing the correct stone type, which avoids having to
		--| do assignment attempts when a hole may accept several stones,
		--| and which avoid doing the work done by `compatible' twice.

	process_any (dropped: STONE) is
			-- Accept all stone types being dropped into the associated hole
		require
			valid_stone: dropped /= Void
		do
				--| check suppressed if routine is redefined:
			check 
				not_called: False
			end
		end

	process_class (class_stone: CLASS_STONE) is
			-- Process class stone dropped into the associated hole.
		require
			valid_stone: class_stone /= Void
		do
				--| check suppressed if routine is redefined:
			check
				not_called: False
			end
		end

	process_cluster (cluster_stone: CLUSTER_STONE) is
			-- Process cluster stone dropped into the associated hole.
		require
			valid_stone: cluster_stone /= Void
		do
				--| check suppressed if routine is redefined:
			check
				not_called: False
			end
		end

	process_color (color_stone: COLOR_STONE) is
			-- Process color stone dropped into the associated hole.
		require
			valid_stone: color_stone /= Void
		do
				--| check suppressed if routine is redefined:
			check
				not_called: False
			end
		end

	process_element (element_stone: ELEMENT_STONE) is
			-- Process element stone (prec, pos, inv) dropped 
			-- into the associated hole.
		require
			valid_stone: element_stone /= Void
		do
				--| check suppressed if routine is redefined:
			check
				not_called: False
			end
		end

	process_feature (feature_stone: FEATURE_STONE) is
			-- Process feature stone dropped into the associated hole.
		require
			valid_stone: feature_stone /= Void
		do
				--| check suppressed if routine is redefined:
			--check
			--	not_called: False
			--end -- pascalf2701
		end

	process_group ( group_stone : GROUP_STONE) is
			-- Process feature stone dropped into the associated hole.
		require
			valid_stone: group_stone /= Void
		do
				--| check suppressed if routine is redefined:
			--check
			--	not_called: False
			--end -- pascalf2701
		end

	process_new_class is
			-- Process new class stone dropped into the associated hole
		do
				--| check suppressed if routine is redefined:
			check
				not_called: False
			end
		end
		
	process_new_cluster is
			-- Process new cluster stone dropped into the associated hole.
		do
				--| check suppressed if routine is redefined:
			check
				not_called: False
			end
		end

	process_relation (relation_stone: RELATION_STONE) is
			-- Process relation stone dropped into the associated hole.
		require
			valid_stone: relation_stone /= Void
		do
				--| check suppressed if routine is redefined:
			check
				not_called: False
			end
		end

	process_add_class is
		do
		end

	process_add_color is
		do
		end

feature -- Drag and drop properties

	stone: STONE is
			-- Stone to be dragged and dropped from
			-- associated drag source
			--| Put here to avoid the need for specific heirs
			--| of DRAG_SOURCE which would (re)define that `stone'      
		do
			--| To be redefined in appropriate heirs
		end

end -- class EC_COMMAND
