indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.NotifierHandle"

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

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.NotifierHandle"
		alias
			"Make"
		end

	CurrentNotifier: ISE_REFLECTION_NOTIFIER is
		external
			"IL signature (): ISE.Reflection.Notifier use ISE.Reflection.NotifierHandle"
		alias
			"CurrentNotifier"
		end

end -- class ISE_REFLECTION_NOTIFIERHANDLE
