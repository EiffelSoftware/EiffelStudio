indexing
	description: "State editor window."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class STATE_EDITOR 

inherit
	EB_WINDOW
		redefine
			make, set_geometry
		end

	FUNC_EDITOR
		redefine
			clear, edited_function,
			output_hole, input_hole,
			edit_hole,
			set_edited_function
		end

	WINDOWS

	CLOSEABLE

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
		do
			{EB_WINDOW} Precursor (par)
			initialize (Current)
			set_values
			set_callbacks
		end

	edit_hole: S_EDIT_HOLE

	create_menu (par: EV_BOX) is
		local
			vbox: EV_VERTICAL_BOX
			tbar: EV_TOOL_BAR
			sep: EV_HORIZONTAL_SEPARATOR
			merge_hole: S_MERGE_HOLE
			cut_hole: CUT_HOLE
		do
			create vbox.make (par)
			create tbar.make (vbox)
			create sep.make (vbox)

			create edit_hole.make_with_editor (tbar, Current)
			create merge_hole.make_with_editor (tbar, Current)
			create cut_hole.make (tbar)

			vbox.set_spacing (2)
			par.set_child_expandable (vbox, False)
		end

	clear_menu is
		do
			edit_hole.set_empty_symbol
		end

	set_values is
		do
--			initialize_window_attributes
			set_title (Widget_names.state_editor)
			set_icon_pixmap (Pixmaps.state_pixmap)
			input_list.set_column_title (Widget_names.context_label, 1)
			output_list.set_column_title (Widget_names.behaviour_label, 1)
		end

	set_callbacks is
		do
			set_close_callback (Void)
		end

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.state_ed_width,
					Resources.state_ed_height)
		end

feature -- Input/output

	input_hole: CONTEXT_HOLE 

	output_hole: BEHAVIOR_HOLE

feature -- Edited features

	edited_function: BUILD_STATE

	set_edited_function (f: like edited_function) is
		do
			Precursor (f)
			update_title
		end

feature 

	empty: BOOLEAN is
		do
			Result := (edited_function = Void)
		end

	close (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			clear
			window_mgr.close (Current)
		end

	clear is
		do
			Precursor
			set_title (Widget_names.state_editor)
			set_icon_name (Widget_names.state_editor)
		end

	update_title is
		 local
			tmp: STRING
		do
			!! tmp.make (0)
			tmp.append (Widget_names.state_name)
			tmp.append (": ")
			tmp.append (edited_function.label)
			set_title (tmp)
			set_icon_name (tmp)
		end

	update_context_name (c: CONTEXT) is
			-- Update context name in Current editor for 
			-- context `c'.
		local
			finished: BOOLEAN
			old_cur: CURSOR
--			icons: LINKED_LIST [FUNC_CON_IS]
		do
--			icons := input_list.icons
--			old_cur := icons.cursor
--			from
--				icons.start
--			until
--				icons.after or else finished
--			loop
--				if icons.item.data = c then
--					finished := True
--					icons.item.update_label_text
--				end
--				icons.forth
--			end
--			icons.go_to (old_cur)
		end

end -- class STATE_EDITOR

