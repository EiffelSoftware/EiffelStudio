indexing
	Generator: "Eiffel Emitter beta 2"
	external_name: "ISE.Reflection.CodeGenerator"

deferred external class
	ISE_REFLECTION_CODEGENERATOR

inherit
	ANY
		undefine
			ToString,
			Equals,
			GetHashCode,
			Finalize
		end

feature -- Basic Operations

	generatecode is
		external
			"IL deferred signature (): System.Void use ISE.Reflection.CodeGenerator"
		alias
			"GenerateCode"
		end

end -- class ISE_REFLECTION_CODEGENERATOR
