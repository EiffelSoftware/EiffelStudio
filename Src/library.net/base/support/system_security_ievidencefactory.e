indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.IEvidenceFactory"

deferred external class
	SYSTEM_SECURITY_IEVIDENCEFACTORY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE is
		external
			"IL deferred signature (): System.Security.Policy.Evidence use System.Security.IEvidenceFactory"
		alias
			"get_Evidence"
		end

end -- class SYSTEM_SECURITY_IEVIDENCEFACTORY
