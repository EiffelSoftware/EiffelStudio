indexing
	description: "Eiffel deferred function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_FUNCTION_GENERATOR

	WIZARD_EIFFEL_ASSERTION_GENERATOR

create
	generate

feature -- Basic operation

	generate (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate deferred function
		local
			tmp_arguments: STRING
		do
			func_desc := a_descriptor

			create feature_writer.make
			feature_writer.set_comment (func_desc.description)
			feature_writer.set_name (func_desc.interface_eiffel_name)

			-- Set arguments and precondition
			set_feature_result_type_and_arguments
			set_feature_assertions
			add_feature_argument_comments

			if func_desc.arguments /= Void and not func_desc.arguments.is_empty then
				func_desc.arguments.start

				if not is_paramflag_fretval (func_desc.arguments.item.flags) then
					create tmp_arguments.make (100)
					tmp_arguments.append (" (")
					tmp_arguments.append (func_desc.arguments.item.name)

					from
						func_desc.arguments.forth
					until
						func_desc.arguments.after
					loop
						if not is_paramflag_fretval (func_desc.arguments.item.flags) then
							tmp_arguments.append (", ")
							tmp_arguments.append (func_desc.arguments.item.name)
						end
						func_desc.arguments.forth
					end
					tmp_arguments.append (")")
				end
			end

			feature_writer.set_deferred
		end

end -- class WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

