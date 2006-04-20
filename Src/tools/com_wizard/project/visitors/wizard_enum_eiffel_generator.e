indexing
	description: "Eiffel enumeration generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_ENUM_EIFFEL_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

feature -- Access

	generate (a_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- Generate eiffel client for enum.
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		local
			writer_feature: WIZARD_WRITER_FEATURE
			enum_element_descriptor: WIZARD_ENUM_ELEMENT_DESCRIPTOR
		do
			create eiffel_writer.make
			eiffel_writer.set_class_name (a_descriptor.eiffel_class_name)
			eiffel_writer.set_description (a_descriptor.description)
			eiffel_writer.set_effective

			from
				a_descriptor.elements.start
			until
				a_descriptor.elements.after
			loop
				enum_element_descriptor := a_descriptor.elements.item
				create writer_feature.make_constant (enum_element_descriptor.value, 
					enum_element_descriptor.name, enum_element_descriptor.description)

				eiffel_writer.add_feature (writer_feature, Access)
				a_descriptor.elements.forth
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
end -- class WIZARD_ENUM_EIFFEL_GENERATOR

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

