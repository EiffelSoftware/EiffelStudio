indexing
	description: "Eiffel function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_EIFFEL_FUNCTION_GENERATOR

inherit
	WIZARD_FUNCTION_GENERATOR

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_EIFFEL_ASSERTION_GENERATOR
		export
			{NONE} all
		end

feature -- Access

	feature_writer: WIZARD_WRITER_FEATURE
			-- Feature writer

	function_renamed: BOOLEAN
			-- Function is renamed?

	original_name: STRING
			-- Original name

	changed_name: STRING
			-- Changed name

feature {NONE} -- Implementation

	set_feature_result_type_and_arguments is
			-- Set arguments
		require
			non_void_feature_writer: feature_writer /= Void
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			tmp_string: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			arguments := func_desc.arguments

			from
				arguments.start
			until
				arguments.off
			loop
				create visitor
				visitor.visit (arguments.item.type)

				if is_paramflag_fretval (arguments.item.flags) then
					pointed_descriptor ?= arguments.item.type
					create visitor

					if pointed_descriptor /= Void then
						visitor.visit (pointed_descriptor.pointed_data_type_descriptor)
					else
						visitor.visit (arguments.item.type)
					end
					feature_writer.set_result_type (visitor.eiffel_type)
				else
					tmp_string := clone (arguments.item.name)
					tmp_string.append (Colon)
					tmp_string.append (Space)
					tmp_string.append (visitor.eiffel_type)
					feature_writer.add_argument (tmp_string)
				end
				visitor := Void
				arguments.forth
			end

			create visitor
			visitor.visit (func_desc.return_type)

			-- Eiffel will not have result type if the result type is "void" or "HRESULT"
			if not is_hresult (visitor.vt_type) and then not is_void (visitor.vt_type) then
				feature_writer.set_result_type (visitor.eiffel_type)
			end

		end


	set_feature_assertions is
			-- Set precondition.
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			a_comment, comments: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			a_type: WIZARD_DATA_TYPE_DESCRIPTOR
		do
			arguments := func_desc.arguments
			create comments.make (0)

			from
				arguments.start
			until 
				arguments.off
			loop

				if not is_paramflag_fretval (arguments.item.flags) then
					create a_comment.make (0)
					a_comment.append (Double_dash)
					a_comment.append (Space)

					a_comment.append (Back_quote)
					a_comment.append (arguments.item.name)
					a_comment.append (Single_quote)
					a_comment.append (Space)
					a_comment.append (Open_bracket)
					if is_paramflag_fin (arguments.item.flags) then
						if is_paramflag_fout (arguments.item.flags) then
							a_comment.append (Inout)
						else
							a_comment.append (In)
						end
					else
						a_comment.append (Out_keyword)
					end
					a_comment.append (Close_bracket)
					a_comment.append (Dot)
					a_comment.append (New_line_tab_tab_tab)

					comments.append (a_comment)

					generate_precondition (arguments.item.name, arguments.item.type, 
						is_paramflag_fin (arguments.item.flags),
						is_paramflag_fout (arguments.item.flags))
					if not assertions.empty then
						from 
							assertions.start
						until
							assertions.off
						loop
							feature_writer.add_precondition (assertions.item)
							assertions.forth
						end
					end
				end

				if not comments.empty then
					feature_writer.set_comment (comments)
				end

				if is_paramflag_fout (arguments.item.flags) then
					if is_paramflag_fretval  (arguments.item.flags) then
						pointed_descriptor ?= arguments.item.type
						if pointed_descriptor /= Void then
							a_type := pointed_descriptor.pointed_data_type_descriptor
						else
							a_type := arguments.item.type
						end

						generate_postcondition (feature_writer.name, a_type, 
							is_paramflag_fretval  (arguments.item.flags))
					else
						generate_postcondition (arguments.item.name, arguments.item.type, 
							is_paramflag_fretval  (arguments.item.flags))
					end
					if not assertions.empty then
						from 
							assertions.start
						until
							assertions.off
						loop
							feature_writer.add_postcondition (assertions.item)
							assertions.forth
						end
					end
				end

				arguments.forth
			end
		end

end -- class WIZARD_EIFFEL_FUNCTION_GENERATOR
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
