indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Text.FontCollection"

deferred external class
	SYSTEM_DRAWING_TEXT_FONTCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE

feature -- Access

	frozen get_families: ARRAY [SYSTEM_DRAWING_FONTFAMILY] is
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

	dispose is
		external
			"IL signature (): System.Void use System.Drawing.Text.FontCollection"
		alias
			"Dispose"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Text.FontCollection"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_DRAWING_TEXT_FONTCOLLECTION
