indexing

	description:
		"Stone for a parent";
	date: "$Date$";
	revision: "$Revision$"

class CLIENT_STONE

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

		make	( i : CLI_SUP_DATA	) is
		do
			data	:= i
			is_valid	:= true
		end

	feature
		--properties from STONE

		data	: CLI_SUP_DATA

		is_valid	: BOOLEAN

		stone_cursor: SCREEN_CURSOR is
				-- Cursor associated with 
				-- Current stone during transport.
		do
			Result := Cursors.client_cursor
		end;
	

		copy_data	( a_stone : like Current )	is
		do
		end


		destroy_command: DESTROY	is
			-- Command to destroy a class
		do
			if	data /= Void 
			then
				if data.is_aggregation then
					!DESTROY_AGGREGATION! Result.make	( data	)
				else
					!DESTROY_REFERENCE! Result.make	( data	)
				end
			end
		end;


		process	( com : EC_COMMAND )	is
		local
			namer_window	: NAMER_WINDOW
		do
			namer_window	:= windows.namer_window
			namer_window.popup_with	( current	)
		end


	feature
		--properties from NAMABLE

	setup_namer	( namer : NAMER_WINDOW )	is
	do
	end

	set	( namer : NAMER_WINDOW )	is
	local
		class_set	: CLASS_DATA
		client	: LINKABLE_DATA
		supplier	: LINKABLE_DATA
	do
		supplier	:= data.supplier
		if	supplier	/= Void
		then
			if	supplier.new_client_name	( namer.entered_text	)
			then
				class_set	:= system.class_of_name	( namer.entered_text	)
	
				-- Destruction of the Old Link
				client	:= data.client
				if	client	/= void
				then
					client.delete_client_link	( data	)
				end
	
				-- Update the Link
				data.set_client	( class_set	)
				client	:= data.client

				-- Adding of the New Link
				-- Attention : the parent has been updated
				if	client	/= void
				then
					client.add_client_link	( data	)
				end
	
				if	class_set	= void
				then
					data.set_f_rom_name	( deep_clone	( namer.entered_text	) )
				end

				windows.update_class_windows
				workareas.update_drawing
			end
		end
	end

	feature
		-- Redefinitions

		stone_type	: INTEGER	is
		do
			Result	:= Stone_types.client_type
		end

end -- class CLIENT_STONE
