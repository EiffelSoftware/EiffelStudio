indexing

	description:
		"Stone for a parent";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_NAME_STONE

	inherit
		STONE
			redefine
				stone_type
			end

		NAMABLE

	creation
		make

	feature
		--creation

		make	( i : STRING_DATA	) is
		do
			data	:= i
			is_valid	:= true
		end

	feature
		--properties from STONE

		data	: STRING_DATA

		is_valid	: BOOLEAN

		--stone_cursor: SCREEN_CURSOR is
				-- Cursor associated with 
				-- Current stone during transport.
		--do
		--	Result := Cursors.index_cursor
		--end;
	

		copy_data	( a_stone : like Current )	is
		do
		end

		destroy_command: DESTROY_VOID is
			-- Command to destroy a class
		do
			!! Result
		end;


		process	( com : EC_COMMAND )	is
		local
		--	namer_window	: NAMER_WINDOW
		do
		--	namer_window	:= windows.namer_window
		--	namer_window.set_up	( false	, false	)
		--	namer_window.set_text	( data.string	)
		--	namer_window.popup_with	( current	)
		end


	feature
		--properties from NAMABLE

	--setup_namer	( namer : NAMER_WINDOW )	is
	--do
	--end

--	set	( namer : NAMER_WINDOW )	is
	--local
	--	class_set	: CLASS_DATA
	--do

--		class_set	:= system.class_of_name	( namer.entered_text	)
--
--		if	class_set	= Void
--		then
--			data.set_string	( namer.entered_text	)
--
--			windows.update_class_windows
--			workareas.update_drawing
--		end
--
	--end

	feature
		-- Redefinitions

		stone_type	: INTEGER	is
		do
			Result	:= Stone_types.parent_type
		end

end -- class STRING_STONE
