indexing
	description: "General notion of a context editor."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"


deferred class CONTEXT_EDITOR

inherit
	EV_COMMAND

	WINDOWS

	CONSTANTS

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the pages.
		local
			vbox: EV_VERTICAL_BOX
			geometry_form: GEOMETRY_FORM
--			label_text_form: LABEL_TEXT_FORM
			window_form: WINDOW_FORM
--			separator_form: SEPARATOR_FORM
			text_form: TEXT_FORM
--			menu_form: MENU_FORM
--			bar_form: BAR_FORM
--			pict_color_form: PICT_COLOR_FORM
--			arrow_b_form: ARROW_B_FORM
--			scroll_l_form: SCROLL_L_FORM
--			font_form: FONT_FORM
--			scale_form: SCALE_FORM
--			pulldown_form: PULLDOWN_FORM
			text_field_form: TEXT_FIELD_FORM
--			color_form: COLOR_FORM
--			drawing_box_form: DRAWING_BOX_FORM
--			bull_resize_form: BULL_RESIZE_FORM
--			grid_form: GRID_FORM
--			toggle_form: TOGGLE_FORM
		do
			create notebook.make (par)

			create temp_list.make (1, Context_const.total_number_of_forms)

				--XX Replace vertical box by container with only one child...
			create vbox.make (notebook)
			notebook.append_page (vbox, "Behavior")
				--XX insert page to position `form_number'
			temp_list.put (vbox, 1)
			create vbox.make (notebook)
			notebook.append_page (vbox, "Attributes")
			temp_list.put (vbox, 2)
			create vbox.make (notebook)
			notebook.append_page (vbox, "Geometry")
			temp_list.put (vbox, 3)
			create vbox.make (notebook)
			notebook.append_page (vbox, "Colors")
			temp_list.put (vbox, 4)
			create vbox.make (notebook)
			notebook.append_page (vbox, "Alignement")
			temp_list.put (vbox, 5)

			create forms_list.make (1, Context_const.total_number_of_forms)

			create behavior_form.make (Current)
			forms_list.put (behavior_form, Context_const.behavior_form_nbr)
--			create label_text_form.make (Current)
			create window_form.make (Current)
			forms_list.put (window_form, Context_const.window_att_form_nbr)
--			create separator_form.make (Current)
			create text_form.make (Current)
			forms_list.put (text_form, Context_const.text_att_form_nbr)
--			create menu_form.make (Current)
--			create bar_form.make (Current)
--			create pict_color_form.make (Current)
--			create arrow_b_form.make (Current)
--			create scroll_l_form.make (Current)
--			create font_form.make (Current)
--			create alignment_form.make (Current)
--			create scale_form.make (Current)
--			create pulldown_form.make (Current)
			create text_field_form.make (Current)
			forms_list.put (behavior_form, Context_const.text_field_att_form_nbr)
--			create color_form.make (Current)
--			create drawing_box_form.make (Current)
--			create bull_resize_form.make (Current)
--			create grid_form.make (Current)
--			create toggle_form.make (Current)

			set_values
			set_callbacks
		end

	set_values is
		deferred
		end

	set_callbacks is
		local
			cmd: PND_ACCELERATOR
			arg: EV_ARGUMENT1 [ANY]
			rcmd: EV_ROUTINE_COMMAND
		do
			create cmd
			create arg.make (edited_context)
			context_hole.add_button_press_command (3, cmd, arg)
			create rcmd.make (~init_transport)
			context_hole.activate_pick_and_drop (rcmd, Void)
			context_hole.set_data_type (Pnd_types.context_type)
			context_hole.add_pnd_command (Pnd_types.context_type, Current, Void)
			notebook.add_pnd_command (Pnd_types.context_type, Current, Void)
		end

feature {EDITOR_FORM} -- GUI attributes

	notebook: EV_NOTEBOOK

	context_hole: CON_EDIT_HOLE

	behavior_form: BEHAVIOR_FORM

feature {NONE} -- Choices of forms

	forms_list: ARRAY [EDITOR_FORM]
			-- Array of possible forms

	temp_list: ARRAY [EV_VERTICAL_BOX]
			--XX Replace when there will be access to the 
			-- children of the notebook

feature -- Access

	edited_context: CONTEXT
			-- Context edited in the context editor

	current_page: INTEGER is
		do
			Result := notebook.current_page
		end

	set_current_page (index: INTEGER) is
		do
			notebook.set_current_page (index)
		end

	page (i: INTEGER): EV_CONTAINER is
			-- Container at the position `i' in the `notebook'.
		do
--			Result := notebook.page (i)
			Result := temp_list.item (i)
		end

	show is
		deferred
		end

--feature {ALIGNMENT_CMD}

--	alignment_form: ALIGNMENT_FORM

feature {CONTEXT_EDITOR} -- Command

	init_transport (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
		do
			context_hole.set_transported_data (edited_context)
		end

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Edit the dropped context.
		local
			ctxt: CONTEXT
		do
			ctxt ?= ev_data.data
			set_edited_context (ctxt)
		end

feature -- Editing contexts

	set_edited_context (new_context: CONTEXT) is
			-- Set `edited_context' to `new_context'
		local
			option_list: ARRAY [INTEGER]
			count, i: INTEGER
			other_editor: like Current
		do
				-- See if editor exists for `current_page'
			other_editor := context_catalog.editor (new_context)
			if other_editor = Void then
				if new_context /= edited_context then
					option_list := new_context.option_list
					count := option_list.count
						-- Test if the current form 
						-- is defined for the context
					from
						i := 1
					until
						i > count or else option_list.item (i) = current_page
					loop
						i := i + 1
					end
					if i > count then
							-- Could not find.
							-- Display the first form (behavior)
						set_current_page (edited_context.default_option_number)
					end
					if edited_context = Void or else
					not edited_context.eiffel_type.is_equal
									(new_context.eiffel_type)
					then
						edited_context := new_context
						update_pages (option_list)
					end
					context_hole.set_full_symbol
					update_title
				end
			else
				other_editor.show
				other_editor.set_current_page (current_page)
			end
		end

	update_pages (opt_list: ARRAY [INTEGER]) is
			-- Update the pages of the context editor.
		local
			i, form_number: INTEGER
			pg: EV_VERTICAL_BOX
		do
			from
				i := 1
			until
				i >= opt_list.count
			loop
				form_number := opt_list.item (i)
				pg ?= page (i)
--				if pg.child /= Void then
--						-- there is a form in the page
--					pg.child.set_parent (Void)
--				end
				if form_number /= 0 then
					forms_list.item (form_number).set_parent (pg)
					reset_form (form_number)
				end
				i := i + 1
			end
		end

	update_title is
			-- Update the title of the top shell if necessary
		deferred
		end

	behavior_form_shown: BOOLEAN is
			-- Is current_form a `behavior_form'?
		do
			Result := (current_page = Context_const.behavior_form_nbr)
		end

feature -- Reseting

	clear_behavior_editor is
		do
			if behavior_form /= Void then
				behavior_form.clear_editor
			end
		end

	clear is
			-- Reset the hole of the context editor
		do
			--XX reset and hide all the pages of the notebook
			edited_context := Void
			set_title (Widget_names.context_editor)
			set_icon_name (Widget_names.context_editor)
			context_hole.set_empty_symbol
			clear_behavior_editor
		end

	apply_form (nb: INTEGER) is
			-- Apply form with number `form_nbr'.
		do
			forms_list.item (nb).apply
		end

	reset_form (nb: INTEGER) is
			-- Reset form with number `form_nbr'.
		do
			forms_list.item (nb).reset
		end

	reset_behavior_editor is
		do
			if behavior_form /= Void then
				behavior_form.reset_editor
			end
		end

	update_state_name_in_behavior_page (s: BUILD_STATE) is
			-- Update the state name in behavior page
			-- that displays `state'.
		do
			if behavior_form_shown then
				behavior_form.update_state_name (s)
			end
		end

	reset_geometry_form is
		local
--			geo_form: GEOMETRY_FORM
		do
--			geo_form ?= pages @ (current_form_number)
--			if geo_form /= Void then
--				geo_form.reset
--			end
		end

--	update_translation_page is
--		require
--			behaviour_form_shown: behavior_form_shown 
--		local
--			beh_form: BEHAVIOR_FORM
--		do
--			beh_form ?= form_list @ (current_form_number)
--			beh_form.update_translation_page
--		end

feature -- Status setting

	set_title (a_title: STRING) is
			-- Set the title to `a_title'.
		deferred
		end

	set_icon_name (a_name: STRING) is
			-- Set icon name to `a_name'.
		deferred
		end

end -- class CONTEXT_EDITOR

