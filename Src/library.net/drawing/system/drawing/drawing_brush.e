indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Brush"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	DRAWING_BRUSH

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	ICLONEABLE
	IDISPOSABLE

feature -- Basic Operations

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Brush"
		alias
			"Dispose"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Drawing.Brush"
		alias
			"Clone"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Brush"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Brush"
		alias
			"Finalize"
		end

end -- class DRAWING_BRUSH
