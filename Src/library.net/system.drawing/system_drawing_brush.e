indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Brush"

deferred external class
	SYSTEM_DRAWING_BRUSH

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

feature -- Basic Operations

	dispose is
		external
			"IL signature (): System.Void use System.Drawing.Brush"
		alias
			"Dispose"
		end

	clone: ANY is
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

end -- class SYSTEM_DRAWING_BRUSH
