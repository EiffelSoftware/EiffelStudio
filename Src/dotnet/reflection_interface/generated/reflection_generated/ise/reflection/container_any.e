indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CONTAINER_ANY"

deferred external class
	CONTAINER_ANY

feature -- Basic Operations

	has (v: ANY): BOOLEAN is
		external
			"IL deferred signature (ANY): System.Boolean use CONTAINER_ANY"
		alias
			"has"
		end

	object_comparison: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_ANY"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL deferred signature (): System.Void use CONTAINER_ANY"
		alias
			"compare_references"
		end

	linear_representation: LINEAR_ANY is
		external
			"IL deferred signature (): LINEAR_ANY use CONTAINER_ANY"
		alias
			"linear_representation"
		end

	empty: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_ANY"
		alias
			"empty"
		end

	is_empty: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_ANY"
		alias
			"is_empty"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use CONTAINER_ANY"
		alias
			"_set_object_comparison"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use CONTAINER_ANY"
		alias
			"changeable_comparison_criterion"
		end

	compare_objects is
		external
			"IL deferred signature (): System.Void use CONTAINER_ANY"
		alias
			"compare_objects"
		end

end -- class CONTAINER_ANY
