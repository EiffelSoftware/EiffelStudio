indexing

	description: "Source of the drag and drop.";
	date: "$Date$";
	revision: "$Revision $"

deferred class DRAG_SOURCE 

feature -- Properties

	source: WIDGET is
			-- Source of the stone: widget which triggers the 
			-- transport and yields the stone when
			-- clicked on with the right mouse button.
		deferred
		end;

	transportable: BOOLEAN is
			-- May current stone be transported.
			-- If transportable_stone is not Void then by default
			-- it is transported. May be redefined in descendants
			-- to reflect a given state of the application
		do
			Result := transported_stone /= Void
		ensure
			has_stone: Result implies transported_stone /= Void
		end;

	want_initial_position: BOOLEAN is
			-- Use `initial_x' and `initial_y' to define
			-- initial drawing point?
			-- (Otherwize, the absolute coordinates are used)
		do
			Result := True
		end;

	initial_x: INTEGER is
			-- Initial x starting point.
			-- By default it is in the middle of the widget.
		require
			want_initial_position: want_initial_position
		do
			Result := source.real_x + source.width // 2
		end;

	initial_y: INTEGER is
			-- Initial y starting point.
			-- By default it is in the middle of the widget.
		require
			want_initial_position: want_initial_position
		do
			Result := source.real_y + source.height // 2
		end;

feature -- Update

	update_before_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- before transport using button data `but_data'.
			-- Do nothing by default.
		require
			valid_but_data: but_data /= Void
		do
		end;

	update_after_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- after it has been dropped (and processed) or 
			-- has been aborted.
			-- (Do nothing by default).
		require
			valid_but_data: but_data /= Void
		do
		end;

feature -- Stone properties

	transported_stone: STONE is
			-- Stone associated with Current
		deferred
		end;

feature {NONE} -- Transport

	initialize_transport is
			-- Initialize the mechanism through which
			-- the current stone may be dragged and
			-- dropped.
		require
			valid_source: source /= Void
		do	
			source.set_action ("!<Btn3Down>", transport_command, Current);
		end;
	
	transport_command: TRANSPORT is
			-- Command which takes care of the 
			-- the transport.
		once
			!!Result
		end;

end -- class DRAG_SOURCE
