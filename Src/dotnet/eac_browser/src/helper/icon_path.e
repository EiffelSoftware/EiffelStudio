indexing
	description: "Path to access icon"
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	ICON_PATH

create
	default_create

feature -- Implementation

	Path_icon_eac: STRING is
			-- Path of eac icon.
		once
			Result := Eiffel_path + eac_resource + "icon_eac.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_assembly: STRING is
			-- Path of assembly icon.
		once
			Result := Eiffel_path + eac_resource + "icon_assembly.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_namespace: STRING is
			-- Path of namespace icon.
		once
			Result := Eiffel_path + eac_resource + "icon_namespace.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_class: STRING is
			-- Path of class icon.
		once
			Result := Eiffel_path + eac_resource + "icon_class.ico"
		ensure
			non_void_result: Result /= Void
		end
		
	Path_icon_interface_class: STRING is
			-- Path of interface class icon.
		once
			Result := Eiffel_path + eac_resource + "icon_interface_class.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_delegate_class: STRING is
			-- Path of delegate class icon.
		once
			Result := Eiffel_path + eac_resource + "icon_delegate_class.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_enum_class: STRING is
			-- Path of enum class icon.
		once
			Result := Eiffel_path + eac_resource + "icon_enum_class.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_value_type_class: STRING is
			-- Path of value type class icon.
		once
			Result := Eiffel_path + eac_resource + "icon_value_type_class.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_constructor: STRING is
			-- Path of constructor icon.
		once
			Result := Eiffel_path + eac_resource + "icon_constructor.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_inherited_features: STRING is
			-- Path of inherited features icon.
		once
			Result := Eiffel_path + eac_resource + "icon_inherited_features.ico"
		ensure
			non_void_result: Result /= Void
		end

feature -- Eiffel Icon

	Path_eiffel_feature: STRING is
			-- Path of eiffel feature icon.
		once
			Result := Eiffel_path + eac_resource + "icon_eiffel_feature.ico"
		ensure
			non_void_result: Result /= Void
		end
		

feature -- Public Icons

	Path_icon_public_attribute: STRING is
			-- Path of attribute icon.
		once
			Result := Eiffel_path + eac_resource + "icon_public_attribute.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_public_procedure: STRING is
			-- Path of procedure icon.
		once
			Result := Eiffel_path + eac_resource + "icon_public_feature.ico"
		ensure
			non_void_result: Result /= Void
		end
			
	Path_icon_public_function: STRING is
			-- Path of function icon.
		once
			Result := Eiffel_path + eac_resource + "icon_public_feature.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_public_property: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_public_property.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_public_constant: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_public_constant.ico"
		ensure
			non_void_result: Result /= Void
		end
			
	Path_icon_public_event: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_public_event.ico"
		ensure
			non_void_result: Result /= Void
		end

feature -- Private Icons

	Path_icon_private_attribute: STRING is
			-- Path of attribute icon.
		once
			Result := Eiffel_path + eac_resource + "icon_private_attribute.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_private_procedure: STRING is
			-- Path of procedure icon.
		once
			Result := Eiffel_path + eac_resource + "icon_private_feature.ico"
		ensure
			non_void_result: Result /= Void
		end
			
	Path_icon_private_function: STRING is
			-- Path of function icon.
		once
			Result := Eiffel_path + eac_resource + "icon_private_feature.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_private_property: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_private_property.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_private_constant: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_private_constant.ico"
		ensure
			non_void_result: Result /= Void
		end
			
	Path_icon_private_event: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_private_event.ico"
		ensure
			non_void_result: Result /= Void
		end

feature -- Protected Icons

	Path_icon_protected_attribute: STRING is
			-- Path of attribute icon.
		once
			Result := Eiffel_path + eac_resource + "icon_protected_attribute.ico"
		ensure
			non_void_result: Result /= Void
		end
		
	Path_icon_protected_procedure: STRING is
			-- Path of procedure icon.
		once
			Result := Eiffel_path + eac_resource + "icon_protected_feature.ico"
		ensure
			non_void_result: Result /= Void
		end
			
	Path_icon_protected_function: STRING is
			-- Path of function icon.
		once
			Result := Eiffel_path + eac_resource + "icon_protected_feature.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_protected_property: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_protected_property.ico"
		ensure
			non_void_result: Result /= Void
		end

	Path_icon_protected_constant: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_protected_constant.ico"
		ensure
			non_void_result: Result /= Void
		end
			
	Path_icon_protected_event: STRING is
			-- Path of property icon.
		once
			Result := Eiffel_path + eac_resource + "icon_protected_event.ico"
		ensure
			non_void_result: Result /= Void
		end

		
feature {NONE} -- Implementation

	load_icon (a_path: STRING): EV_PIXMAP is
			-- load icon from `a_path'.
		require
			non_void_a_path: a_path /= Void
			not_empty_a_path: not a_path.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				create Result
				Result.set_with_named_file (a_path)
			else
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	eac_resource: STRING is "studio\spec\windows\bin\eac_ico\"
			-- path to access eac resource under Eiffel.

	Ise_eiffel_key: STRING is "ISE_EIFFEL"
			-- Environment variable $ISE_EIFFEL.

	Eiffel_path: STRING is
			-- Path to Eiffel installation.
		local   
			retried: BOOLEAN
--			l_str: SYSTEM_STRING
--			l_registry_key: REGISTRY_KEY   
--			l_obj: SYSTEM_OBJECT
		once
			if not retried then   
				Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_eiffel_key)
--				if Result = Void then   
--					l_registry_key := feature {REGISTRY}.local_machine   
--					l_registry_key := l_registry_key.open_sub_key (("SOFTWARE").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("ISE").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("Eiffel52").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("emitter").to_cil)   
--					l_obj := l_registry_key.get_value (Ise_eiffel_key.to_cil)   
--					l_str ?= l_obj   
--
--					if l_str /= Void then   
--					 create Result.make_from_cil (l_str)   
--					end   
--				end 

				check
					Ise_eiffel_defined: Result /= Void
				end
				if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
					Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				end
			else   
				-- FIXME: Manu 05/14/2002: we should raise an error here.   
				io.error.put_string ("ISE_EIFFEL environment variable is not defined!%N")   
			end 
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator 
		rescue   
			retried := True   
			retry   
		end
		

end -- ICON_PATH