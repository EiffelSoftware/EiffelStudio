note
	description: "Summary description for {WDOCS_CONTROL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_CONTROL

inherit
	EV_VERTICAL_BOX
		redefine
			create_interface_objects, initialize, is_in_default_state
		end

create
	make

feature {NONE} -- Initialization

	make (a_portnumber: INTEGER)
		do
			port_number := a_portnumber
			default_create
		end

	initialize
			-- Initialize `Current'.
		do
				-- Call `user_initialization'.
			user_initialization
			Precursor
		end

	create_interface_objects
			-- Create objects
		do
			create grid
			create wiki_page_select_actions
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			g: EV_GRID
			but: EV_BUTTON
		do
			create vb
			extend (vb)
			vb.set_border_width (3)
			vb.set_padding_width (3)

			create lab.make_with_text ("WDOCS")
			vb.extend (lab)
			vb.disable_item_expand (lab)

			g := grid
			g.enable_single_row_selection
			g.row_select_actions.extend (agent on_row_selected)
			vb.extend (g)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create but.make_with_text_and_action ("Refresh", agent on_refresh_requested)
			hb.extend (but)
		end

feature -- Access

	port_number: INTEGER

	wdocs_manager: WDOCS_MANAGER
		local
			cfg: WDOCS_INI_CONFIG
		once
			create cfg.make (create {PATH}.make_from_string ("eiffel-lang-app.ini"))
			create Result.make (cfg.documentation_dir.extended (cfg.documentation_default_version), cfg.documentation_default_version, cfg.temp_dir)
		end

	grid: EV_GRID

	wiki_page_select_actions: ACTION_SEQUENCE [TUPLE [WIKI_PAGE]]

feature -- Basic operation

	on_wiki_page_selected (wp: WIKI_PAGE)
		do
			wiki_page_select_actions.call ([wp])
		end

	on_row_selected (r: EV_GRID_ROW)
		do
			if not r.is_destroyed then
				if attached {READABLE_STRING_GENERAL} r.data as l_book_name then
					if
						attached wdocs_manager.book (l_book_name) as wb and then
						attached wb.root_page as wp
					then
						on_wiki_page_selected (wp)
					end
				end
			end
		end

	on_refresh_requested
		local
			wdocs: WDOCS_MANAGER
			glab: EV_GRID_LABEL_ITEM
			g: like grid
			l_book_name: READABLE_STRING_GENERAL
			i: INTEGER
		do
			g := grid
			g.clear
			g.wipe_out
			g.set_row_count_to (1)
			g.set_column_count_to (1)
			wdocs := wdocs_manager
			i := 0
			across
				wdocs.book_names as ic
			loop
				l_book_name := ic.item
				i := i + 1
				g.set_row_count_to (i)
				create glab.make_with_text (l_book_name)
				g.row (i).set_data (l_book_name)
				g.set_item (1, i, glab)
			end
		end

feature -- Status report

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

feature -- Element change

	set_port_number (p: INTEGER)
		do
			port_number := p
		end

feature {NONE} -- Implementation


end
