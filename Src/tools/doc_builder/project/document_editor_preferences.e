indexing
	description: "User editor preferences."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_EDITOR_PREFERENCES

create
	make
	
feature {DOCUMENT_EDITOR} -- Creation
	
	make (a_editor: like editor) is
			-- Make
		require
			editor_not_void: a_editor /= Void			
		do
			editor := a_editor
			initialize
		ensure
			editor_set: editor = a_editor
		end		

	initialize is
			-- Initialize values
		local
			l_font_consts: EV_FONT_CONSTANTS
		do
			create l_font_consts
			create font.make_with_values (l_font_consts.family_typewriter, l_font_consts.weight_regular, l_font_consts.shape_regular, 11)
		end		

feature -- Access

	font: EV_FONT
			-- Font currently in use

	word_wrap_on: BOOLEAN is
			-- Is word wrapping on?
		do
			Result := editor.parent_window.wrap_menu_item.is_selected	
		end	
	
feature -- Commands

	load_font_dialog is
			-- Loaf font selection dialog
		local
			l_dialog: EV_FONT_DIALOG	
		do
			create l_dialog.make_with_title ("Choose Font")
			l_dialog.set_font (font)
			l_dialog.show_modal_to_window (editor.parent_window)
			if l_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				font := l_dialog.font
				editor.refresh
			end
		end		
		
feature {NONE} -- Implementation

	editor: DOCUMENT_EDITOR
			-- Editor

invariant
	has_editor: editor /= void
	has_font: font /= Void

end -- class DOCUMENT_EDITOR_PREFERENCES
