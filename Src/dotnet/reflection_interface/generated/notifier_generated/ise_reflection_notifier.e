indexing
	Generator: "Eiffel Emitter beta 2"
	external_name: "ISE.Reflection.Notifier"

external class
	ISE_REFLECTION_NOTIFIER

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.Notifier"
		end

feature -- Access

	frozen agents: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"Agents"
		end

feature -- Basic Operations

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.Notifier"
		alias
			"_invariant"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.Notifier"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_NOTIFIER
