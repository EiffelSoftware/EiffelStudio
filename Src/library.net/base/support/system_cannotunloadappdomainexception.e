indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CannotUnloadAppDomainException"

external class
	SYSTEM_CANNOTUNLOADAPPDOMAINEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_cannotunloadappdomainexception_2,
	make_cannotunloadappdomainexception_1,
	make_cannotunloadappdomainexception

feature {NONE} -- Initialization

	frozen make_cannotunloadappdomainexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.CannotUnloadAppDomainException"
		end

	frozen make_cannotunloadappdomainexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.CannotUnloadAppDomainException"
		end

	frozen make_cannotunloadappdomainexception is
		external
			"IL creator use System.CannotUnloadAppDomainException"
		end

end -- class SYSTEM_CANNOTUNLOADAPPDOMAINEXCEPTION
