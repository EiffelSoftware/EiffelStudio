indexing
	description: "Representation of an export clause"
	external_name: "ISE.Reflection.ExportClause"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	EXPORT_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 
create
 	make
 
feature -- Access

	exportation_list: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "List of classes `source_name' is exported to"
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
		
feature -- Status Setting

	set_exportation_list (a_list: like exportation_list) is
		indexing
			description: "Set `exportation_list' with `a_list'."
			external_name: "SetExportationList"
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.count > 0
		do
			exportation_list := a_list
		ensure
			exportation_list_set: exportation_list = a_list
		end
 
feature -- Basic Operations

	add_exportation (a_class_name: STRING) is
		indexing
			description: "Add `a_class_name' to `exportation_list'."
			external_name: "AddExportation"
		require
			non_void_class_name: a_class_name /= Void
			not_empty_class_name: a_class_name.length > 0
		local
			added: INTEGER
		do
			if exportation_list = Void then
				create exportation_list.make
			end
			added := exportation_list.add (a_class_name)
		ensure
			exportation_added: exportation_list.contains (a_class_name)
		end
		
	to_string: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
			external_name: "ToString"
		local
			i: INTEGER
			a_class_name: STRING			
		do
			if exportation_list /= Void and then exportation_list.count > 0 then
				Result := Opening_curl_bracket
				from
				until
					i = exportation_list.count
				loop
					a_class_name ?= exportation_list.item (i)
					if a_class_name /= Void and then a_class_name.length > 0 then
						Result := Result.concat_string_string (Result, a_class_name)
						if i < exportation_list.count - 1 then
							Result := Result.concat_string_string_string (Result, Comma, Space)
						end
					end
					i := i + 1
				end
				Result := Result.concat_string_string_string_string (Result, Closing_curl_bracket, Space, source_name)
			else
				Result := source_name
			end
		end
	
 end -- class EXPORT_CLAUSE
 