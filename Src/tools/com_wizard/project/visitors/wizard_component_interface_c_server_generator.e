indexing
	description: "Processing interface for C server component."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			property_generator: WIZARD_CPP_SERVER_PROPERTY_GENERATOR
		do
			create property_generator

			property_generator.generate (component, a_property)
			cpp_class_writer.add_function (property_generator.c_access_feature, Public)

			if a_property.is_read_only then
				cpp_class_writer.add_function (property_generator.c_setting_feature, Public)
			end
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			function_generator: WIZARD_CPP_SERVER_FUNCTION_GENERATOR
		do
			if not a_function.is_renaming_clause then
				if a_function.func_kind = Func_dispatch then
					create {WIZARD_CPP_DISPATCH_SERVER_FUNCTION_GENERATOR} function_generator
				else
					create function_generator
				end
				function_generator.generate (component, a_function)
				cpp_class_writer.add_function (function_generator.ccom_feature_writer, Public)
			end
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
end -- class WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR

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

