indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	raise_deserialization_event is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RaiseDeserializationEvent"
		end

	record_fixup (object_to_be_fixed: INTEGER_64; member: SYSTEM_REFLECTION_MEMBERINFO; object_required: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Reflection.MemberInfo, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordFixup"
		end

	record_delayed_fixup (object_to_be_fixed: INTEGER_64; member_name: STRING; object_required: INTEGER_64) is
		external
			"IL signature (System.Int64, System.String, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordDelayedFixup"
		end

	get_object (object_id: INTEGER_64): ANY is
		external
			"IL signature (System.Int64): System.Object use System.Runtime.Serialization.ObjectManager"
		alias
			"GetObject"
		end

	frozen register_object_object_int64_serialization_info_int64_member_info (obj: ANY; object_id: INTEGER_64; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; id_of_containing_obj: INTEGER_64; member: SYSTEM_REFLECTION_MEMBERINFO) is
		external
			"IL signature (System.Object, System.Int64, System.Runtime.Serialization.SerializationInfo, System.Int64, System.Reflection.MemberInfo): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

	frozen register_object_object_int64_serialization_info (obj: ANY; object_id: INTEGER_64; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO) is
		external
			"IL signature (System.Object, System.Int64, System.Runtime.Serialization.SerializationInfo): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

	record_array_element_fixup_int64_array_int32 (array_to_be_fixed: INTEGER_64; indices: ARRAY [INTEGER]; object_required: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int32[], System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordArrayElementFixup"
		end

	register_object (obj: ANY; object_id: INTEGER_64) is
		external
			"IL signature (System.Object, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

	record_array_element_fixup (array_to_be_fixed: INTEGER_64; index: INTEGER; object_required: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int32, System.Int64): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RecordArrayElementFixup"
		end

	do_fixups is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"DoFixups"
		end

	frozen register_object_object_int64_serialization_info_int64_member_info_array_int32 (obj: ANY; object_id: INTEGER_64; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; id_of_containing_obj: INTEGER_64; member: SYSTEM_REFLECTION_MEMBERINFO; array_index: ARRAY [INTEGER]) is
		external
			"IL signature (System.Object, System.Int64, System.Runtime.Serialization.SerializationInfo, System.Int64, System.Reflection.MemberInfo, System.Int32[]): System.Void use System.Runtime.Serialization.ObjectManager"
		alias
			"RegisterObject"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_OBJECTMANAGER
