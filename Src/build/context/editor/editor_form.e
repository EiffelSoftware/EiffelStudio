indexing
	description: "Form used to display context properties."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class EDITOR_FORM 

inherit

	CONSTANTS
	FORM
		rename
			make as form_create,
			make_unmanaged as form_create_unmanaged,
			init_toolkit as form_init_toolkit
		end

feature 

	editor: CONTEXT_EDITOR
			-- Assocated context editor

	is_initialized: BOOLEAN
			-- Is current initialized (i.e
			-- has the form widget been created?)

	make_visible (a_parent: COMPOSITE) is
			-- Create form.
		require
			valid_parent: a_parent /= Void
		deferred
		ensure
			is_shown: shown
		end

	reset is
			-- Reset the content of the form
		require
			valid_context: context /= Void
		deferred
		end

	apply is
			-- Update the context according to 
			-- the content of the form
		require
			valid_context: context /= Void
		deferred
		end
	
	context: CONTEXT is
			-- Current context for form
		require
			valid_editor: editor /= Void
			valid_edited_context: editor.edited_context /= Void
		do
			Result := editor.edited_context
		ensure
			valid_context: Result /= Void
		end

	associated_format_button: FORMAT_BUTTON is
			-- Assocated format button for Current form
		require
			valid_editor: editor /= Void
		do
			Result := editor.format_list @ (format_number)
		ensure
			valid_result: Result /= Void
		end

feature {NONE}
	
	form_number: INTEGER is
			-- Form number associated with Current form
		deferred
		end

	format_number: INTEGER is
			-- Format number associated with Current form
			-- (For format button shown in editor)
		deferred
		end

	make (ed: CONTEXT_EDITOR) is
			-- Add Current to the forms_list of context_editor
		require
			valid_ed: ed /= Void
		do
			editor := ed
			ed.form_list.put (Current, form_number)
		ensure
			editor_set: editor /= Void
			editor_has_current: ed.form_list.has (Current)
		end

	initialize (a_name: STRING; a_parent: COMPOSITE) is
			-- Creates the form
		require
			valid_a_name: a_name /= Void
			valid_a_parent: a_parent /= Void
			editor_already_set: editor /= Void
		do
			form_create (a_name, a_parent)
--			editor.attach_attributes_form (Current)
			hide
--			unmanage
			is_initialized := true
		ensure
			not_shown: not shown
		end

	show_current is
		require
			not_shown: not shown
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			!! set_colors
			set_colors.execute (Current)
--			editor.attach_attributes_form (Current)
			show
--			manage
		ensure
			shown: shown
		end

end
