indexing
	description: "Eiffel server function generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_EFFECTIVE_FUNCTION_GENERATOR

	WIZARD_DISPATCH_FUNCTION_HELPER
		export
			{NONE} all
		end

create 
	generate,
	generate_source,
	generate_on_hook

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate server feature.
		do
			if a_descriptor.is_renaming_clause then
				original_name := a_descriptor.interface_eiffel_name
				changed_name := a_descriptor.component_eiffel_name (a_component_descriptor)
				-- Could be identical if renaming occured for another component
				function_renamed := not original_name.is_equal (changed_name)
			else
				func_desc := a_descriptor
				create original_name.make (100)
				create changed_name.make (100)
	
				create feature_writer.make
	
				if a_descriptor.is_renamed_in (a_component_descriptor) then
					function_renamed := True
					original_name := a_descriptor.interface_eiffel_name
					changed_name := a_descriptor.component_eiffel_name (a_component_descriptor)
					feature_writer.set_name (changed_name)
				else
					feature_writer.set_name (a_descriptor.interface_eiffel_name)
				end
	
				set_feature_result_type_and_arguments
				
				feature_writer.set_comment (func_desc.description)
				add_feature_argument_comments
				feature_writer.set_body (Empty_function_body)
	
				feature_writer.set_effective
			end
		end

	generate_source (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate feature for source interface.
		local
			body: STRING
		do
			func_desc := a_descriptor
			create feature_writer.make
			feature_writer.set_name (a_descriptor.interface_eiffel_name)
			set_feature_result_type_and_arguments
			feature_writer.set_comment (func_desc.description)
			add_feature_argument_comments
			
			create body.make (100)
			body.append ("%T%T%T") 
			if does_routine_have_result (a_descriptor) then
				body.append ("Result := ")
			end
			body.append (on_hook_feature_name (a_descriptor.interface_eiffel_name))
			body.append (on_hook_feature_arguments)
			feature_writer.set_body (body)

			feature_writer.set_effective
		end

	generate_on_hook (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- "on_" hook feature.
		do
			func_desc := a_descriptor
			create feature_writer.make
			feature_writer.set_name (on_hook_feature_name (a_descriptor.interface_eiffel_name))
			set_feature_result_type_and_arguments
			feature_writer.set_comment (func_desc.description)
			add_feature_argument_comments
			feature_writer.set_body (Empty_function_body)

			feature_writer.set_effective
		end

feature {NONE} -- Implementation

	on_hook_feature_name (a_name: STRING): STRING is
			-- Name of "on_" hook feature.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			Result := a_name.twin
			Result.prepend ("on_")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end
	
	on_hook_feature_arguments: STRING is
			-- Arguments to call "on_" hook feature.
		require
			non_void_func_desc: func_desc /= Void
			non_void_arguments: func_desc.arguments /= Void
		local
			arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
		do
			arguments := func_desc.arguments

			from
				arguments.start
				create Result.make (100)
			until
				arguments.after
			loop
				if Result.is_empty then
					Result.append (" (")
				else
					Result.append (", ")
				end
				Result.append (arguments.item.name)
				arguments.forth
			end
			if not Result.is_empty then
				Result.append (")")
			end
		ensure
			non_void_arguments: Result /= Void
			valid_arguments: not func_desc.arguments.is_empty implies 
				not Result.is_empty
		end
		
end -- class WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR

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

