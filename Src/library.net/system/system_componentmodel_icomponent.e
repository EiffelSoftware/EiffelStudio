indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.IComponent"

deferred external class
	SYSTEM_COMPONENTMODEL_ICOMPONENT

inherit
	SYSTEM_IDISPOSABLE

feature -- Access

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL deferred signature (): System.ComponentModel.ISite use System.ComponentModel.IComponent"
		alias
			"get_Site"
		end

feature -- Element Change

	add_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.IComponent"
		alias
			"add_Disposed"
		end

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL deferred signature (System.ComponentModel.ISite): System.Void use System.ComponentModel.IComponent"
		alias
			"set_Site"
		end

	remove_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.IComponent"
		alias
			"remove_Disposed"
		end

end -- class SYSTEM_COMPONENTMODEL_ICOMPONENT
