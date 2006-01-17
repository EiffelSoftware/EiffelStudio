indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_CLAUSE_SELECTOR

inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize,
			is_in_default_state
		end

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Create with defaults.
		do
			Precursor

			extend (new_label ("feature {"))
			disable_item_expand (last)

			create export_field
			fill_export_field
			export_field.set_minimum_width (60)
			extend (export_field)

			extend (new_label ("} -- "))
			disable_item_expand (last)

			create comment_field
			fill_comment_field
			comment_field.set_minimum_width (110)
			comment_field.set_text (fc_Access)
			extend (comment_field)
		end

feature -- Access

	code: STRING is
			-- Current text of the feature in the wizard.
		do
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		do
		end

feature -- Element change

	set_clause_name (a_name: STRING) is
			-- Set feature clause comment to `a_name'.
		do
			if a_name.is_empty then
				comment_field.remove_text
			else
				comment_field.set_text (a_name)
			end
		end

feature {EB_FEATURE_COMPOSITION_WIZARD} -- Implementation

	fill_export_field is
			-- Fill `export_field' with default export classes.
		local
			li: EV_LIST_ITEM
		do
			create li.make_with_text ("ANY")
			export_field.extend (li)
			create li.make_with_text ("NONE")
			export_field.extend (li)
		end

	fill_comment_field is
			-- Fill `comment_field' with feature clauses in order.
		local
			fco: ARRAY [STRING]
			i: INTEGER
			s: STRING
			li: EV_LIST_ITEM
		do
			fco := preferences.flat_short_data.feature_clause_order
			from
				i := fco.lower
			until
				i > fco.upper
			loop
				s := fco.item (i)
				if s /= Void and then not s.is_equal (fc_Other) then
					create li.make_with_text (s)
					comment_field.extend (li)
				end
				i := i + 1
			end
		end

feature {EB_FEATURE_COMPOSITION_WIZARD} -- Widgets

	export_field: EV_COMBO_BOX

	comment_field: EV_COMBO_BOX

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := (
				not is_homogeneous and
				border_width = 0 and
				padding = 0			
			)
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

end -- class EB_FEATURE_CLAUSE_SELECTOR
