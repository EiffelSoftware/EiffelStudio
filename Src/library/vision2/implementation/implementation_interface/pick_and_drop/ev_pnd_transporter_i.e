indexing
	description: "EiffelVision Pick and drop transporter%
				% Maintains the pick and drop mechanism%
				% and terminates it when the data is dropped."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_TRANSPORTER_I

inherit
	EV_COMMAND

feature {NONE} -- Attributes

	origin, destination: EV_COORDINATES

	dropped: BOOLEAN_REF is
		once
			create Result
		end

feature {EV_PND_TARGET_I} -- Targets

	targets: LINKED_LIST [EV_PND_TARGET_I] is
		once
			create Result.make
		end

feature {EV_PND_TARGET_I} -- Access

	register (target: EV_PND_TARGET_I) is
			-- Register Current as a target.
		require
			not_in_targets: not targets.has (target)
		do
			targets.put_front (target)
		ensure
			in_targets: targets.has (target)
		end
	
	unregister (target: EV_PND_TARGET_I) is
			-- Unregister Current as a target.
		require
			in_targets: targets.has (target)
		do
			targets.start
			targets.prune (target)
		ensure
			not_in_targets: not targets.has (target)
		end

feature {EV_PND_SOURCE_I} -- Transport

	start_from (dt_src: EV_PND_SOURCE_I; lx, ly: INTEGER) is
			-- Start the transport and
			-- draw the line from the 'initial_point'.
		do
			create origin.set (lx, ly)
			destination := clone (origin)
			dt_src.widget_source.set_capture
			dropped.set_item (False)
		end

	drop_command (args: EV_ARGUMENT2 [EV_PND_SOURCE_I, EV_INTERNAL_COMMAND]; ev_data: EV_PND_EVENT_DATA) is
			-- Drop the data in a target.
		deferred
		end

	cancel_command (args: EV_ARGUMENT2 [EV_PND_SOURCE_I, EV_INTERNAL_COMMAND]; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Drag canceled.
		local
			widg: EV_BUTTON_IMP
		do
			dropped.set_item (True)
			
			if ev_data = Void then
				-- Cancel command has been called from drop
				args.first.terminate_transport (args.second, True)
			else
				-- Cancel command executed as a callback
				args.first.terminate_transport (args.second, False)
			end
			args.first.widget_source.release_capture
			draw_segment (origin, destination)
				-- Reset the cursor
			widg ?= args.first.widget_source
			args.first.widget_source.set_cursor (Void)
		end

feature {NONE} -- Implementation

	draw_segment (pt1, pt2: EV_COORDINATES) is
			-- Draw a segment between (`lx1', `ly1') and (`lx2', `ly2').
		local
			screen: EV_SCREEN
		do
			create screen.make
			screen.set_logical_mode (10)
			screen.draw_segment (pt1, pt2)
		end

	pointed_target: EV_PND_TARGET_I is
			-- Target at mouse position
		deferred
		end

	execute (args: EV_ARGUMENT1 [EV_PND_SOURCE_I]; ev_data: EV_MOTION_EVENT_DATA) is
			-- Executed when the data is dragged.
		local
			target: EV_PND_TARGET_I
			curs_code: EV_CURSOR_CODE
			curs: EV_CURSOR
		do
			if not dropped.item then
				draw_segment (origin, destination)	
				destination.set (ev_data.absolute_x, ev_data.absolute_y)
				draw_segment (origin, destination)
				target := pointed_target
				if target /= Void and then target.accept (args.first.data_type) then
					-- set "authorized" cursor
					if args.first.data_type.cursor /= Void then
						args.first.widget_source.set_cursor (args.first.data_type.cursor)
					else -- set the standard cursor
						create curs_code.make
						create curs.make_by_code (curs_code.standard)
						args.first.widget_source.set_cursor (curs)
					end
				else
					-- set "forbidden" cursor
					create curs_code.make
					create curs.make_by_code (curs_code.no)
					args.first.widget_source.set_cursor (curs)
				end
			end
		end

end -- class EV_PND_TRANSPORTER_I

