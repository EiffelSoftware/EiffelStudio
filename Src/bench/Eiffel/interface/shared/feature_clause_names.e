indexing
	description: "Basic feature clause comments."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_CLAUSE_NAMES

feature -- Constants

	fc_Initialization: STRING is "Initialization"
	fc_Access: STRING is "Access"
	fc_Measurement: STRING is "Measurement"
	fc_Comparison: STRING is "Comparison"
	fc_Status_report: STRING is "Status report"
	fc_Status_setting: STRING is "Status setting"
	fc_Cursor_movement: STRING is "Cursor movement"
	fc_Element_change: STRING is "Element change"
	fc_Removal: STRING is "Removal"
	fc_Resizing: STRING is "Resizing"
	fc_Transformation: STRING is "Transformation"
	fc_Conversion: STRING is "Conversion"
	fc_Duplication: STRING is "Duplication"
	fc_Miscellaneous: STRING is "Miscellaneous"
	fc_Basic_operations: STRING is "Basic operations"
	fc_Obsolete: STRING is "Obsolete"
	fc_Inapplicable: STRING is "Inapplicable"
	fc_Implementation: STRING is "Implementation"
	fc_Other: STRING is "*"

feature -- Access

	Default_feature_clause_order: ARRAY [STRING] is
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

end -- class FEATURE_CLAUSE_NAMES
