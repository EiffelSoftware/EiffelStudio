indexing

	description:
		"Stone for a creation feature";
	date: "$Date$";
	revision: "$Revision$"

class CREATION_STONE

	inherit
		STONE

		NAMABLE

	creation
		make

	feature
		--creation

		make	( i : CREATION_DATA	) is
		do
			data	:= i
			is_valid	:= true
		end

	feature
		--properties from STONE

		data	: CREATION_DATA

		is_valid	: BOOLEAN

		--stone_cursor: SCREEN_CURSOR is
				-- Cursor associated with 
				-- Current stone during transport.
		--do
		--	Result := Cursors.index_cursor
		--end;
	
	stone_type_pnd: EV_PND_TYPE is
			-- Current stone type of selected stone
		do
			Result := stone_types.creation_type_pnd
		end;
	
	
		copy_data	( a_stone : like Current )	is
		do
		end


		destroy_command: DESTROY_CREATION	is
			-- Command to destroy a class
		do
			if	data /= Void 
			then
				!! Result.make (data);
			end
		end;


		process	( com : EC_COMMAND )	is
		local
		--	namer_window	: NAMER_WINDOW
		do
		--	namer_window	:= windows.namer_window
		--	namer_window.set_up	( false	, false	)
		--	namer_window.popup_with	( current	)
		end


	feature
		--properties from NAMABLE

--	setup_namer	( namer : NAMER_WINDOW )	is
	--do
--	end

	--set	( namer : NAMER_WINDOW )	is
--	do
	--	data.set_name	( deep_clone	( namer.entered_text	) )
--
	--	Windows.update_class_windows
	--	workareas.update_drawing
	--end

end -- class CREATION_STONE
