indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataSet"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_SET

inherit
	SYSTEM_DLL_MARSHAL_BY_VALUE_COMPONENT
		redefine
			set_site,
			get_site
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ISERVICE_PROVIDER
	SYSTEM_DLL_ILIST_SOURCE
		rename
			get_list as system_component_model_ilist_source_get_list,
			get_contains_list_collection as system_component_model_ilist_source_get_contains_list_collection
		end
	SYSTEM_XML_IXML_SERIALIZABLE
		rename
			write_xml as system_xml_serialization_ixml_serializable_write_xml,
			read_xml as system_xml_serialization_ixml_serializable_read_xml,
			get_schema as system_xml_serialization_ixml_serializable_get_schema
		end
	SYSTEM_DLL_ISUPPORT_INITIALIZE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_data_data_set,
	make_data_data_set_1

feature {NONE} -- Initialization

	frozen make_data_data_set is
		external
			"IL creator use System.Data.DataSet"
		end

	frozen make_data_data_set_1 (data_set_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataSet"
		end

feature -- Access

	frozen get_locale: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Data.DataSet"
		alias
			"get_Locale"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"get_Namespace"
		end

	frozen get_extended_properties: DATA_PROPERTY_COLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataSet"
		alias
			"get_ExtendedProperties"
		end

	frozen get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"get_Prefix"
		end

	frozen get_tables: DATA_DATA_TABLE_COLLECTION is
		external
			"IL signature (): System.Data.DataTableCollection use System.Data.DataSet"
		alias
			"get_Tables"
		end

	frozen get_case_sensitive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"get_CaseSensitive"
		end

	frozen get_data_set_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"get_DataSetName"
		end

	frozen get_enforce_constraints: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"get_EnforceConstraints"
		end

	frozen get_relations: DATA_DATA_RELATION_COLLECTION is
		external
			"IL signature (): System.Data.DataRelationCollection use System.Data.DataSet"
		alias
			"get_Relations"
		end

	frozen get_has_errors: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"get_HasErrors"
		end

	get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Data.DataSet"
		alias
			"get_Site"
		end

	frozen get_default_view_manager: DATA_DATA_VIEW_MANAGER is
		external
			"IL signature (): System.Data.DataViewManager use System.Data.DataSet"
		alias
			"get_DefaultViewManager"
		end

feature -- Element Change

	frozen set_enforce_constraints (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataSet"
		alias
			"set_EnforceConstraints"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Data.DataSet"
		alias
			"set_Site"
		end

	frozen set_data_set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"set_DataSetName"
		end

	frozen add_merge_failed (value: DATA_MERGE_FAILED_EVENT_HANDLER) is
		external
			"IL signature (System.Data.MergeFailedEventHandler): System.Void use System.Data.DataSet"
		alias
			"add_MergeFailed"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"set_Namespace"
		end

	frozen set_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"set_Prefix"
		end

	frozen set_case_sensitive (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataSet"
		alias
			"set_CaseSensitive"
		end

	frozen set_locale (value: CULTURE_INFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Data.DataSet"
		alias
			"set_Locale"
		end

	frozen remove_merge_failed (value: DATA_MERGE_FAILED_EVENT_HANDLER) is
		external
			"IL signature (System.Data.MergeFailedEventHandler): System.Void use System.Data.DataSet"
		alias
			"remove_MergeFailed"
		end

feature -- Basic Operations

	frozen infer_xml_schema (reader: TEXT_READER; ns_array: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.IO.TextReader, System.String[]): System.Void use System.Data.DataSet"
		alias
			"InferXmlSchema"
		end

	frozen infer_xml_schema_stream (stream: SYSTEM_STREAM; ns_array: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.IO.Stream, System.String[]): System.Void use System.Data.DataSet"
		alias
			"InferXmlSchema"
		end

	frozen read_xml_string_xml_read_mode (file_name: SYSTEM_STRING; mode: DATA_XML_READ_MODE): DATA_XML_READ_MODE is
		external
			"IL signature (System.String, System.Data.XmlReadMode): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen merge_data_set_boolean (data_set: DATA_DATA_SET; preserve_changes: BOOLEAN) is
		external
			"IL signature (System.Data.DataSet, System.Boolean): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_string (file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen read_xml_xml_reader_xml_read_mode (reader: SYSTEM_XML_XML_READER; mode: DATA_XML_READ_MODE): DATA_XML_READ_MODE is
		external
			"IL signature (System.Xml.XmlReader, System.Data.XmlReadMode): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen read_xml_schema (reader: TEXT_READER) is
		external
			"IL signature (System.IO.TextReader): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen write_xml_text_writer_xml_write_mode (writer: TEXT_WRITER; mode: DATA_XML_WRITE_MODE) is
		external
			"IL signature (System.IO.TextWriter, System.Data.XmlWriteMode): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	reset is
		external
			"IL signature (): System.Void use System.Data.DataSet"
		alias
			"Reset"
		end

	frozen merge (table: DATA_DATA_TABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_schema (writer: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen write_xml (writer: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen read_xml_schema_string (file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen read_xml_stream_xml_read_mode (stream: SYSTEM_STREAM; mode: DATA_XML_READ_MODE): DATA_XML_READ_MODE is
		external
			"IL signature (System.IO.Stream, System.Data.XmlReadMode): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	reject_changes is
		external
			"IL signature (): System.Void use System.Data.DataSet"
		alias
			"RejectChanges"
		end

	frozen has_changes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"HasChanges"
		end

	frozen write_xml_xml_writer_xml_write_mode (writer: SYSTEM_XML_XML_WRITER; mode: DATA_XML_WRITE_MODE) is
		external
			"IL signature (System.Xml.XmlWriter, System.Data.XmlWriteMode): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen has_changes_data_row_state (row_states: DATA_DATA_ROW_STATE): BOOLEAN is
		external
			"IL signature (System.Data.DataRowState): System.Boolean use System.Data.DataSet"
		alias
			"HasChanges"
		end

	frozen get_changes_data_row_state (row_states: DATA_DATA_ROW_STATE): DATA_DATA_SET is
		external
			"IL signature (System.Data.DataRowState): System.Data.DataSet use System.Data.DataSet"
		alias
			"GetChanges"
		end

	frozen write_xml_schema_stream (stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen write_xml_schema_string (file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen read_xml (reader: TEXT_READER): DATA_XML_READ_MODE is
		external
			"IL signature (System.IO.TextReader): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.DataSet"
		alias
			"Clear"
		end

	frozen merge_data_set_boolean_missing_schema_action (data_set: DATA_DATA_SET; preserve_changes: BOOLEAN; missing_schema_action: DATA_MISSING_SCHEMA_ACTION) is
		external
			"IL signature (System.Data.DataSet, System.Boolean, System.Data.MissingSchemaAction): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_schema_text_writer (writer: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen merge_data_table_boolean_missing_schema_action (table: DATA_DATA_TABLE; preserve_changes: BOOLEAN; missing_schema_action: DATA_MISSING_SCHEMA_ACTION) is
		external
			"IL signature (System.Data.DataTable, System.Boolean, System.Data.MissingSchemaAction): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen read_xml_string (file_name: SYSTEM_STRING): DATA_XML_READ_MODE is
		external
			"IL signature (System.String): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen read_xml_xml_reader (reader: SYSTEM_XML_XML_READER): DATA_XML_READ_MODE is
		external
			"IL signature (System.Xml.XmlReader): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen write_xml_stream_xml_write_mode (stream: SYSTEM_STREAM; mode: DATA_XML_WRITE_MODE) is
		external
			"IL signature (System.IO.Stream, System.Data.XmlWriteMode): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen infer_xml_schema_xml_reader (reader: SYSTEM_XML_XML_READER; ns_array: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.Xml.XmlReader, System.String[]): System.Void use System.Data.DataSet"
		alias
			"InferXmlSchema"
		end

	frozen write_xml_text_writer (writer: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen get_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"GetXml"
		end

	frozen read_xml_schema_stream (stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen read_xml_stream (stream: SYSTEM_STREAM): DATA_XML_READ_MODE is
		external
			"IL signature (System.IO.Stream): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen read_xml_text_reader_xml_read_mode (reader: TEXT_READER; mode: DATA_XML_READ_MODE): DATA_XML_READ_MODE is
		external
			"IL signature (System.IO.TextReader, System.Data.XmlReadMode): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Data.DataSet"
		alias
			"BeginInit"
		end

	frozen get_changes: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataSet"
		alias
			"GetChanges"
		end

	frozen end_init is
		external
			"IL signature (): System.Void use System.Data.DataSet"
		alias
			"EndInit"
		end

	frozen write_xml_string_xml_write_mode (file_name: SYSTEM_STRING; mode: DATA_XML_WRITE_MODE) is
		external
			"IL signature (System.String, System.Data.XmlWriteMode): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen merge_array_data_row (rows: NATIVE_ARRAY [DATA_DATA_ROW]) is
		external
			"IL signature (System.Data.DataRow[]): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	clone_: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataSet"
		alias
			"Clone"
		end

	frozen merge_data_set (data_set: DATA_DATA_SET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen read_xml_schema_xml_reader (reader: SYSTEM_XML_XML_READER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen copy_: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataSet"
		alias
			"Copy"
		end

	frozen infer_xml_schema_string (file_name: SYSTEM_STRING; ns_array: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String, System.String[]): System.Void use System.Data.DataSet"
		alias
			"InferXmlSchema"
		end

	frozen accept_changes is
		external
			"IL signature (): System.Void use System.Data.DataSet"
		alias
			"AcceptChanges"
		end

	frozen get_xml_schema: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"GetXmlSchema"
		end

	frozen merge_array_data_row_boolean_missing_schema_action (rows: NATIVE_ARRAY [DATA_DATA_ROW]; preserve_changes: BOOLEAN; missing_schema_action: DATA_MISSING_SCHEMA_ACTION) is
		external
			"IL signature (System.Data.DataRow[], System.Boolean, System.Data.MissingSchemaAction): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_stream (stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

feature {NONE} -- Implementation

	on_property_changing (pcevent: SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.PropertyChangedEventArgs): System.Void use System.Data.DataSet"
		alias
			"OnPropertyChanging"
		end

	frozen system_runtime_serialization_iserializable_get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.DataSet"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	on_remove_table (table: DATA_DATA_TABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataSet"
		alias
			"OnRemoveTable"
		end

	on_remove_relation (relation: DATA_DATA_RELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataSet"
		alias
			"OnRemoveRelation"
		end

	should_serialize_relations: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"ShouldSerializeRelations"
		end

	frozen raise_property_changing (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"RaisePropertyChanging"
		end

	should_serialize_tables: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"ShouldSerializeTables"
		end

	frozen get_serialization_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.DataSet"
		alias
			"GetSerializationData"
		end

	frozen system_xml_serialization_ixml_serializable_get_schema: SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (): System.Xml.Schema.XmlSchema use System.Data.DataSet"
		alias
			"System.Xml.Serialization.IXmlSerializable.GetSchema"
		end

	frozen system_component_model_ilist_source_get_contains_list_collection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"System.ComponentModel.IListSource.get_ContainsListCollection"
		end

	get_schema_serializable: SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (): System.Xml.Schema.XmlSchema use System.Data.DataSet"
		alias
			"GetSchemaSerializable"
		end

	frozen system_xml_serialization_ixml_serializable_read_xml (reader: SYSTEM_XML_XML_READER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Data.DataSet"
		alias
			"System.Xml.Serialization.IXmlSerializable.ReadXml"
		end

	frozen system_xml_serialization_ixml_serializable_write_xml (writer: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Data.DataSet"
		alias
			"System.Xml.Serialization.IXmlSerializable.WriteXml"
		end

	frozen system_component_model_ilist_source_get_list: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Data.DataSet"
		alias
			"System.ComponentModel.IListSource.GetList"
		end

	read_xml_serializable (reader: SYSTEM_XML_XML_READER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSerializable"
		end

end -- class DATA_DATA_SET
