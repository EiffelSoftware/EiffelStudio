indexing
	description: "Representation of an export clause"
	external_name: "ISE.Reflection.ExportClause"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	EXPORT_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 		redefine
 			is_equal
 		end
 
create
 	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `feature_names'."
			external_name: "Make"
		do
			create feature_names.make
		ensure 
			non_void_feature_names: feature_names /= Void
		end
		
feature -- Access

	feature_names: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "List of exported features names"
			external_name: "FeatureNames"
		end
		
	exportation_list: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "List of classes `source_name' is exported to"
			external_name: "ExportationList"
		end

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
			external_name: "EiffelKeyword"
		do
			Result := Export_keyword
		end

	Export_keyword: STRING is "export"
		indexing
			description: "Export keyword"
			external_name: "ExportKeyword"
		end
		
	Opening_curl_bracket: STRING is "{"
		indexing
			description: "Opening curl bracket"
			external_name: "OpeningCurlBracket"
		end

	Closing_curl_bracket: STRING is "}"
		indexing
			description: "Closing curl bracket"
			external_name: "ClosingCurlBracket"
		end

	Comma: STRING is ","
		indexing
			description: "Comma"
			external_name: "Comma"
		end

	Space: STRING is " "
		indexing
			description: "Space"
			external_name: "Space"
		end

	Empty_string: STRING is ""
		indexing
			description: "Empty string"
			external_name: "EmptyString"
		end
	
	All_keyword: STRING is "all"
		indexing
			description: "all keyword"
			external_name: "AllKeyword"
		end
		
feature -- Status Report

	all_features_exported: BOOLEAN
		indexing
			description: "Are all features from parent exported?"
			external_name: "AllFeaturesExported"
		end

	is_equal (obj: EXPORT_CLAUSE): BOOLEAN is
		indexing
			description: "Is Current equals to `obj'?"
			external_name: "Equals"			
		do
			if exportation_list /= Void and obj.exportation_list = Void then
				Result := False
			elseif exportation_list /= Void and obj.exportation_list /= Void then
				Result := exportation_list.is_equal (obj.exportation_list) and feature_names.is_equal (obj.feature_names) and (all_features_exported = obj.all_features_exported)
			elseif exportation_list = Void and obj.exportation_list = Void then
				Result := feature_names.is_equal (obj.feature_names) and (all_features_exported = obj.all_features_exported)
			end
		end
	
feature -- Status Setting

	set_feature_names (a_list: like feature_names) is
		indexing
			description: "Set `feature_names' with `a_list'."
			external_name: "SetFeatureNames"
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.get_count > 0
		do
			feature_names := a_list
		ensure
			feature_names_set: feature_names = a_list
		end
		
	set_exportation_list (a_list: like exportation_list) is
		indexing
			description: "Set `exportation_list' with `a_list'."
			external_name: "SetExportationList"
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.get_count > 0
		do
			exportation_list := a_list
		ensure
			exportation_list_set: exportation_list = a_list
		end
 
 	set_all is
 		indexing
 			description: "Set `all_features_exported' with `True'."
 			external_name: "SetAll"
 		require
 			no_feature_name: feature_names.get_count = 0
 		do
 			all_features_exported := True
 		ensure
 			all_features_exported: all_features_exported
 		end
 		
feature -- Basic Operations

	add_feature_name (a_feature_name: STRING) is
		indexing
			description: "Add `a_feature_name' to `feature_names'."
			external_name: "AddFeatureName"
		require
			not_all: not all_features_exported
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.get_length > 0
		local
			added: INTEGER
		do
			if not feature_names.has (a_feature_name) then
				added := feature_names.extend (a_feature_name)
			end
		ensure
			feature_name_added: feature_names.has (a_feature_name)
		end
		
	add_exportation (a_class_name: STRING) is
		indexing
			description: "Add `a_class_name' to `exportation_list'."
			external_name: "AddExportation"
		require
			non_void_class_name: a_class_name /= Void
			not_empty_class_name: a_class_name.get_length > 0
		local
			added: INTEGER
		do
			if exportation_list = Void then
				create exportation_list.make
			end
			if not exportation_list.has (a_class_name) then
				added := exportation_list.extend (a_class_name)
			end
		ensure
			exportation_added: exportation_list.has (a_class_name)
		end
		
	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
			external_name: "StringRepresentation"
		local
			i: INTEGER
			a_class_name: STRING			
		do
			if exportation_list /= Void and then exportation_list.get_count > 0 then
				Result := Opening_curl_bracket
				from
				until
					i = exportation_list.get_count
				loop
					a_class_name ?= exportation_list.get_item (i)
					if a_class_name /= Void and then a_class_name.get_length > 0 then
						Result := Result.concat_string_string (Result, a_class_name)
						if i < exportation_list.get_count - 1 then
							Result := Result.concat_string_string_string (Result, Comma, Space)
						end
					end
					i := i + 1
				end
				Result := Result.concat_string_string_string_string (Result, Closing_curl_bracket, Space, intern_string_representation)
			else
				Result := Result.concat_string_string (Result, intern_string_representation)
			end
		end

feature {NONE} -- Implementation

	intern_string_representation: STRING is
		indexing
			description: "String representation of `feature_names'"
			external_name: "InternStringRepresentation"
		require
			non_void_feature_names: feature_names /= Void
		local
			i: INTEGER
			a_feature_name: STRING
		do			
			if feature_names.get_count > 0 then
				from	
					Result := Empty_string
					i := 0
				until 
					i = feature_names.get_count
				loop
					a_feature_name ?= feature_names.get_item (i)
					if a_feature_name /= Void and then a_feature_name.get_length > 0 then
						Result := Result.concat_string_string (Result, a_feature_name)
						if i < feature_names.get_count - 1 then
							Result := Result.concat_string_string_string (Result, Comma, Space)
						end
					end
					i := i + 1
				end	
			else
				Result := All_keyword
			end
		ensure
			non_void_result: Result /= Void
		end
	
invariant
	non_void_feature_names: feature_names /= Void
	
end -- class EXPORT_CLAUSE
 
