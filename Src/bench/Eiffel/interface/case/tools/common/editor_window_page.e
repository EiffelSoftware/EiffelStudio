indexing
	description: "Page for Personal Window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDITOR_WINDOW_PAGE

inherit

	ONCES

	CONSTANTS

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY) is
			-- Initialize
		require
			notebook_exists : noteb /= Void
		
		do
			notebook := noteb
			entity := ent 

			!! page.make (notebook)
			page.set_spacing (10)
			do_page
			!! text.make
			text.set_page (Current)
		ensure
			notebook_set: notebook = noteb
		end


feature -- Settings 

	set_namer(nam: EDITOR_WINDOW_NAMER) is
		do
			namer := nam
		end

feature -- Access

	namer: EDITOR_WINDOW_NAMER
		-- Namer Component eventually attached to the page.

	notebook: EV_NOTEBOOK
		-- Notebook of Personal Window

	page: EV_VERTICAL_BOX
		-- Current Page

	entity: ANY
		-- Entity whose information is displayed. 
		-- Eventually void

	text: ACTIVE_TEXT
		-- Text displayed within Current
		-- eventually empty

feature -- Update 

	update is 
		deferred 
		end

	reset is 
		deferred
		end

feature -- Graphical Layout
	
	do_page is 
		deferred
		end

feature -- Drag and Drop

	accept_stone(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			ev: EV_PND_EVENT_DATA
			cl: CLASS_DATA
		do
			ev ?= data
			if ev /= Void and then ev.data /= Void then
				cl ?= ev.data
				if cl /= Void then

				end
			end
		end

invariant
	notebook_exits: notebook /= Void
	page_exists: page /= Void

end -- class EDITOR_WINDOW_PAGE
