indexing

	description: "Command for the trash hole: removes data objects.";
	date: "$Date$";
	revision: "$Revision $"

class TRASH_HOLE_COM2

inherit
	--EC_LICENCED_COMMAND
	--	redefine 
	--		process_any	, 
--			stone_type	,
	--		compatible
	--	end

	EV_COMMAND

	CONSTANTS

	ONCES

feature {BUTTON_HOLE} -- Properties 

	stone_type: INTEGER is
			-- Stone type of hole associated to Current command
		once
			Result := Stone_types.any_type
		end

	symbol: EV_PIXMAP is
			-- Symbol representing button associated to Current command
		once
			--Result := Pixmaps.trash_pixmap
		end

	compatible	( dropped : STONE )	: BOOLEAN	is
	do
-- 		Result	:= dropped.stone_type	= Stone_types.argument_type	or
-- 			   dropped.stone_type	= Stone_types.command_type	or
-- 			   dropped.stone_type	= Stone_types.comment_type	or
-- 			   dropped.stone_type	= Stone_types.constraint_type	or
-- 			   dropped.stone_type	= Stone_types.description_type	or
-- 			   dropped.stone_type	= Stone_types.feature_type	or
-- 			   dropped.stone_type	= Stone_types.feature_clause_type	or
-- 			   dropped.stone_type	= Stone_types.generic_type	or
-- 			   dropped.stone_type	= Stone_types.index_type	or
-- 			   dropped.stone_type	= Stone_types.invariant_type	or
-- 			   dropped.stone_type	= Stone_types.precondition_type	or
-- 			   dropped.stone_type	= Stone_types.postcondition_type	or
-- 			   dropped.stone_type	= Stone_types.query_type	or
-- 			   dropped.stone_type	= Stone_types.relation_type	or
-- 			   dropped.stone_type	= Stone_types.rename_type	or
-- 			   dropped.stone_type	= Stone_types.result_type	or
-- 			   dropped.stone_type	= Stone_types.specification_type	or
-- 			   dropped.stone_type	= Stone_types.type_of_object_type	or
-- 			   dropped.stone_type	= Stone_types.version_type	or
-- 			   dropped.stone_type	= Stone_types.parent_type	or
-- 			   dropped.stone_type	= Stone_types.heir_type	or
-- 			   dropped.stone_type	= Stone_types.creation_type	or
-- 			   dropped.stone_type	= Stone_types.client_type	or
-- 			   dropped.stone_type	= Stone_types.supplier_type	or
-- 			   dropped.stone_type	= Stone_types.string_type	or
-- 			   dropped.stone_type	= Stone_types.void_type	
					  
	end


feature {BUTTON_HOLE} -- Update

	process_any (s: STONE) is
			-- Process stone dropped in Current command associated hole:
			-- Destroy dropped stone `s'.
		do
			if	compatible	( s	)
			then
				s.destroy_data
			end
		end

feature {NONE} -- Inapplicable

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Callback for associated button:
			--| Not a clickable button.
		do
		end

end -- class TRASH_HOLE_COM
