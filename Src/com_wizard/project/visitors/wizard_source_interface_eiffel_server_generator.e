indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_SOURCE_INTERFACE_SERVER_GENERATOR

	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

create
	generate

feature -- Initialization

	generate (an_interface: WIZARD_INTERFACE_DESCRIPTOR; a_coclass: WIZARD_COCLASS_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Initialize
		do
			an_eiffel_writer.add_feature (cookie_generator_feature (an_interface), Access)
			an_eiffel_writer.add_feature (interface_table_feature (an_interface), Access)
			an_eiffel_writer.add_feature (has_feature (an_interface), Status_report)
			an_eiffel_writer.add_feature (add_feature (an_interface), Basic_operations)
			an_eiffel_writer.add_feature (remove_feature (an_interface), Basic_operations)
			add_interface_features (an_interface, a_coclass, an_eiffel_writer)
		end


feature -- Basic operations

	cookie_generator_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Cookie generator feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
		local
			comment: STRING
		do
			create Result.make
			Result.set_attribute
			
			Result.set_name (cookie_generator_name (an_interface))
			Result.set_result_type ("ECOM_COOKIE_GENERATOR")
			
			create comment.make (100)
			comment.append (an_interface.name)
			comment.append (" cookie generator.")
			Result.set_comment (comment)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

	cookie_generator_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of cookie generator feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
		do
			create Result.make (100)
			Result.append (name_for_feature (an_interface.name))
			Result.append ("_cookie_generator")
		ensure
			non_void_feature: Result /= Void
			valid_feature: not Result.empty
		end
		
	interface_table_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Interface table feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
		local
			comment: STRING
			result_type: STRING
		do
			create Result.make
			Result.set_attribute
			
			Result.set_name (interface_table_name (an_interface))
			
			create result_type.make (100)
			result_type.append ("HASH_TABLE [" + 
					an_interface.implemented_interface.eiffel_class_name + ", INTEGER]")
			Result.set_result_type (result_type)
			
			create comment.make (100)
			comment.append (an_interface.name)
			comment.append (" table.")
			Result.set_comment (comment)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

	interface_table_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of cookie generator feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
		do
			create Result.make (100)
			Result.append (name_for_feature (an_interface.name))
			Result.append ("_call_back_interface_table")
		ensure
			non_void_feature: Result /= Void
			valid_feature: not Result.empty
		end

	has_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Has call-back feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
		local
			body: STRING
		do
			create Result.make
			Result.set_effective

			Result.set_name (has_feature_name (an_interface))
			Result.set_result_type ("BOOLEAN")
			Result.add_argument ("a_cookie: INTEGER")
			Result.set_comment ("Has call-back?")
			
			create body.make (1000)
			body.append (Tab_tab_tab)
			body.append ("if " + interface_table_name (an_interface) + " /= Void then%N%T%T%T%T")
			body.append ("Result := " + interface_table_name (an_interface) + ".has (a_cookie)%N%T%T%Tend")
			Result.set_body (body)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end
		
	add_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Add call-back feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
		local
			comment, body: STRING
			precondition, postcondition: WIZARD_WRITER_ASSERTION
		do
			create Result.make
			Result.set_effective
			
			Result.set_name (add_feature_name (an_interface))
			Result.set_result_type ("INTEGER")
			Result.add_argument ("a_call_back: " + 
					an_interface.implemented_interface.eiffel_class_name)
			
			create comment.make (100)
			comment.append ("Add " + an_interface.name + " call back.")
			Result.set_comment (comment)
			
			create precondition.make ("non_void_call_back", "a_call_back /= Void")
			Result.add_precondition (precondition)
			
			create postcondition.make ("non_void_table", interface_table_name (an_interface) + " /= Void")
			Result.add_postcondition (postcondition)
			
			create postcondition.make ("added", interface_table_name (an_interface) + ".has (Result)")
			Result.add_postcondition (postcondition)
			
			create body.make (1000)
			body.append (Tab_tab_tab)
			body.append ("if " + cookie_generator_name (an_interface) + " = Void then")
			body.append (New_line_tab_tab_tab + tab)
			body.append ("create " + cookie_generator_name (an_interface))
			body.append (New_line_tab_tab_tab)
			body.append ("end")
			body.append (New_line_tab_tab_tab)
			
			body.append ("if " + interface_table_name (an_interface) + " = Void then")
			body.append (New_line_tab_tab_tab + tab)
			body.append ("create " + interface_table_name (an_interface) + ".make (10)")
			body.append (New_line_tab_tab_tab)
			body.append ("end")
			
			body.append (New_line_tab_tab_tab)
			body.append ("Result := " + cookie_generator_name (an_interface) + ".next_key")
			body.append (New_line_tab_tab_tab)
			
			body.append ("check")
			body.append (New_line_tab_tab_tab + tab)
			body.append ("no_key: not " + interface_table_name (an_interface) + ".has (Result)")
			body.append (New_line_tab_tab_tab)
			body.append ("end")
			
			body.append (New_line_tab_tab_tab)
			body.append (interface_table_name (an_interface) + ".force (a_call_back, Result)")
			Result.set_body (body)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

	remove_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Remove call-back feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
		local
			comment, body: STRING
			precondition, postcondition: WIZARD_WRITER_ASSERTION
		do
			create Result.make
			Result.set_effective
			
			Result.set_name (remove_feature_name (an_interface))
			Result.add_argument ("a_cookie: INTEGER")
			
			create comment.make (100)
			comment.append ("Remove " + an_interface.name + " call back.")
			Result.set_comment (comment)
			
			create precondition.make ("non_void_cookie_generator", cookie_generator_name (an_interface) + " /= Void")
			Result.add_precondition (precondition)
			
			create precondition.make ("non_void_table", interface_table_name (an_interface) + " /= Void")
			Result.add_precondition (precondition)
			
			create precondition.make ("has", has_feature_name (an_interface) + " (a_cookie)")
			Result.add_precondition (precondition)

			create postcondition.make ("not_has", " not " + has_feature_name (an_interface) + " (a_cookie)")
			Result.add_postcondition (postcondition)
			
			create postcondition.make ("added_to_pool", cookie_generator_name (an_interface) + ".available_key_pool.has (a_cookie)")
			Result.add_postcondition (postcondition)
			
			create body.make (1000)
			body.append (Tab_tab_tab)
			body.append (cookie_generator_name (an_interface) + ".add_key_to_pool  (a_cookie)")
			body.append (New_line_tab_tab_tab)
			
			body.append (interface_table_name (an_interface) + ".remove (a_cookie)")
			Result.set_body (body)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

	add_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR; 
				a_coclass: WIZARD_COCLASS_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Add source interface features to coclass.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.empty
			non_void_coclass: a_coclass /= Void
			non_void_writer: an_eiffel_writer /= Void
		local
			function_generator: WIZARD_EIFFEL_SOURCE_SERVER_FUNCTION_GENERATOR
		do
			from
				an_interface.functions_start
			until
				an_interface.functions_after
			loop
				create function_generator.generate 
							(an_interface.functions_item, 
							a_coclass, interface_table_name (an_interface))
				an_eiffel_writer.add_feature 
							(function_generator.feature_writer, Basic_operations)
				an_interface.functions_forth
			end
		end
		
end -- class WIZARD_SOURCE_INTERFACE_EIFFEL_SERVER_GENERATOR

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
