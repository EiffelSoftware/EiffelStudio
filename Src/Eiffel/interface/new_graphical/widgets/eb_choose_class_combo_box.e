note
	description	: "Combo box to choose a class in the system. Accept wildcards"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHOOSE_CLASS_COMBO_BOX

inherit
	EB_CODE_COMPLETABLE_COMBO_BOX

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the dialog with the manager `a_favorites_manager'
		do
			default_create
			prepare
		end

	prepare
			-- Create the controls and setup the layout
		do
				-- Add Class Completion
			create text_completion.make (system.root_creators.first.root_class.compiled_class, Void)

			text_completion.set_code_completable (Current)
			text_completion.set_use_all_classes_in_universe (True)

			set_completion_possibilities_provider (text_completion)
			set_completing_feature (False)
		end

feature {NONE} -- Implementation

	text_completion: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER;
		-- Class completion provider.

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_CHOOSE_CLASS_COMBO_BOX

