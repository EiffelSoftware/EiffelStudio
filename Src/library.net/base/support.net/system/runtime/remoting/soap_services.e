indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.SoapServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SOAP_SERVICES

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_xml_ns_for_clr_type_with_ns: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrTypeWithNs"
		end

	frozen get_xml_ns_for_clr_type: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrType"
		end

	frozen get_xml_ns_for_clr_type_with_assembly: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrTypeWithAssembly"
		end

	frozen get_xml_ns_for_clr_type_with_ns_and_assembly: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrTypeWithNsAndAssembly"
		end

feature -- Basic Operations

	frozen get_type_and_method_name_from_soap_action (soap_action: SYSTEM_STRING; type_name: SYSTEM_STRING; method_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetTypeAndMethodNameFromSoapAction"
		end

	frozen get_interop_field_type_and_name_from_xml_attribute (containing_type: TYPE; xml_attribute: SYSTEM_STRING; xml_namespace: SYSTEM_STRING; type: TYPE; name: SYSTEM_STRING) is
		external
			"IL static signature (System.Type, System.String, System.String, System.Type&, System.String&): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropFieldTypeAndNameFromXmlAttribute"
		end

	frozen get_xml_namespace_for_method_call (mb: METHOD_BASE): SYSTEM_STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlNamespaceForMethodCall"
		end

	frozen get_interop_type_from_xml_type (xml_type: SYSTEM_STRING; xml_type_namespace: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropTypeFromXmlType"
		end

	frozen register_interop_xml_type (xml_type: SYSTEM_STRING; xml_type_namespace: SYSTEM_STRING; type: TYPE) is
		external
			"IL static signature (System.String, System.String, System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterInteropXmlType"
		end

	frozen get_xml_type_for_interop_type (type: TYPE; xml_type: SYSTEM_STRING; xml_type_namespace: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.Type, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlTypeForInteropType"
		end

	frozen get_xml_element_for_interop_type (type: TYPE; xml_element: SYSTEM_STRING; xml_namespace: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.Type, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlElementForInteropType"
		end

	frozen get_interop_field_type_and_name_from_xml_element (containing_type: TYPE; xml_element: SYSTEM_STRING; xml_namespace: SYSTEM_STRING; type: TYPE; name: SYSTEM_STRING) is
		external
			"IL static signature (System.Type, System.String, System.String, System.Type&, System.String&): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropFieldTypeAndNameFromXmlElement"
		end

	frozen get_interop_type_from_xml_element (xml_element: SYSTEM_STRING; xml_namespace: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropTypeFromXmlElement"
		end

	frozen register_interop_xml_element (xml_element: SYSTEM_STRING; xml_namespace: SYSTEM_STRING; type: TYPE) is
		external
			"IL static signature (System.String, System.String, System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterInteropXmlElement"
		end

	frozen pre_load_type (type: TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"PreLoad"
		end

	frozen register_soap_action_for_method_base (mb: METHOD_BASE) is
		external
			"IL static signature (System.Reflection.MethodBase): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterSoapActionForMethodBase"
		end

	frozen get_xml_namespace_for_method_response (mb: METHOD_BASE): SYSTEM_STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlNamespaceForMethodResponse"
		end

	frozen is_clr_type_namespace (namespace_string: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"IsClrTypeNamespace"
		end

	frozen register_soap_action_for_method_base_method_base_string (mb: METHOD_BASE; soap_action: SYSTEM_STRING) is
		external
			"IL static signature (System.Reflection.MethodBase, System.String): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterSoapActionForMethodBase"
		end

	frozen pre_load (assembly: ASSEMBLY) is
		external
			"IL static signature (System.Reflection.Assembly): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"PreLoad"
		end

	frozen get_soap_action_from_method_base (mb: METHOD_BASE): SYSTEM_STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetSoapActionFromMethodBase"
		end

	frozen decode_xml_namespace_for_clr_type_namespace (in_namespace: SYSTEM_STRING; type_namespace: SYSTEM_STRING; assembly_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"DecodeXmlNamespaceForClrTypeNamespace"
		end

	frozen is_soap_action_valid_for_method_base (soap_action: SYSTEM_STRING; mb: METHOD_BASE): BOOLEAN is
		external
			"IL static signature (System.String, System.Reflection.MethodBase): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"IsSoapActionValidForMethodBase"
		end

	frozen code_xml_namespace_for_clr_type_namespace (type_namespace: SYSTEM_STRING; assembly_name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"CodeXmlNamespaceForClrTypeNamespace"
		end

end -- class SOAP_SERVICES
