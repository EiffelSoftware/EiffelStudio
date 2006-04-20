indexing
	description: "Component Eiffel generator for server"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_GENERATOR 

	WIZARD_VARIABLE_NAME_MAPPER
	
	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end


feature {NONE} -- Implementation

	make_feature: WIZARD_WRITER_FEATURE is
			-- `make' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (Make_word)
			Result.set_comment ("Creation. Implement if needed.")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	make_from_pointer_feature:  WIZARD_WRITER_FEATURE is
			-- `make_from_pointer' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name ("make_from_pointer")
			Result.set_comment ("Creation.")

			Result.add_argument ("cpp_obj: POINTER")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)
			feature_body.append ("set_item (cpp_obj)")

			feature_body.append (New_line_tab_tab_tab)
			feature_body.append (make_word)

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	create_item_feature: WIZARD_WRITER_FEATURE is
			-- `create_item' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name ("create_item")
			Result.set_comment ("Initialize %Qitem%'")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)
			feature_body.append ("item := ccom_create_item (Current)")

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
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
end -- class WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

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

