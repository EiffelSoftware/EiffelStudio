indexing
	description: "Class used to store widget contexts."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	S_WIDGET

inherit
	S_CONTEXT
		redefine
			set_attributes, save_attributes
		end

feature {NONE} -- Storage

	x: INTEGER
			-- Horizontal position relative to parent

	y: INTEGER
			-- Vertical position relative to parent

	position_modified: BOOLEAN

	width: INTEGER
			-- Width of widget

	height: INTEGER
			-- Height of widget

	size_modified: BOOLEAN

--	font_name, bg_color_name: STRING
--
--	fg_color_name, bg_pixmap_name: STRING
--
--	font_name_modified: BOOLEAN
--
--	bg_color_modified: BOOLEAN
--
--	fg_color_modified: BOOLEAN
--
--	bg_pixmap_modified: BOOLEAN
--
--	resize_policy: S_RESIZE_POLICY

	set_attributes (c: CONTEXT) is
			-- Set the attributes of `c'
			-- to the stored values
		do
			{S_CONTEXT} Precursor (c)
--			if font_name_modified then
--					-- Set font before setting size
--				c.set_font_named (font_name)
--			end
			if position_modified then
				c.set_x_y (x, y)
			end
			if size_modified then
				c.set_size (width, height)
			end
--			if bg_color_modified then
--				c.set_bg_color_name (bg_color_name)
--			end
--			if bg_pixmap_modified then
--				c.set_bg_pixmap_name (bg_pixmap_name)
--			end
--			if fg_color_modified then
--				c.set_fg_color_name (fg_color_name)
--			end
--			if not (resize_policy = Void) then
--				c.set_resize_policy (resize_policy.resize_policy (c))
--			end
		end

	save_attributes (node: CONTEXT) is
		do
			{S_CONTEXT} Precursor (node)
			x := node.x
			y := node.y
			position_modified := node.position_modified
			width := node.width
			height := node.height
			size_modified := node.size_modified
--			font_name := node.font_name
--			font_name_modified := node.font_name_modified
--			bg_color_name := node.bg_color_name
--			bg_color_modified := node.bg_color_modified
--			fg_color_name := node.fg_color_name
--			fg_color_modified := node.fg_color_modified
--			bg_pixmap_name := node.bg_pixmap_name
--			bg_pixmap_modified := node.bg_pixmap_modified
--			if not (node.resize_policy = Void) then
--				resize_policy := node.resize_policy.stored_elmt
--			end
		end

feature {GROUP}

	reset_position (new_x_origin, new_y_origin: INTEGER) is
			-- Change the position because the origin has
			-- changed (the parent has changed)
		do
			x := x - new_x_origin
			y := y - new_y_origin
			position_modified := True
		end

end -- class S_WIDGET

