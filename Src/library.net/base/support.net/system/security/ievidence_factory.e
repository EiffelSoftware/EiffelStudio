indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.IEvidenceFactory"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IEVIDENCE_FACTORY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_evidence: EVIDENCE is
		external
			"IL deferred signature (): System.Security.Policy.Evidence use System.Security.IEvidenceFactory"
		alias
			"get_Evidence"
		end

end -- class IEVIDENCE_FACTORY
