indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.ComponentModel.IComponent"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

deferred external class
	ICOMPONENT

inherit
	IDISPOSABLE

feature -- Access

	get_site: ISITE is
		external
			"IL deferred signature (): System.ComponentModel.ISite use System.ComponentModel.IComponent"
		alias
			"get_Site"
		end

feature -- Element Change

	add_disposed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.IComponent"
		alias
			"add_Disposed"
		end

	set_site (value: ISITE) is
		external
			"IL deferred signature (System.ComponentModel.ISite): System.Void use System.ComponentModel.IComponent"
		alias
			"set_Site"
		end

	remove_disposed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.IComponent"
		alias
			"remove_Disposed"
		end

end -- class ICOMPONENT
