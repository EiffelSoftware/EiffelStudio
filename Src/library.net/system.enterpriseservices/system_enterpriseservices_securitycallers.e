indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SecurityCallers"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SECURITYCALLERS

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (idx: INTEGER): SYSTEM_ENTERPRISESERVICES_SECURITYIDENTITY is
		external
			"IL signature (System.Int32): System.EnterpriseServices.SecurityIdentity use System.EnterpriseServices.SecurityCallers"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SecurityCallers"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SecurityCallers"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.EnterpriseServices.SecurityCallers"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SecurityCallers"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.SecurityCallers"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.SecurityCallers"
		alias
			"Finalize"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SECURITYCALLERS
