indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SUPPORTS"

deferred external class
	SUPPORTS

inherit
	SUPPORT_SUPPORT

feature -- Basic Operations

	a_set_conversion_support (conversion_support2: CONVERSION_SUPPORT) is
		external
			"IL deferred signature (CONVERSION_SUPPORT): System.Void use SUPPORTS"
		alias
			"_set_conversion_support"
		end

	a_set_reflection_support (reflection_support2: REFLECTION_SUPPORT) is
		external
			"IL deferred signature (REFLECTION_SUPPORT): System.Void use SUPPORTS"
		alias
			"_set_reflection_support"
		end

	code_generation_support: CODE_GENERATION_SUPPORT is
		external
			"IL deferred signature (): CODE_GENERATION_SUPPORT use SUPPORTS"
		alias
			"code_generation_support"
		end

	reflection_support: REFLECTION_SUPPORT is
		external
			"IL deferred signature (): REFLECTION_SUPPORT use SUPPORTS"
		alias
			"reflection_support"
		end

	make is
		external
			"IL deferred signature (): System.Void use SUPPORTS"
		alias
			"make"
		end

	a_set_code_generation_support (code_generation_support2: CODE_GENERATION_SUPPORT) is
		external
			"IL deferred signature (CODE_GENERATION_SUPPORT): System.Void use SUPPORTS"
		alias
			"_set_code_generation_support"
		end

	conversion_support: CONVERSION_SUPPORT is
		external
			"IL deferred signature (): CONVERSION_SUPPORT use SUPPORTS"
		alias
			"conversion_support"
		end

end -- class SUPPORTS
