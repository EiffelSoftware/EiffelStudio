indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost+ConnectionPointCookie"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONNECTION_POINT_COOKIE_IN_WINFORMS_AX_HOST

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create
	make

feature {NONE} -- Initialization

	frozen make (source: SYSTEM_OBJECT; sink: SYSTEM_OBJECT; event_interface: TYPE) is
		external
			"IL creator signature (System.Object, System.Object, System.Type) use System.Windows.Forms.AxHost+ConnectionPointCookie"
		end

feature -- Basic Operations

	frozen disconnect is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost+ConnectionPointCookie"
		alias
			"Disconnect"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost+ConnectionPointCookie"
		alias
			"Finalize"
		end

end -- class WINFORMS_CONNECTION_POINT_COOKIE_IN_WINFORMS_AX_HOST
