indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_DEFERRED_FEATURE_GENERATOR

inherit
	WIZARD_EIFFEL_ASSERTION_GENERATOR

feature -- Basic operations

	set_precondition_feature_writer (a_precondition_feature_writer: WIZARD_WRITER_FEATURE; function_name: STRING) is
			-- Set feature for user defined precondition.
		require
			non_void_name: function_name /= Void
			valid_name: not function_name.empty
			non_void_writer: a_precondition_feature_writer /= Void
		local
			a_body, a_comment: STRING
		do
			a_precondition_feature_writer.set_name (user_precondition_name (function_name))
			a_precondition_feature_writer.set_effective

			create a_body.make (100)
			a_body.append (Tab_tab_tab)
			a_body.append (Result_keyword)
			a_body.append (Space)
			a_body.append (Assignment)
			a_body.append (Space)
			a_body.append (True_keyword)
			a_precondition_feature_writer.set_body (a_body)

			a_precondition_feature_writer.set_result_type (Boolean_type)

			create a_comment.make (100)
			a_comment.append (Precondition_function_comment)
			a_comment.append (Back_quote)
			a_comment.append (function_name)
			a_comment.append (Single_quote)
			a_comment.append (Dot)
			a_comment.append (New_line_tab_tab_tab)
			a_comment.append (Double_dash)
			a_comment.append (Space)
			a_comment.append (Should_redefine)

			a_precondition_feature_writer.set_comment (a_comment)
		end

end -- class WIZARD_EIFFEL_DEFERRED_FEATURE_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
