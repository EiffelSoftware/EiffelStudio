indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Text.FontCollection"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	DRAWING_FONT_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE

feature -- Access

	frozen get_families: NATIVE_ARRAY [DRAWING_FONT_FAMILY] is
		external
			"IL signature (): System.Drawing.FontFamily[] use System.Drawing.Text.FontCollection"
		alias
			"get_Families"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Text.FontCollection"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Text.FontCollection"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Text.FontCollection"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Text.FontCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Text.FontCollection"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Text.FontCollection"
		alias
			"Finalize"
		end

end -- class DRAWING_FONT_COLLECTION
