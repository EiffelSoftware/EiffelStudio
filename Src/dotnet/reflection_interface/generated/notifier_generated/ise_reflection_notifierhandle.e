indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.NotifierHandle"
	assembly: "ISE.Reflection.EiffelAssemblyCacheNotifier", "0.0.0.0", "neutral", "3a8ce9be7fa5624b"

external class
	ISE_REFLECTION_NOTIFIERHANDLE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.NotifierHandle"
		end

feature -- Basic Operations

	current_notifier: ISE_REFLECTION_NOTIFIER is
		external
			"IL signature (): ISE.Reflection.Notifier use ISE.Reflection.NotifierHandle"
		alias
			"CurrentNotifier"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.NotifierHandle"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_NOTIFIERHANDLE
