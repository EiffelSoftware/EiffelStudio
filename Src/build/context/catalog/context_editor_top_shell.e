indexing
	description: "An independant context editor."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTEXT_EDITOR_TOP_SHELL

inherit
	EB_WINDOW
		redefine
			make, destroy, set_geometry
		end

	CONTEXT_EDITOR
		redefine
			make, set_callbacks
		end

	CLOSEABLE

creation
	make

feature {NONE} -- Initialisation

	make (par: EV_WINDOW) is
		local
			vbox: EV_VERTICAL_BOX
			toolbar: EV_TOOL_BAR
			trash_hole: CUT_HOLE
		do
			{EB_WINDOW} Precursor (par)
			create vbox.make (Current)

			create toolbar.make (vbox)
			create context_hole.make (toolbar)
			create trash_hole.make (toolbar)

			{CONTEXT_EDITOR} Precursor (vbox)
--			initialize_window_attributes
		end

	set_values is
		do
			set_title (Widget_names.context_editor)
			set_icon_name (Widget_names.context_editor)
			if is_valid (Pixmaps.context_pixmap) then
				set_icon_pixmap (Pixmaps.context_pixmap)
			end
		end

	set_callbacks is
		do
			set_close_callback (Void)
			{CONTEXT_EDITOR} Precursor
		end

feature -- Geometry

	set_geometry is
		do
			set_minimum_width (Resources.cont_ed_width)
			set_minimum_height (Resources.cont_ed_height)
		end

feature -- Update

	update_title is
		local
			tmp: STRING
		do
			create tmp.make (0)
			tmp.append (Widget_names.Context_name)
			tmp.append (": ")
			tmp.append (edited_context.title_label)
			set_title (tmp)
			set_icon_name (tmp)
		end

feature -- Close features

	close (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Close current editor
		do
			clear
			window_mgr.close (Current)
		end

	destroy is
		do
			clear
			{EB_WINDOW} Precursor
		end

end -- class CONTEXT_EDITOR_TOP_SHELL

