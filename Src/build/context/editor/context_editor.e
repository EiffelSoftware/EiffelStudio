indexing
	description: "General notion of a context editor."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"


deferred class CONTEXT_EDITOR 

inherit

	COMPOSITE
		undefine
			init_toolkit
		redefine
			destroy
		end

	WINDOWS

	CONSTANTS

feature {NONE}

	context_hole: CON_EDIT_HOLE
	
feature 

	-- Context edited in the context editor
	edited_context: CONTEXT

	current_form_number: INTEGER
	
feature 

	form_list: ARRAY [EDITOR_FORM]

feature {ALIGNMENT_CMD}

	alignment_form: ALIGNMENT_FORM

	
feature {NONE}

	behavior_form: BEHAVIOR_FORM
	
	formats_rc: ROW_COLUMN

	trash_hole: CUT_HOLE

	scrolled_w: SCROLLED_W
			-- Scrolled window in which will appear the different property sets

feature 

	color_form: COLOR_FORM

	format_list: FORMAT_LIST

feature -- Attachments

--	attach_attributes_form (a_form: EDITOR_FORM) is
			-- Attach `a_form' in current context editor.
--		deferred
--		end

feature -- Editing contexts

	set_edited_context (new_context: CONTEXT) is
			-- Set `edited_context' to `new_context'
		local
			option_list: ARRAY [INTEGER]
			count, i: INTEGER
			other_editor: like Current
		do
				-- See if editor exists for current_form_number
			other_editor := context_catalog.editor 
				(new_context, current_form_number)
			if other_editor = Void then
				if new_context /= edited_context then
					option_list := new_context.option_list
					count := option_list.count
					if current_form_number = 0 then
						i := count + 1
					else
							-- Test if the current form 
							-- is defined for the context
						from
							i := 1
						until
							i > count or else
							option_list @ i = current_form_number
						loop
							i := i + 1
						end
					end
					if i > count then
							-- Could not find. Check to see if the first
							-- form number is being used
						other_editor :=	context_catalog.editor (new_context, 
											option_list @ 1)
						if other_editor = Void then
							if edited_context = Void or else
								not edited_context.eiffel_type.is_equal 
									(new_context.eiffel_type)
							then
								if formats_rc.realized then
									formats_rc.hide
								end
								format_list.update_buttons (option_list)
								if formats_rc.realized then
									formats_rc.show
								end
							end
							context_hole.set_full_symbol
							edited_context := new_context
							update_title
							set_form (edited_context.default_option_number)
						else
							other_editor.raise
						end
					else
						if edited_context = Void or else
							not edited_context.eiffel_type.is_equal 
								(new_context.eiffel_type)
						then
							formats_rc.unmanage
							format_list.update_buttons (option_list)
							formats_rc.manage
						end	
						context_hole.set_full_symbol
						edited_context := new_context
						update_title
						format_list.update_buttons (option_list)
						set_form (current_form_number)
					end
				end
			else
				other_editor.raise
			end
		end

	update_title is
			-- Update the title of the top shell if necessary
		deferred
		end
	
	set_form (a_form_number: INTEGER) is
			-- Display 'a_form' in the context editor window
		local
			prev_form, new_form: EDITOR_FORM
			mp: MOUSE_PTR
			msg: STRING
			prev_form_number: INTEGER
			format: FORMAT_BUTTON
		do
			prev_form_number := current_form_number
			if prev_form_number /= 0 then
				prev_form := form_list @ (prev_form_number)
			end
			current_form_number := a_form_number
			new_form := form_list @ (current_form_number)
			if not new_form.is_initialized then
				if prev_form /= Void then
					-- This is done here since it
					-- looks better under X
					prev_form.hide
				end
				!! mp
				mp.set_watch_shape
				new_form.make_visible (scrolled_w)
				mp.restore
				if prev_form /= Void then
					format := prev_form.associated_format_button
					format.unselect_symbol
				end
			elseif prev_form /= Void and then
				prev_form /= new_form
			then
				prev_form.hide
				format := prev_form.associated_format_button
				format.unselect_symbol
			end
			format := new_form.associated_format_button
			format.set_selected_symbol
			new_form.show
			scrolled_w.set_working_area (new_form)
			new_form.reset
		end

	behavior_form_shown: BOOLEAN is
			-- Is current_form a behavior_form?
		do
			Result := (current_form_number = Context_const.behavior_form_nbr)
		end

feature {FORMAT_BUTTON}

	update_form (form_nbr: INTEGER) is
			-- Update current form number to	
			-- `form_nbr' and display the 
			-- corresponding form page if
			-- necessary
		local
			other_editor: like Current	
		do
			if edited_context /= Void and then
				form_nbr /= current_form_number 
			then
				other_editor := context_catalog.editor 
					(edited_context, form_nbr)
				if other_editor = Void then
					set_form (form_nbr)
				else
					other_editor.raise
				end
			end
		end

feature -- Reseting

	destroy is
		do
			behavior_form.unregister_holes
			alignment_form.unregister_holes
			color_form.unregister_holes
			context_hole.unregister
			trash_hole.unregister
		end


	clear_behavior_editor is
		do
			if behavior_form /= Void and then
				behavior_form.is_initialized 
			then
				behavior_form.clear_editor
			end
		end

	clear is
			-- Reset the hole of the context editor
		local
			current_form: EDITOR_FORM
		do
			if current_form_number /= 0 then
				current_form := form_list @ (current_form_number)
				current_form.hide
				current_form.associated_format_button.unselect_symbol
			end
			edited_context := Void
			current_form_number := 0
			set_title (Widget_names.context_editor)
			set_icon_name (Widget_names.context_editor)
			context_hole.set_empty_symbol
			clear_behavior_editor
		end

	apply_current_form is
		require
			valid_form_number: current_form_number /= 0
		local
			current_form: EDITOR_FORM
		do
			current_form := form_list @ (current_form_number)
			current_form.apply
		end

	reset_current_form is
		require
			valid_form_number: current_form_number /= 0
		local
			current_form: EDITOR_FORM
		do
			current_form := form_list @ (current_form_number)
			current_form.reset
		end

	reset_behavior_editor is
		do
			if behavior_form /= Void and then
				behavior_form.is_initialized 
			then
				behavior_form.reset_editor
			end
		end

	update_state_name_in_behavior_page (s: STATE) is
			-- Update the state name in behavior page
			-- that displays `state'.
		do
			if behavior_form_shown then
				behavior_form.update_state_name (s)
			end
		end

	reset_geometry_form is
		local
			geo_form: GEOMETRY_FORM
		do
			if current_form_number /= 0 then
				geo_form ?= form_list @ (current_form_number)
				if geo_form /= Void then
					geo_form.reset
				end
			end
		end

	update_translation_page is
		require
			behaviour_form_shown: behavior_form_shown 
		local
			beh_form: BEHAVIOR_FORM
		do
			beh_form ?= form_list @ (current_form_number)
			beh_form.update_translation_page
		end

feature 

	set_title (a_title: STRING) is
			-- Set the title to `a_title'.
		deferred
		end

	set_icon_name (a_name: STRING) is
			-- Set icon name to `a_name'.
		deferred
		end

	top_form: FORM is
			-- The main form of the context editor
		deferred
		end
end
