indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.NotifyParentPropertyAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_NOTIFYPARENTPROPERTYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals_object
		end

create
	make_notifyparentpropertyattribute

feature {NONE} -- Initialization

	frozen make_notifyparentpropertyattribute (notify_parent: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.NotifyParentPropertyAttribute"
		end

feature -- Access

	frozen get_notify_parent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.NotifyParentPropertyAttribute"
		alias
			"get_NotifyParent"
		end

	frozen default: SYSTEM_COMPONENTMODEL_NOTIFYPARENTPROPERTYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.NotifyParentPropertyAttribute use System.ComponentModel.NotifyParentPropertyAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_NOTIFYPARENTPROPERTYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.NotifyParentPropertyAttribute use System.ComponentModel.NotifyParentPropertyAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_NOTIFYPARENTPROPERTYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.NotifyParentPropertyAttribute use System.ComponentModel.NotifyParentPropertyAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.NotifyParentPropertyAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.NotifyParentPropertyAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.NotifyParentPropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_NOTIFYPARENTPROPERTYATTRIBUTE
