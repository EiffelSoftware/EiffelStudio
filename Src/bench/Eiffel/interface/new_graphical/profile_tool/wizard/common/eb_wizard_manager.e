indexing
	description	: "Class which is launching the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_WIZARD_MANAGER

inherit
	ANY

	EB_WIZARD_SHARED
		export
			{NONE} all
		end
	
feature -- Initialization

	make_and_show (a_parent_window: EV_WINDOW; a_wizard_initial_state: EB_WIZARD_INITIAL_STATE_WINDOW) is
			-- Prepare the first window to be displayed.
		local
			wizard_window: EB_WIZARD_WINDOW
			loc_wizard_window_icon: like wizard_window_icon
		do
			create wizard_window.make
			loc_wizard_window_icon := wizard_window_icon
			if loc_wizard_window_icon /= Void then
				wizard_window.set_icon_pixmap (loc_wizard_window_icon)
			end
			set_first_window (wizard_window)
			set_pixmaps (wizard_pixmap, wizard_icon_pixmap)

			wizard_window.load_first_state (a_wizard_initial_state)
			wizard_window.set_title (wizard_title)
			first_window.show_modal_to_window (a_parent_window)
			
				-- Clean up
			history.wipe_out								
			remove_first_window
		end
		
feature {NONE} -- Implementation

	wizard_title: STRING is
			-- Title for the wizard
		deferred
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
		end
	
	wizard_pixmap: EV_PIXMAP is
			-- Pixmap for the initial and final states of the wizard.
			-- This pixmap is displayed on the left of the window.
			--
			-- (`wizard_pixmap_icon' is drawn on it in the upper-right
			-- corner.)
		deferred
		ensure
			Result_not_void: Result /= Void
			Result_has_valid_size: Result.width >= 165 and Result.height >= 312
		end		
	
	wizard_icon_pixmap: EV_PIXMAP is
			-- Pixmap for the intermediary states.
			--
			-- (It is drawn on `wizard_pixmap' in the upper-right
			-- corner for the initial and final states.)
		deferred
		ensure
			Result_not_void: Result /= Void
			Result_has_valid_size: Result.width = 60 and Result.height = 60
		end
		
	wizard_window_icon: EV_PIXMAP is
			-- Icon for the wizard window
			--
			-- Return Void to use the default vision2 icon.
		deferred
		end
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_WIZARD_MANAGER
