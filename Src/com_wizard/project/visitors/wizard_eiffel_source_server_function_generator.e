indexing
	description: "Source interface function generator for Eiffel server."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	WIZARD_UNIQUE_IDENTIFIER_FACTORY
		export
			{NONE} all
		end

create
	generate

feature -- Initialization

	generate (a_function: WIZARD_FUNCTION_DESCRIPTOR; a_coclass: WIZARD_COCLASS_DESCRIPTOR; table_name: STRING) is
			-- Initialize
		require
			non_void_function: a_function /= Void
			non_void_coclass: a_coclass /= Void
			non_void_table_name: table_name /= Void
			valid_table_name: not table_name.is_empty
		local
			name, comment: STRING
		do
			func_desc := a_function
			create feature_writer.make
			feature_writer.set_effective
			
			create name.make (100)
			name.append ("event_")
			name.append (a_function.interface_eiffel_name)
			name := unique_identifier (name, agent (a_coclass.feature_eiffel_names).has (?))
			if not a_coclass.feature_eiffel_names.has (name) then
				a_coclass.feature_eiffel_names.put (Void, name)
			end
			feature_writer.set_name (name)
			
			create comment.make (100)
			if
				a_function.description /= Void and then
				not a_function.description.is_empty
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
			valid_table_name: not table_name.is_empty
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
			valid_body: not Result.is_empty
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
					if not call_arguments.is_empty then
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
			valid_call: not Result.is_empty
		end
		
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
end -- class WIZARD_EIFFEL_SOURCE_SERVER_FUNCTION_GENERATOR

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

