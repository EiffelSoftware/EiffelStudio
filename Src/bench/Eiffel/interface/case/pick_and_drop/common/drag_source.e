indexing

	description: "Source (widget) of a drag and drop.";
		date: "$Date$";
	revision: "$Revision $"

deferred class 
	DRAG_SOURCE

feature -- Properties

	source: EV_WIDGET is
			-- Source of the stone: widget which triggers the 
			-- transport and yields the stone when
			-- clicked on with the right mouse button.
		deferred
		end;

	transportable: BOOLEAN is
			-- May stone associated to Current be transported ?
		do
			Result := (stone /= Void)
		end;

	want_initial_position: BOOLEAN is
			-- Use `initial_x' and `initial_y' to define
			-- initial drawing point?
		do
			Result := True
		end;

	initial_x: INTEGER is
			-- Initial x starting point.
			-- By default it is in the middle of the widget.
		require
			want_initial_position: want_initial_position
		do
		--	Result := source.real_x + source.width // 2
		end;

	initial_y: INTEGER is
			-- Initial y starting point.
			-- By default it is in the middle of the widget.
		require
			want_initial_position: want_initial_position
		do
		--	Result := source.real_y + source.height // 2
		end;

feature -- Update

	--update_before_transport (but_data: BUTTON_DATA) is
	--		-- Update Current stone and related information
	--		-- before transport using button data `but_data'.
	--		--| Do nothing by default.
	--		--| `but_data' may be Void (when not used, for example)
	--	do
	--	end;

	--update_after_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- after it has been dropped (and processed) or 
			-- has been aborted.
			--| Do nothing by default.
			--| `but_data' may be Void (e.g. when not used, or when 
			--| irrelevant since the transport ended on an incorrect hole...)
	--	do
	--	end;

feature -- Stone properties

	--stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with 
			-- current stone during transport.
	--	do
	--		Result := stone.stone_cursor
	--	end;

	stone: STONE is
			-- Stone associated with Current, and that will be 
			-- dragged and dropped
		deferred
		end

feature {NONE} -- Transport

	initialize_transport is
			-- Initialize the mechanism through which
			-- the current stone may be dragged and
			-- dropped.
		require
			valid_source: source /= Void
		do	
		--	source.set_action ("<Btn3Down>", transport_command, Current);
		end;

	transport_command: TRANSPORT is
			-- Command which takes care of the 
			-- the transport.
		once
			!!Result
		end;

end -- DRAG_SOURCE
