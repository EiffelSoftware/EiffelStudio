indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.ObjectManager"

external class
	SYSTEM_RUNTIME_SERIALIZATION_OBJECTMANAGER

create
	make

feature {NONE} -- Initialization

	frozen make (selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.ISurrogateSelector, System.Runtime.Serialization.StreamingContext) use System.Runtime.Serialization.ObjectManager"
		end

feature -- Basic Operations

	frozen register_object_object_int64_serialization_info_int64_member_info (obj: ANY; objectID: INTEGER_64; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; idOfContainingObj: INTEGER_64; member: SYSTEM_REFLECTION_MEMBERINFO) is
		external
			"IL signature (System.Object, System.Int64, System.Runtime.Serialization.SerializationInfo, System.Int64, System.Reflection.MemberInfo): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

	raise_deserialization_Event is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RaiseDeserializationEvent"
		end

	record_delayed_fixup (objectToBeFixed: INTEGER_64; memberName: STRING; objectRequired: INTEGER_64) is
		external
			"IL signature (System.Int64, System.String, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordDelayedFixup"
		end

	record_fixup (objectToBeFixed: INTEGER_64; member: SYSTEM_REFLECTION_MEMBERINFO; objectRequired: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Reflection.MemberInfo, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordFixup"
		end

	record_array_element_fixup (arrayToBeFixed: INTEGER_64; index: INTEGER; objectRequired: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int32, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordArrayElementFixup"
		end

	frozen register_object_object_int64_serialization_info (obj: ANY; objectID: INTEGER_64; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO) is
		external
			"IL signature (System.Object, System.Int64, System.Runtime.Serialization.SerializationInfo): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

	frozen register_object_object_int64_serialization_info_int64_member_info_array_int32 (obj: ANY; objectID: INTEGER_64; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; idOfContainingObj: INTEGER_64; member: SYSTEM_REFLECTION_MEMBERINFO; arrayIndex: ARRAY [INTEGER]) is
		external
			"IL signature (System.Object, System.Int64, System.Runtime.Serialization.SerializationInfo, System.Int64, System.Reflection.MemberInfo, System.Int32[]): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

	get_object (objectID: INTEGER_64): ANY is
		external
			"IL signature (System.Int64): System.Object use System.Runtime.Serialization.ObjectManager"
		alias
			"GetObject"
		end

	do_fixups is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"DoFixups"
		end

	record_aerray_element_fixup_int64_array_int32 (arrayToBeFixed: INTEGER_64; indices: ARRAY [INTEGER]; objectRequired: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int32[], System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordArrayElementFixup"
		end

	register_object (obj: ANY; objectID: INTEGER_64) is
		external
			"IL signature (System.Object, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_OBJECTMANAGER
