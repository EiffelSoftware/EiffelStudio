indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TRAVERSABLE_BOOLEAN"

deferred external class
	TRAVERSABLE_BOOLEAN

inherit
	CONTAINER_BOOLEAN

feature -- Basic Operations

	off: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use TRAVERSABLE_BOOLEAN"
		alias
			"off"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL deferred signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use TRAVERSABLE_BOOLEAN"
		alias
			"do_if"
		end

	item: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use TRAVERSABLE_BOOLEAN"
		alias
			"item"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use TRAVERSABLE_BOOLEAN"
		alias
			"there_exists"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use TRAVERSABLE_BOOLEAN"
		alias
			"for_all"
		end

	start is
		external
			"IL deferred signature (): System.Void use TRAVERSABLE_BOOLEAN"
		alias
			"start"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL deferred signature (PROCEDURE_ANY_ANY): System.Void use TRAVERSABLE_BOOLEAN"
		alias
			"do_all"
		end

end -- class TRAVERSABLE_BOOLEAN
