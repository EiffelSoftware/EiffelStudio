note
	description: "Basic feature clause comments."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_CLAUSE_NAMES

feature -- Constants

	fc_Initialization: STRING = "Initialization"
	fc_Access: STRING = "Access"
	fc_Measurement: STRING = "Measurement"
	fc_Comparison: STRING = "Comparison"
	fc_Status_report: STRING = "Status report"
	fc_Status_setting: STRING = "Status setting"
	fc_Cursor_movement: STRING = "Cursor movement"
	fc_Element_change: STRING = "Element change"
	fc_Removal: STRING = "Removal"
	fc_Resizing: STRING = "Resizing"
	fc_Transformation: STRING = "Transformation"
	fc_Conversion: STRING = "Conversion"
	fc_Duplication: STRING = "Duplication"
	fc_Miscellaneous: STRING = "Miscellaneous"
	fc_Basic_operations: STRING = "Basic operations"
	fc_Obsolete: STRING = "Obsolete"
	fc_Inapplicable: STRING = "Inapplicable"
	fc_Implementation: STRING = "Implementation"
	fc_Other: STRING = "*"

feature -- Access

	Default_feature_clause_order: ARRAY [STRING]
			-- ISE feature clause order.
		once
			Result := <<
				fc_Initialization, fc_Access, fc_Measurement,
				fc_Comparison, fc_Status_report, fc_Status_setting,
				fc_Cursor_movement, fc_Element_change, fc_Removal,
				fc_Resizing, fc_Transformation, fc_Conversion,
				fc_Duplication, fc_Miscellaneous,
				fc_Basic_operations, fc_Obsolete, fc_Inapplicable,
				fc_Implementation, fc_Other
			>>
		end

note
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

end -- class FEATURE_CLAUSE_NAMES
