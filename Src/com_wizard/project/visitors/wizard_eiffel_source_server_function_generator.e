indexing
	description: "Source interface function generator for Eiffel server."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_SOURCE_SERVER_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_FUNCTION_GENERATOR

	WIZARD_DISPATCH_FUNCTION_HELPER
		export
			{NONE} all
		end

create
	generate

feature -- Initialization

	generate (a_function: WIZARD_FUNCTION_DESCRIPTOR; 
				a_coclass: WIZARD_COCLASS_DESCRIPTOR;
				table_name: STRING) is
			-- Initialize
		require
			non_void_function: a_function /= Void
			non_void_coclass: a_coclass /= Void
			non_void_table_name: table_name /= Void
			valid_table_name: not table_name.empty
		local
			name, comment: STRING
		do
			func_desc := a_function
			create feature_writer.make
			feature_writer.set_effective
			
			create name.make (100)
			name.append (a_function.interface_eiffel_name)
			from
			until 
				not a_coclass.feature_eiffel_names.has (name) 
			loop
				name.append (One)
			end
			a_coclass.feature_eiffel_names.force (name)
			feature_writer.set_name (name)
			
			create comment.make (100)
			if
				a_function.description /= Void and then
				not a_function.description.empty
			then
				comment.append (a_function.description)
			else
				comment.append (a_function.name)
			end
			feature_writer.set_comment (comment)
			
			set_feature_result_type_and_arguments
			add_feature_argument_comments
			set_feature_assertions

			feature_writer.set_body (body (a_function, table_name))
		ensure
			non_void_feature: feature_writer /= Void
			valid_feature: feature_writer.can_generate
		end



feature -- Basic operations

	body (a_function: WIZARD_FUNCTION_DESCRIPTOR; table_name: STRING): STRING is
			-- Function body.
		require
			non_void_function: a_function /= Void
			non_void_table_name: table_name /= Void
			valid_table_name: not table_name.empty
		do
			create Result.make (1000)
			Result.append ("%T%T%T%
							%if " + table_name + " /= Void then%N%T%T%T%T%
								%from%N%T%T%T%T%T" +
									table_name + ".start%N%T%T%T%T%
								%until%N%T%T%T%T%T" +
									table_name + ".after%N%T%T%T%T%
								%loop%N%T%T%T%T%T") 
			if  does_routine_have_result (a_function) then
				Result.append ("Result := ")
			end
			Result.append (table_name + ".item_for_iteration." + function_call (a_function) + "%N%T%T%T%T%T" +
							table_name + ".forth%N%T%T%T%T%
							%end%N%T%T%Tend")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	function_call (a_function: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- Call to interface function.
		require
			non_void_function: a_function /= Void
		local
			call_arguments: STRING
		do
			create Result.make (100)
			Result.append (a_function.interface_eiffel_name)
			if
				a_function.argument_count > 0 and
				(a_function.argument_count = 1 implies 
				not is_paramflag_fretval (a_function.arguments.first.flags))
			then
				create call_arguments.make (100)
				
				from
					a_function.arguments.start
				until
					a_function.arguments.after or
					is_paramflag_fretval (a_function.arguments.item.flags)
				loop
					if not call_arguments.empty then
						call_arguments.append (", ")
					else
						call_arguments.append (" (")
					end
					call_arguments.append (a_function.arguments.item.name)
					a_function.arguments.forth
				end
				call_arguments.append (")")
				Result.append (call_arguments)
			end
		ensure
			non_void_call: Result /= Void
			valid_call: not Result.empty
		end
		
end -- class WIZARD_EIFFEL_SOURCE_SERVER_FUNCTION_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
