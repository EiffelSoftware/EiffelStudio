indexing
	description: "Class responsible to eventually launch a Chart"
	date: "$Date$"
	revision: "$Revision$"

class
	CHART_WIN_COM

inherit
	EV_COMMAND

	ONCES

	CONSTANTS

creation
	make

feature -- Initialization

	make ( w : WORKAREA ) is
			-- Creation routine
		require
			workarea_not_void : w/= Void
		do
		--	worka := w
		--	!! timer.make
		--	System.set_timer_for_sneak(timer)
		--	!! flying_com.make ( worka )
		--ensure
		--	well_affected : worka /= Void
		end

feature -- Public attributes

	worka : WORKAREA

	--timer : TIMER
	
feature  -- Implementation

	i : INTEGER
		-- iteration

	x,y : INTEGER
		-- coords of the mouse

	flying_com : FLYING_COM
		-- Command for showing the window...
	
	execute(args: EV_ARGUMENT; data: EV_MOTION_EVENT_DATA) is
		-- Execution
		require else
			data_exists: data /= Void
		local
			x1,y1 : INTEGER -- the new x,y
		do 
--				if timer.is_call_back_set then
--					timer.set_no_call_back
--				end
--				x1 := motnot.relative_x
--				y1 := motnot.relative_y
--				flying_com.set_xy ( x1, y1 )
--				timer.set_next_call_back(Resources.delay_sneak, flying_com, Void )
--				if (x1/=x or y1/=y ) then
--					Windows.sneak_window.popdown
--					flying_com.erase_former_graph
--					--if worka/= Void and then
--					--	worka.analysis_window/= Void and then
--					--	worka.analysis_window.chart_window/= Void and then
--					--	worka.analysis_window.chart_window.currently_sneak then
--						--	worka.analysis_window.chart_window.unrealize
--					--end
--				end
--				x := x1
--				y := y1 
		end

end -- class CHART_WIN_COM
