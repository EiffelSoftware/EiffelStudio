indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.GENERATOR"

external class
	IMPLEMENTATION_GENERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	GENERATOR

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.GENERATOR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_xml_generator: XML_CODE_GENERATOR is
		external
			"IL field signature :XML_CODE_GENERATOR use Implementation.GENERATOR"
		alias
			"$$xml_generator"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_generator: EIFFEL_CODE_GENERATOR is
		external
			"IL field signature :EIFFEL_CODE_GENERATOR use Implementation.GENERATOR"
		alias
			"$$eiffel_generator"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML is
		external
			"IL field signature :EIFFEL_CODE_GENERATOR_FROM_XML use Implementation.GENERATOR"
		alias
			"$$eiffel_generator_from_xml"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GENERATOR"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GENERATOR"
		alias
			"deep_clone"
		end

	eiffel_generator: EIFFEL_CODE_GENERATOR is
		external
			"IL signature (): EIFFEL_CODE_GENERATOR use Implementation.GENERATOR"
		alias
			"eiffel_generator"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.GENERATOR"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.GENERATOR"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.GENERATOR"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERATOR"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERATOR"
		alias
			"is_equal"
		end

	eiffel_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML is
		external
			"IL signature (): EIFFEL_CODE_GENERATOR_FROM_XML use Implementation.GENERATOR"
		alias
			"eiffel_generator_from_xml"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GENERATOR"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERATOR"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.GENERATOR"
		alias
			"generator"
		end

	a_set_xml_generator (xml_generator2: XML_CODE_GENERATOR) is
		external
			"IL signature (XML_CODE_GENERATOR): System.Void use Implementation.GENERATOR"
		alias
			"_set_xml_generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERATOR"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GENERATOR"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GENERATOR"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GENERATOR"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.GENERATOR"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.GENERATOR"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.GENERATOR"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.GENERATOR"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERATOR"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GENERATOR"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.GENERATOR"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GENERATOR"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.GENERATOR"
		alias
			"Equals"
		end

	a_set_eiffel_generator (eiffel_generator2: EIFFEL_CODE_GENERATOR) is
		external
			"IL signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.GENERATOR"
		alias
			"_set_eiffel_generator"
		end

	xml_generator: XML_CODE_GENERATOR is
		external
			"IL signature (): XML_CODE_GENERATOR use Implementation.GENERATOR"
		alias
			"xml_generator"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.GENERATOR"
		alias
			"generating_type"
		end

	a_set_eiffel_generator_from_xml (eiffel_generator_from_xml2: EIFFEL_CODE_GENERATOR_FROM_XML) is
		external
			"IL signature (EIFFEL_CODE_GENERATOR_FROM_XML): System.Void use Implementation.GENERATOR"
		alias
			"_set_eiffel_generator_from_xml"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.GENERATOR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.GENERATOR"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GENERATOR"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERATOR"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERATOR"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERATOR"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: GENERATOR) is
		external
			"IL static signature (GENERATOR): System.Void use Implementation.GENERATOR"
		alias
			"$$make"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.GENERATOR"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERATOR"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.GENERATOR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_GENERATOR
