indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.WeakReference"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WEAK_REFERENCE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (target: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.WeakReference"
		end

	frozen make_1 (target: SYSTEM_OBJECT; track_resurrection: BOOLEAN) is
		external
			"IL creator signature (System.Object, System.Boolean) use System.WeakReference"
		end

feature -- Access

	get_track_resurrection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.WeakReference"
		alias
			"get_TrackResurrection"
		end

	get_target: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.WeakReference"
		alias
			"get_Target"
		end

	get_is_alive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.WeakReference"
		alias
			"get_IsAlive"
		end

feature -- Element Change

	set_target (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.WeakReference"
		alias
			"set_Target"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.WeakReference"
		alias
			"GetHashCode"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.WeakReference"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.WeakReference"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.WeakReference"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.WeakReference"
		alias
			"Finalize"
		end

end -- class WEAK_REFERENCE
