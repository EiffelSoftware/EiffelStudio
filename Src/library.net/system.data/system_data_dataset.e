indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataSet"

external class
	SYSTEM_DATA_DATASET

inherit
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE
	SYSTEM_COMPONENTMODEL_MARSHALBYVALUECOMPONENT
		redefine
			set_site,
			get_site
		end
	SYSTEM_COMPONENTMODEL_ILISTSOURCE
		rename
			get_list as system_component_model_ilist_source_get_list,
			get_contains_list_collection as system_component_model_ilist_source_get_contains_list_collection
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_XML_SERIALIZATION_IXMLSERIALIZABLE
		rename
			write_xml as system_xml_serialization_ixml_serializable_write_xml,
			read_xml as system_xml_serialization_ixml_serializable_read_xml,
			get_schema as system_xml_serialization_ixml_serializable_get_schema
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	SYSTEM_ISERVICEPROVIDER
	SYSTEM_IDISPOSABLE

create
	make_dataset_1,
	make_dataset

feature {NONE} -- Initialization

	frozen make_dataset_1 (data_set_name: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataSet"
		end

	frozen make_dataset is
		external
			"IL creator use System.Data.DataSet"
		end

feature -- Access

	frozen get_locale: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Data.DataSet"
		alias
			"get_Locale"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"get_Namespace"
		end

	frozen get_extended_properties: SYSTEM_DATA_PROPERTYCOLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataSet"
		alias
			"get_ExtendedProperties"
		end

	frozen get_prefix: STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"get_Prefix"
		end

	frozen get_tables: SYSTEM_DATA_DATATABLECOLLECTION is
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

	frozen get_data_set_name: STRING is
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

	frozen get_relations: SYSTEM_DATA_DATARELATIONCOLLECTION is
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

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Data.DataSet"
		alias
			"get_Site"
		end

	frozen get_default_view_manager: SYSTEM_DATA_DATAVIEWMANAGER is
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

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Data.DataSet"
		alias
			"set_Site"
		end

	frozen set_data_set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"set_DataSetName"
		end

	frozen add_merge_failed (value: SYSTEM_DATA_MERGEFAILEDEVENTHANDLER) is
		external
			"IL signature (System.Data.MergeFailedEventHandler): System.Void use System.Data.DataSet"
		alias
			"add_MergeFailed"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"set_Namespace"
		end

	frozen set_prefix (value: STRING) is
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

	frozen set_locale (value: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Data.DataSet"
		alias
			"set_Locale"
		end

	frozen remove_merge_failed (value: SYSTEM_DATA_MERGEFAILEDEVENTHANDLER) is
		external
			"IL signature (System.Data.MergeFailedEventHandler): System.Void use System.Data.DataSet"
		alias
			"remove_MergeFailed"
		end

feature -- Basic Operations

	frozen infer_xml_schema (reader: SYSTEM_IO_TEXTREADER; ns_array: ARRAY [STRING]) is
		external
			"IL signature (System.IO.TextReader, System.String[]): System.Void use System.Data.DataSet"
		alias
			"InferXmlSchema"
		end

	frozen infer_xml_schema_stream (stream: SYSTEM_IO_STREAM; ns_array: ARRAY [STRING]) is
		external
			"IL signature (System.IO.Stream, System.String[]): System.Void use System.Data.DataSet"
		alias
			"InferXmlSchema"
		end

	frozen read_xml_string_xml_read_mode (file_name: STRING; mode: SYSTEM_DATA_XMLREADMODE): SYSTEM_DATA_XMLREADMODE is
		external
			"IL signature (System.String, System.Data.XmlReadMode): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen merge_data_set_boolean (data_set: SYSTEM_DATA_DATASET; preserve_changes: BOOLEAN) is
		external
			"IL signature (System.Data.DataSet, System.Boolean): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_string (file_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen read_xml_xml_reader_xml_read_mode (reader: SYSTEM_XML_XMLREADER; mode: SYSTEM_DATA_XMLREADMODE): SYSTEM_DATA_XMLREADMODE is
		external
			"IL signature (System.Xml.XmlReader, System.Data.XmlReadMode): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen read_xml_schema (reader: SYSTEM_IO_TEXTREADER) is
		external
			"IL signature (System.IO.TextReader): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen write_xml_text_writer_xml_write_mode (writer: SYSTEM_IO_TEXTWRITER; mode: SYSTEM_DATA_XMLWRITEMODE) is
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

	frozen merge (table: SYSTEM_DATA_DATATABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_schema (writer: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen read_xml_schema_string (file_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen read_xml_stream_xml_read_mode (stream: SYSTEM_IO_STREAM; mode: SYSTEM_DATA_XMLREADMODE): SYSTEM_DATA_XMLREADMODE is
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

	frozen clone: SYSTEM_DATA_DATASET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataSet"
		alias
			"Clone"
		end

	frozen has_changes_data_row_state (row_states: SYSTEM_DATA_DATAROWSTATE): BOOLEAN is
		external
			"IL signature (System.Data.DataRowState): System.Boolean use System.Data.DataSet"
		alias
			"HasChanges"
		end

	frozen get_changes_data_row_state (row_states: SYSTEM_DATA_DATAROWSTATE): SYSTEM_DATA_DATASET is
		external
			"IL signature (System.Data.DataRowState): System.Data.DataSet use System.Data.DataSet"
		alias
			"GetChanges"
		end

	frozen write_xml_schema_stream (stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen write_xml_schema_string (file_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen copy: SYSTEM_DATA_DATASET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataSet"
		alias
			"Copy"
		end

	frozen read_xml (reader: SYSTEM_IO_TEXTREADER): SYSTEM_DATA_XMLREADMODE is
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

	frozen merge_data_set_boolean_missing_schema_action (data_set: SYSTEM_DATA_DATASET; preserve_changes: BOOLEAN; missing_schema_action: SYSTEM_DATA_MISSINGSCHEMAACTION) is
		external
			"IL signature (System.Data.DataSet, System.Boolean, System.Data.MissingSchemaAction): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_schema_text_writer (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXmlSchema"
		end

	frozen merge_data_table_boolean_missing_schema_action (table: SYSTEM_DATA_DATATABLE; preserve_changes: BOOLEAN; missing_schema_action: SYSTEM_DATA_MISSINGSCHEMAACTION) is
		external
			"IL signature (System.Data.DataTable, System.Boolean, System.Data.MissingSchemaAction): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen read_xml_string (file_name: STRING): SYSTEM_DATA_XMLREADMODE is
		external
			"IL signature (System.String): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen read_xml_xml_reader (reader: SYSTEM_XML_XMLREADER): SYSTEM_DATA_XMLREADMODE is
		external
			"IL signature (System.Xml.XmlReader): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen write_xml_stream_xml_write_mode (stream: SYSTEM_IO_STREAM; mode: SYSTEM_DATA_XMLWRITEMODE) is
		external
			"IL signature (System.IO.Stream, System.Data.XmlWriteMode): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen infer_xml_schema_xml_reader (reader: SYSTEM_XML_XMLREADER; ns_array: ARRAY [STRING]) is
		external
			"IL signature (System.Xml.XmlReader, System.String[]): System.Void use System.Data.DataSet"
		alias
			"InferXmlSchema"
		end

	frozen write_xml_text_writer (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen get_xml: STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"GetXml"
		end

	frozen read_xml_schema_stream (stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen read_xml_stream (stream: SYSTEM_IO_STREAM): SYSTEM_DATA_XMLREADMODE is
		external
			"IL signature (System.IO.Stream): System.Data.XmlReadMode use System.Data.DataSet"
		alias
			"ReadXml"
		end

	frozen read_xml_text_reader_xml_read_mode (reader: SYSTEM_IO_TEXTREADER; mode: SYSTEM_DATA_XMLREADMODE): SYSTEM_DATA_XMLREADMODE is
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

	frozen get_changes: SYSTEM_DATA_DATASET is
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

	frozen write_xml_string_xml_write_mode (file_name: STRING; mode: SYSTEM_DATA_XMLWRITEMODE) is
		external
			"IL signature (System.String, System.Data.XmlWriteMode): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen merge_array_data_row (rows: ARRAY [SYSTEM_DATA_DATAROW]) is
		external
			"IL signature (System.Data.DataRow[]): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml (writer: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen merge_data_set (data_set: SYSTEM_DATA_DATASET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen read_xml_schema_xml_reader (reader: SYSTEM_XML_XMLREADER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSchema"
		end

	frozen write_xml_stream (stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

	frozen infer_xml_schema_string (file_name: STRING; ns_array: ARRAY [STRING]) is
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

	frozen get_xml_schema: STRING is
		external
			"IL signature (): System.String use System.Data.DataSet"
		alias
			"GetXmlSchema"
		end

	frozen merge_array_data_row_boolean_missing_schema_action (rows: ARRAY [SYSTEM_DATA_DATAROW]; preserve_changes: BOOLEAN; missing_schema_action: SYSTEM_DATA_MISSINGSCHEMAACTION) is
		external
			"IL signature (System.Data.DataRow[], System.Boolean, System.Data.MissingSchemaAction): System.Void use System.Data.DataSet"
		alias
			"Merge"
		end

	frozen write_xml_xml_writer_xml_write_mode (writer: SYSTEM_XML_XMLWRITER; mode: SYSTEM_DATA_XMLWRITEMODE) is
		external
			"IL signature (System.Xml.XmlWriter, System.Data.XmlWriteMode): System.Void use System.Data.DataSet"
		alias
			"WriteXml"
		end

feature {NONE} -- Implementation

	on_property_changing (pcevent: SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS) is
		external
			"IL signature (System.ComponentModel.PropertyChangedEventArgs): System.Void use System.Data.DataSet"
		alias
			"OnPropertyChanging"
		end

	frozen system_runtime_serialization_iserializable_get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.DataSet"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	on_remove_table (table: SYSTEM_DATA_DATATABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataSet"
		alias
			"OnRemoveTable"
		end

	frozen system_component_model_ilist_source_get_contains_list_collection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"System.ComponentModel.IListSource.get_ContainsListCollection"
		end

	on_remove_relation (relation: SYSTEM_DATA_DATARELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataSet"
		alias
			"OnRemoveRelation"
		end

	has_schema_changed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"HasSchemaChanged"
		end

	frozen raise_property_changing (name: STRING) is
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

	frozen get_serialization_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.DataSet"
		alias
			"GetSerializationData"
		end

	frozen system_xml_serialization_ixml_serializable_get_schema: SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL signature (): System.Xml.Schema.XmlSchema use System.Data.DataSet"
		alias
			"System.Xml.Serialization.IXmlSerializable.GetSchema"
		end

	frozen system_component_model_ilist_source_get_list: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Data.DataSet"
		alias
			"System.ComponentModel.IListSource.GetList"
		end

	get_schema_serializable: SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL signature (): System.Xml.Schema.XmlSchema use System.Data.DataSet"
		alias
			"GetSchemaSerializable"
		end

	frozen system_xml_serialization_ixml_serializable_read_xml (reader: SYSTEM_XML_XMLREADER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Data.DataSet"
		alias
			"System.Xml.Serialization.IXmlSerializable.ReadXml"
		end

	frozen system_xml_serialization_ixml_serializable_write_xml (writer: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Data.DataSet"
		alias
			"System.Xml.Serialization.IXmlSerializable.WriteXml"
		end

	should_serialize_relations: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataSet"
		alias
			"ShouldSerializeRelations"
		end

	read_xml_serializable (reader: SYSTEM_XML_XMLREADER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Data.DataSet"
		alias
			"ReadXmlSerializable"
		end

end -- class SYSTEM_DATA_DATASET
