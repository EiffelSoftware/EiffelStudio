indexing
	description: "Command in charge of deciding if we popup a sneak window"
	date: "$Date$"
	revision: "$Revision$"
	author : pascalf

class
	FLYING_COM

inherit
	
	EV_COMMAND

	ONCES

	CONSTANTS
creation
	make

feature -- Initialization

	make ( w : WORKAREA ) is
			-- Creation routine
		do
			worka := w
		end

feature -- attributes and settings 

	set_xy ( x1,y1 : INTEGER ) is
		do
			x := x1
			y := y1
		end

	x,y : INTEGER

	former_graph: GRAPH_LINKABLE

	erase_former_graph is
			-- Re-initialize 'former_graph' value
		do
			former_graph := Void
		end

feature {NONE} -- Implementation

	worka : WORKAREA

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			gr : GRAPH_CLASS
			gr_ico : GRAPH_ICON

			screen	: EV_SCREEN
	--		sneak_window	: SNEAK_WINDOW

			pos_x	: INTEGER
			pos_y	: INTEGER
		do
		--	if Windows.namer_window = Void or else
		--		not Windows.namer_window.realized then
					-- We do not want the window to popup when 
					-- using the namer tool
		--	if resources.sneak_window_display = 1 then
		--		if transporter.dropped = True
		--		then
		--			gr ?= worka.figure_at ( x,y )
		--			gr_ico ?= worka.figure_at ( x, y )
		--			if gr /= Void and then gr /= former_graph then
		--				-- we point a class
		--				former_graph := gr
		--				screen	:= windows.screen
		--				sneak_window	:= windows.sneak_window
--	
--					--	if screen.x < screen.visible_width / 2
--					--	then
--					--		pos_x	:= screen.visible_width - sneak_window.width - 50
--					--	else
--					--		pos_x	:= 0
--					--	end
--					--	if screen.y < screen.visible_height / 2
--					--	then
--					--		pos_y	:= screen.visible_height - sneak_window.height - 50
					--	else
					--		pos_y	:= 0
					--	end
--						sneak_window.set_coord	( pos_x	, pos_y	) 
--						sneak_window.set_class ( gr.data )
--						sneak_window.set_size (resources.sneak_window_width, resources.sneak_window_height)
	
--					else
--						if gr_ico/= Void then
--							-- we point an iconized cluster ...
						--	worka.analysis_window.create_chart_window
						--	worka.analysis_window.chart_window.set_for_sneak ( gr_ico.data )
--						--	worka.analysis_window.display_cluster_chart_window
--						end	
--					end	
--				end
--			end
		--	end
		end

end -- class FLYING_COM
