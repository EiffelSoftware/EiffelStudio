indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.Debugger"

frozen external class
	SYSTEM_DIAGNOSTICS_DEBUGGER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.Debugger"
		end

feature -- Access

	frozen default_category: STRING is
		external
			"IL static_field signature :System.String use System.Diagnostics.Debugger"
		alias
			"DefaultCategory"
		end

	frozen get_is_attached: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Diagnostics.Debugger"
		alias
			"get_IsAttached"
		end

feature -- Basic Operations

	frozen break is
		external
			"IL static signature (): System.Void use System.Diagnostics.Debugger"
		alias
			"Break"
		end

	frozen log (level: INTEGER; category: STRING; message: STRING) is
		external
			"IL static signature (System.Int32, System.String, System.String): System.Void use System.Diagnostics.Debugger"
		alias
			"Log"
		end

	frozen launch: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Diagnostics.Debugger"
		alias
			"Launch"
		end

	frozen is_logging: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Diagnostics.Debugger"
		alias
			"IsLogging"
		end

end -- class SYSTEM_DIAGNOSTICS_DEBUGGER
