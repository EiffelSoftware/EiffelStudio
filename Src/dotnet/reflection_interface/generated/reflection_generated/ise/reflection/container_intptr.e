indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CONTAINER_INTPTR"

deferred external class
	CONTAINER_INTPTR

feature -- Basic Operations

	has (v: POINTER): BOOLEAN is
		external
			"IL deferred signature (System.IntPtr): System.Boolean use CONTAINER_INTPTR"
		alias
			"has"
		end

	object_comparison: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_INTPTR"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL deferred signature (): System.Void use CONTAINER_INTPTR"
		alias
			"compare_references"
		end

	linear_representation: LINEAR_INTPTR is
		external
			"IL deferred signature (): LINEAR_INTPTR use CONTAINER_INTPTR"
		alias
			"linear_representation"
		end

	empty: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_INTPTR"
		alias
			"empty"
		end

	is_empty: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_INTPTR"
		alias
			"is_empty"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use CONTAINER_INTPTR"
		alias
			"_set_object_comparison"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_INTPTR"
		alias
			"changeable_comparison_criterion"
		end

	compare_objects is
		external
			"IL deferred signature (): System.Void use CONTAINER_INTPTR"
		alias
			"compare_objects"
		end

end -- class CONTAINER_INTPTR
