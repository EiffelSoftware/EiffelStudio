indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.DesignerTransaction"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	frozen get_description: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerTransaction"
		alias
			"get_Description"
		end

	frozen get_canceled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.DesignerTransaction"
		alias
			"get_Canceled"
		end

	frozen get_committed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.DesignerTransaction"
		alias
			"get_Committed"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.DesignerTransaction"
		alias
			"GetHashCode"
		end

	frozen commit is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.DesignerTransaction"
		alias
			"Commit"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerTransaction"
		alias
			"ToString"
		end

	frozen cancel is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.DesignerTransaction"
		alias
			"Cancel"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Design.DesignerTransaction"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.Design.DesignerTransaction"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.DesignerTransaction"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.DesignerTransaction"
		alias
			"System.IDisposable.Dispose"
		end

	on_commit is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.DesignerTransaction"
		alias
			"OnCommit"
		end

	on_cancel is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.DesignerTransaction"
		alias
			"OnCancel"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTION
