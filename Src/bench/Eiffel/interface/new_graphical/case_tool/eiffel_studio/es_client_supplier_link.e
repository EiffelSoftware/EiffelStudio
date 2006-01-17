indexing
	description: "[
				
				Object is a model for a client supplier link in Eiffel Studio.
				A ES_CLIENT_SUPPLIER_LINK can have more then one feature.
				`features' are all features in `client' that have `supplier' as
				supplier.
				
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLIENT_SUPPLIER_LINK

inherit
	EM_CLIENT_SUPPLIER_LINK
		redefine
			client,
			supplier
		end
		
	SHARED_WORKBENCH
		undefine
			default_create
		end
		
	ES_ITEM
		undefine
			default_create
		end
		
	FEATURE_NAME_EXTRACTOR
		undefine
			default_create
		end
	
	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		undefine
			default_create
		end

	REFACTORING_HELPER
		undefine
			default_create
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (a_client, a_supplier: ES_CLASS) is
			-- Create a ES_CLIENT_SUPPLIER_LINK connecting `a_client' with `a_supplier'.
		require
			a_client_not_void: a_client /= Void
			a_supplier_not_void: a_supplier /= Void
		do
			make_with_classes_and_name (a_client, a_supplier, "")
			create {ARRAYED_LIST [FEATURE_AS]} features.make (0)
			synchronize
			is_needed_on_diagram := True
		end
		
feature -- Access

	features: LIST [FEATURE_AS]
			-- Features in `client' having `supplier' as supplier.

	client: ES_CLASS
			-- Client of the link.
	
	supplier: ES_CLASS
			-- Supplier of the link.
		
feature -- Element change

	synchronize is
			-- Set `features', `name' and `is_aggregated' or remove if no `features'.
		local
			a_name: STRING
		do
			if client.is_queries_changed then
				features := client.suppliers_with_class (supplier)
				if features.is_empty then
					check
						features_is_not_empty_at_creation: graph /= Void
					end
					graph.remove_link (Current)
				else
					a_name := full_name (features.first)
					a_name.replace_substring_all ("[", "[ ")
					a_name.replace_substring_all (" " + supplier.class_i.name_in_upper, " ...")
					if a_name.substring (a_name.count - 4, a_name.count).is_equal (": ...") then
						a_name.replace_substring_all (": ...", "")
					end
					if features.count > 1 then
						a_name.append (", ...")
					end
					a_name.replace_substring_all ("[ ", "[")
					set_name (a_name)				
					is_aggregated := is_expanded (features.first)
				end
			end
			set_is_aggregated (is_aggregated or else supplier.is_expanded)
		end

feature {NONE} -- Implementation
		
	is_expanded (a_feature: FEATURE_AS): BOOLEAN is
			-- Is `a_feature' declared `expanded'?
		local
			ct: CLASS_TYPE_AS
			type_as_class: CLASS_I
		do
			ct ?= a_feature.body.type
			Result := ct /= Void and then ct.is_expanded
			if not Result and then ct /= Void then
				fixme ("Remove usage of `System.any_class' to search for ct's base class.")
				type_as_class := clickable_info.associated_eiffel_class (System.any_class, ct)
				if type_as_class /= Void and then type_as_class.is_compiled then
					Result := type_as_class.compiled_class.is_expanded
				end
			end
		end
		
invariant
	features_not_void: features /= Void
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ES_CLIENT_SUPPLIER_LINK
