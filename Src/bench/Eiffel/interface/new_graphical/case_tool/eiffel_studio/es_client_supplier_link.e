indexing
	description: "[
				
				Object is a model for a client supplier link in Eiffel Studio.
				A ES_CLIENT_SUPPLIER_LINK can have more then one feature.
				`features' are all features in `client' that have `supplier' as
				supplier.
				
					]"
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
			bt: BASIC_TYPE
			ct: CLASS_TYPE_AS
			type_as_class: CLASS_I
			l_body: BODY_AS
		do
			l_body := a_feature.body
			if l_body /= Void then
				bt ?= l_body.type
				ct ?= l_body.type
			end
			Result := (bt /= Void) or (ct /= Void and then ct.is_expanded)
			if not Result and then ct /= Void then
				fixme ("Remove usage of `System.any_class' to search for ct's base class.")
				type_as_class := ct.associated_eiffel_class (System.any_class)
				if type_as_class /= Void and then type_as_class.is_compiled then
					Result := type_as_class.compiled_class.is_expanded
				end
			end
		end
		
invariant
	features_not_void: features /= Void
		
end -- class ES_CLIENT_SUPPLIER_LINK
