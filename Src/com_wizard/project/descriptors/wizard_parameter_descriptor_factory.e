indexing
	description: "Factory of Parameter Descriptors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PARAMETER_DESCRIPTOR_FACTORY

inherit
	WIZARD_DESCRIPTOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_FORBIDDEN_NAMES
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_name: STRING; a_type_info: ECOM_TYPE_INFO;
				an_elem_desc: ECOM_ELEM_DESC; 
				a_system_descriptor: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_PARAM_DESCRIPTOR is
			-- Initialize
		require
			valid_name: a_name /= Void and then a_name.count /= 0
			valid_type_info: a_type_info /= Void
			valid_elem_desc: an_elem_desc /= Void
			valid_system_descriptor: a_system_descriptor /= Void
		local
			l_string: STRING
			l_value: ECOM_PARAM_DESCEX
			l_variant: ECOM_VARIANT
		do
			name := a_name.twin
			if is_forbidden_c_word (name)  then
				name.prepend ("a_")
			end
			l_string := name.as_lower
			if Eiffel_keywords.has (l_string) then
				name.prepend ("a_")
			end
			type := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, an_elem_desc.type_desc, a_system_descriptor)
			flags := an_elem_desc.param_desc.flags
			if has_fopt_and_fhasdefault (flags) then
				l_value := an_elem_desc.param_desc.default_value
				if l_value /= Void then
					l_variant := l_value.default_value
					if l_variant /= Void then
						default_value := l_variant.out
					end
				end
			end
			create Result.make (Current)
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_type: type /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_PARAM_DESCRIPTOR) is
			-- Initialize `a_descriptor' arguments.
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_type (type)
			a_descriptor.set_flags (flags)
			a_descriptor.set_description (description)
		end

feature {NONE} -- Implementation

	name: STRING
			-- Argument name

	default_value: STRING
			-- Default value.

	description: STRING is
			-- Type description
		do
			create Result.make (0)
			if has_fopt_and_fhasdefault (flags) then
				Result.append ("Optional, default value = ")
				Result.append (default_value)
				Result.append (".")
			end
		end

	type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Argument type

	flags: INTEGER;
			-- Argument flags
			-- See class ECOM_PARAM_FLAGS for values

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
end -- class WIZARD_PARAMETER_DESCRIPTOR_FACTORY

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

