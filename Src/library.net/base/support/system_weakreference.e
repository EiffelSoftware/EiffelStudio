indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.WeakReference"

external class
	SYSTEM_WEAKREFERENCE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (target: ANY) is
		external
			"IL creator signature (System.Object) use System.WeakReference"
		end

	frozen make_1 (target: ANY; track_resurrection: BOOLEAN) is
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

	get_target: ANY is
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

	set_target (value: ANY) is
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

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.WeakReference"
		alias
			"GetObjectData"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.WeakReference"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_WEAKREFERENCE
