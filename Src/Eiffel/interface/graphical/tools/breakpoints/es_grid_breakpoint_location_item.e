indexing
	description: "Objects that represents a breakpoint location grid item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_BREAKPOINT_LOCATION_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM
		redefine
			required_width
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EVS_GRID_ITEM_HELPER
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_loc: BREAKPOINT_LOCATION) is
			-- Create Current item
		do
			make_with_expose_action_agent (agent redraw_location)
			set_location (a_loc)
		end

feature -- Access

	location: BREAKPOINT_LOCATION
			-- Breakpoint location

	font: EV_FONT
			-- Font

	pixmap: EV_PIXMAP
			-- Pixmap

	required_width: INTEGER is
			-- Require width when resize_to_content occurs.
		local
			f: EV_FONT
		do
			f := font
			if f = Void then
				f := internal_default_font
			end
			Result := f.string_width (internal_text) + 6 --| 6 = 3 + 3
		end

feature -- Change

	set_location (a_loc: like location) is
			-- Set `location' to `a_loc'
		local
			r: E_FEATURE
			cl: CLASS_C
		do
			location := a_loc
			internal_text := a_loc.to_string

			create internal_text.make_empty
			create internal_class_range.make (0,0)
			create internal_feature_range.make (0,0)
			create internal_index_range.make (0,0)

			r := a_loc.routine
			if r /= Void then
				internal_text_feature := r.name
				cl := r.associated_class
				if cl /= Void then
					internal_text_class := Void
					internal_text_class := cl.name_in_upper
					internal_text.append_character ('{')
					internal_text.append_string (internal_text_class)
					internal_text.append_character ('}')
					internal_text.append_character ('.')
				end
				internal_text.append_string (internal_text_feature)
			else
				internal_text_feature := Void
				internal_text_class := Void
			end
			if not internal_text.is_empty then
				internal_text_index := "@" + a_loc.breakable_line_number.out
				internal_text.append_string (internal_text_index)
			end
		end

	set_font (v: like font) is
			-- Set font
		do
			font := v
			parent_redraw_item
		end

	set_pixmap (v: like pixmap) is
			-- Set pixmap
		do
			pixmap := v
			parent_redraw_item
		end

	remove_pixmap is
			-- Remove pixmap
		do
			pixmap := Void
			parent_redraw_item
		end

feature -- Cached information

	internal_text: STRING
			-- cached text

	internal_text_class,
	internal_text_feature,
	internal_text_index: STRING

	internal_class_range: INTEGER_INTERVAL
	internal_feature_range: INTEGER_INTERVAL
	internal_index_range: INTEGER_INTERVAL

	internal_width: INTEGER
			-- cached width

feature -- Pebble

	pebble_at_position: STONE is
			-- Pebble at pointer position
			-- Void if no pebble found at that position		
		local
			l_coord: EV_COORDINATE
			l_x: INTEGER
		do
			l_coord := relative_pointer_position (Current)
			l_x := l_coord.x
			if internal_class_range.has (l_x) then
				create {CLASSC_STONE} Result.make (location.routine.associated_class)
--			elseif internal_index_range.has (l_x) then
--				create {BREAKPOINT_LOCATION_STONE} Result.make (location)
			else
				create {FEATURE_STONE} Result.make (location.routine)
			end
		end

feature {NONE} -- Implementation

	redraw_location (a_drawable: EV_DRAWABLE) is
			-- Redraw span cell
		local
			g: EV_GRID
			vw, pw, w: INTEGER
			bg,fg: EV_COLOR
			class_color,
			feature_color,
			text_color: EV_COLOR
			f: EV_FONT
		do
			g := parent
			if is_selected then
--				fg := preferences.editor_data.selection_text_color
				fg := g.focused_selection_text_color
				bg := preferences.editor_data.selection_background_color
				class_color := fg
				feature_color := fg
				text_color := fg

				bg := g.focused_selection_color
			else
				class_color := preferences.editor_data.class_text_color
				feature_color := preferences.editor_data.feature_text_color
				text_color := preferences.editor_data.string_text_color
				bg := background_color
				if bg = Void then
					bg := row.background_color
					if bg = Void then
						bg := g.background_color
					end
				end
				fg := foreground_color
				if fg = Void then
					fg := row.foreground_color
					if fg = Void then
						fg := g.foreground_color
					end
				end
			end
			f := font
			if f = Void then
				f := internal_default_font
			end

			a_drawable.set_foreground_color (bg)
			a_drawable.fill_rectangle (0, 0, a_drawable.width, a_drawable.height)
			if not g.pre_draw_overlay_actions.is_empty then
				g.pre_draw_overlay_actions.call ([a_drawable, Current, column.index, row.index])
			end

			w := 0
			if pixmap /= Void then
				a_drawable.draw_pixmap (3 + w, 2, pixmap)
				w := w + pixmap.width + extra_space_after_pixmap
			end

			internal_class_range.resize (0, 0)
			internal_feature_range.resize (0, 0)
			internal_index_range.resize (0, 0)

			if location /= Void then
				a_drawable.set_font (f)
				if internal_text_class /= Void then
					w := w + 3
					pw := w
					a_drawable.set_foreground_color (fg)
					a_drawable.draw_text_top_left (w, 2, "{")
					w := w + f.string_width ("{")

					a_drawable.set_foreground_color (class_color)
					a_drawable.draw_text_top_left (w, 2, internal_text_class)
					w := w + f.string_width (internal_text_class)

					a_drawable.set_foreground_color (fg)
					a_drawable.draw_text_top_left (w, 2, "}.")
					w := w + f.string_width ("}.")

					internal_class_range.resize (pw, w)
				end
				if internal_text_feature /= Void then
					pw := w
					a_drawable.set_foreground_color (feature_color)
					a_drawable.draw_text_top_left (w, 2, internal_text_feature)
					w := w + f.string_width (internal_text_feature)

					internal_feature_range.resize (pw, w)
				end
				if internal_text_index /= Void then
					a_drawable.set_foreground_color (text_color)
					pw := w
					vw := width

					w := f.string_width (internal_text_index) + 3
					if (vw - w) > 3 + pw then
						w := vw - w
						a_drawable.draw_text_top_left (w, 2, internal_text_index)
						internal_index_range.resize (w, vw)
					else
						w := pw + w
						a_drawable.draw_text_top_left (w, 2, internal_text_index)
						internal_index_range.resize (pw, w)
					end
				end
			end
		end

	extra_space_after_pixmap: INTEGER is 5
			-- Space between pixmap and text.

	internal_default_font: EV_FONT is
			-- Default font used for `Current'.
		once
			create Result
		end

	parent_redraw_item is
		local
			l_parent: like parent
		do
			l_parent := parent
			if l_parent /= Void and then not l_parent.is_destroyed then
				l_parent.implementation.redraw_item (implementation)
			end
		end

--feature -- Implementation

--	grid_item: EV_GRID_ITEM is
--			-- EV_GRID item associated with current
--		do
--			Result := Current
--		end

--	on_pick: ANY is
--			-- Action to be performed when pick starts
--			-- Return value is the picked pebble if any.
--		do
--		end

--	on_pick_ends is
--			-- Action to be performed hwne pick-and-drop finishes
--		do
--		end

end
