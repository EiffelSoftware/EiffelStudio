indexing
	description: "Dialog for displaying error informaion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_DIALOG

inherit
	ERROR_DIALOG_IMP

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			ok.select_actions.extend (agent hide)
		end		

feature -- Status Setting

	set_error (a_error: ERROR; a_context: STRING) is
			-- Set errors with `error_list'.
		require
			error_not_void: a_error /= Void
		do						
			create errors
			show_error_description (a_error)
			error_container.wipe_out
			error_container.extend (errors)
		end			
		
feature {NONE} -- Implementation
	
	show_error_description (a_error: ERROR) is
			-- Show error description of `a_error'
		local
			l_item: EV_LIST_ITEM
		do
			create l_item.make_with_text (a_error.description)
			if a_error.action /= Void then
				l_item.pointer_double_press_actions.force_extend (a_error.action)
			end
			errors.extend (l_item)			
		end			
			
	errors: EV_LIST;
			-- Error widget
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class ERROR_DIALOG

