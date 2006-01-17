indexing
	description: "Version of FCW that only allows for queries."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_QUERY_COMPOSITION_WIZARD

inherit
	EB_FEATURE_COMPOSITION_WIZARD
		redefine
			feature_editor,
			set_default_editor,
			feature_type,
			on_proc_select
		end

create
	make

feature {NONE} -- Initialization

	set_default_editor is
		do
			proc_button.disable_sensitive
			create {EB_ATTRIBUTE_EDITOR} feature_editor
			feature_editor_frame.extend (feature_editor)
			if not attr_button.is_selected then
				attr_button.enable_select
			end
		end

feature -- Status setting

	set_type (s: STRING) is
			-- Create a supplier of type `s'.
			-- (Could disable user selection...)
		do
			feature_editor.set_type (s)
		end

	set_name_number (a_number: INTEGER) is
			-- Assign `a_number' to `name_number'.
		do
			feature_editor.set_name_number (a_number)
		ensure
			a_number_assigned: feature_editor.name_number = a_number
		end

feature {CLASS_TEXT_MODIFIER} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True' in `feature_editor'.
		do
			feature_editor.enable_expanded_needed
		end

feature -- Access

	feature_type: STRING is
			-- Return type if attribute or function.
		do
			Result := feature_editor.type
		end

feature {NONE} -- Implementation

	feature_editor: EB_QUERY_EDITOR

	on_proc_select is
			-- User selected "procedure".
		do
			check
				should_not_be_called: False
			end
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

end -- class EB_QUERY_COMPOSITION_WIZARD
