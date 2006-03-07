indexing
	description: "Add new reference dialog."
	date: "$Date$"
	revision: "$Revision$"

class
	NM_NEW_REFERENCE_DIALOG

inherit
	NM_NEW_REFERENCE_DIALOG_IMP

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

feature -- Access

	assembly: STRING
			-- Added assembly

	assembly_prefix: STRING
			-- Added assembly prefix

feature {NONE} -- Implementation
	
	on_location_change is
			-- Called by `change_actions' of `reference_location_combo'.
			-- Check if `Add' button should be enabled
		do
			if reference_location_combo.text.is_empty then
				add_button.disable_sensitive
			else
				add_button.enable_sensitive
			end
		end

	on_browse is
			-- Called by `select_actions' of `browse_button'.
			-- Open file browse dialog and add selected assembly.
		local
			l_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_dialog.make_with_title ("Browse for assembly...")
			l_dialog.filters.extend (["*.dll", "Assembly File"])
			l_dialog.filters.extend (["*.exe", "Assembly File"])
			l_dialog.filters.extend (["*.*", "Any File"])
			l_dialog.show_modal_to_window (Current)
			if not l_dialog.file_name.is_empty then
				reference_location_combo.set_text (l_dialog.file_name)
			end
		end

	on_add is
			-- Called by `select_actions' of `add_button'.
		do
			assembly := reference_location_combo.text
			assembly_prefix := prefix_combo.text
			destroy
		end

	on_cancel is
			-- Called by `select_actions' of `cancel_button'.
		do
			destroy
		end

end -- class NM_NEW_REFERENCE_DIALOG

--+--------------------------------------------------------------------
--| Name Mapper
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------