indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AxHost+ConnectionPointCookie"

external class
	CONNECTIONPOINTCOOKIE_IN_SYSTEM_WINDOWS_FORMS_AXHOST

inherit
	ANY
		redefine
			finalize
		end

create
	make

feature {NONE} -- Initialization

	frozen make (source: ANY; sink: ANY; event_interface: SYSTEM_TYPE) is
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

end -- class CONNECTIONPOINTCOOKIE_IN_SYSTEM_WINDOWS_FORMS_AXHOST
