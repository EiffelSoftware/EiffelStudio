indexing

	description:
		"Stone for a parent";
	date: "$Date$";
	revision: "$Revision$"

class GENERIC_STONE

	inherit
		EC_STONE

		NAMABLE

	creation
		make

	feature
		--creation

		make	( i : INSTANCE_GENERIC_DATA	) is
		do
			data	:= i
			is_valid	:= true
		end

	feature
		--properties from STONE

		data	: INSTANCE_GENERIC_DATA

		is_valid	: BOOLEAN

		--stone_cursor: SCREEN_CURSOR is
		--		-- Cursor associated with 
		--		-- Current stone during transport.
		--do
		--	Result := Cursors.generic_cursor
		--end;
	
	stone_type_pnd: EV_PND_TYPE is 
		do
			Result := stone_types.generic_type_pnd
		end


		copy_data	( a_stone : like Current )	is
		do
		end


		destroy_command: DESTROY_VOID is
			-- Command to destroy a class
		local
			class_data	: CLASS_DATA
		do
			!! Result
		end;


		process	( com : EC_COMMAND )	is
		local
	--		namer_window	: NAMER_WINDOW
		do
	--		namer_window	:= windows.namer_window
	--		namer_window.set_up	( false	, false	)
	--		namer_window.popup_with	( current	)
		end


	feature
		--properties from NAMABLE

	--setup_namer	( namer : NAMER_WINDOW )	is
	--do
	--end

	--set	( namer : NAMER_WINDOW )	is
	--local
	--	class_set	: CLASS_DATA
	--	relation_data	: RELATION_DATA
	--	generic_data	: GENERIC_DATA
	--do
--		relation_data	:= data.relation_data
--
--		if	not relation_data.has_generic	( namer.entered_text	)
--		then
--			generic_data	:= data.generic_data
--			generic_data.set_name	( namer.entered_text	)
--
--			windows.update_class_windows
--			workareas.update_drawing
--		end
	--end

	feature
		-- Redefinitions

		stone_type	: INTEGER	is
		do
			Result	:= Stone_types.generic_type
		end

end -- class PARENT_STONE
