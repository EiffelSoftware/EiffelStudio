indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TRAVERSABLE_ANY"

deferred external class
	TRAVERSABLE_ANY

inherit
	CONTAINER_ANY

feature -- Basic Operations

	off: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use TRAVERSABLE_ANY"
		alias
			"off"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL deferred signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use TRAVERSABLE_ANY"
		alias
			"do_if"
		end

	item: ANY is
		external
			"IL deferred signature (): ANY use TRAVERSABLE_ANY"
		alias
			"item"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use TRAVERSABLE_ANY"
		alias
			"there_exists"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use TRAVERSABLE_ANY"
		alias
			"for_all"
		end

	start is
		external
			"IL deferred signature (): System.Void use TRAVERSABLE_ANY"
		alias
			"start"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL deferred signature (PROCEDURE_ANY_ANY): System.Void use TRAVERSABLE_ANY"
		alias
			"do_all"
		end

end -- class TRAVERSABLE_ANY
