note
	description: "Summary description for {CTR_CONSOLE_TOOL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_CONSOLE_TOOL

inherit
	CTR_TOOL
		redefine
			focus_widget
		end

	CTR_CONSOLE_OBSERVER

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	build_interface (a_container: EV_CONTAINER)
		local
			g: like grid
			c: like sd_content
			mtb: SD_TOOL_BAR
			tbbut: SD_TOOL_BAR_BUTTON
		do
			create g
			grid := g
			a_container.extend (g)
			c := sd_content

			g.enable_single_row_selection
			g.set_column_count_to (1)
			g.disable_row_height_fixed
			g.hide_header

			c.set_short_title ("Console ...")
			c.set_long_title ("Console")
			create mtb.make
			create tbbut.make
			tbbut.set_pixmap (icons.new_text_small_toolbar_button_standard_icon ("Clear console"))
			tbbut.select_actions.extend (agent do_clear_console)
			mtb.extend (tbbut)

			mtb.compute_minimum_size
			c.set_mini_toolbar (mtb)
		end

	do_clear_console
		do
			grid.set_row_count_to (0)
			pending_history := Void
		end

feature -- Basic operation

	log (m: STRING_GENERAL)
		do
			ev_application.do_once_on_idle (agent add_log (m, {CTR_CONSOLE}.log_normal_type))
		end

	log_warning (m: STRING_GENERAL)
		do
			ev_application.do_once_on_idle (agent add_log (m, {CTR_CONSOLE}.log_warning_type))
		end

	log_error (m: STRING_GENERAL)
		do
			ev_application.do_once_on_idle (agent add_log (m, {CTR_CONSOLE}.log_error_type))
		end

	add_log (m: STRING_GENERAL; t: INTEGER)
		local
			h: like pending_history
		do
			h := pending_history
			if h = Void then
				create h.make (25)
				pending_history := h
			end
			h.extend ([m, t])
			update
		end

feature -- Access

	focus_widget: detachable EV_WIDGET
			-- Real widget to focus, when `set_focus' is called
		do
			Result := grid
		end

	pending_history: detachable ARRAYED_LIST [TUPLE [message: STRING_GENERAL; type: INTEGER]]
			-- Message: log message
			-- Type: log type, see CTR_CONSOLE.log_***_type

	grid: ES_GRID

	update
		local
			g: like grid
			lab: EV_GRID_LABEL_ITEM
		do
			if attached pending_history as h then
				g := grid
				from
					h.start
					g.insert_new_rows (h.count, g.row_count + 1)
				until
					h.after
				loop
					create lab.make_with_text (h.item.message)
					inspect h.item.type
					when {CTR_CONSOLE}.log_warning_type then
						lab.set_foreground_color (warning_color)
					when {CTR_CONSOLE}.log_error_type then
						lab.set_foreground_color (error_color)
					else
					end
					g.set_item (1, g.row_count, lab)
					h.remove
				end
			end
		end

	error_color: EV_COLOR
		once
			Result := (create {EV_STOCK_COLORS}).red
		end

	warning_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 165, 0)
		end

end
