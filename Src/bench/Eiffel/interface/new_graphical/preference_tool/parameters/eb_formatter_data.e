indexing
	description: "Objects that"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMATTER_DATA

inherit
	SHARED_RESOURCES
		rename
			initialize as initialize_resources
		export
			{NONE} all
		end

	FEATURE_CLAUSE_NAMES

feature -- Initialization

feature -- Access

	editor_history_size: INTEGER is
			-- Number of memorized formatted text in formatters.
		do
			Result := integer_resource_value ("formatters_history_size", 60)
		end

	default_class_formatter_index: INTEGER is
			-- Default class formatter that should be popped up automatically.
		do
			Result := integer_resource_value ("default_class_formatter_index", 5)
		end

	default_feature_formatter_index: INTEGER is
			-- Default feature formatter that should be popped up automatically.
		do
			Result := integer_resource_value ("default_feature_formatter_index", 2)
		end

	feature_clause_order: ARRAY [STRING] is
		do
			Result := array_resource_value ("feature_clause_order", Default_feature_clause_order)
		end

	excluded_indexing_items: ARRAY [STRING] is
		do
			Result := array_resource_value ("excluded_indexing_items", <<"revision", "date", "status">>)
			Result.compare_objects
		end

	show_all_callers: BOOLEAN is
			-- Should the caller formatter display all callers or only
			-- local ones (located inside the same class)?
		do
			Result := boolean_resource_value ("show_all_callers", True)
		end

	show_syntactical_suppliers: BOOLEAN is
			-- Should the supplier formatter display syntactical suppliers
			-- (those whose name appear in the class) or
			-- actual ones (those of which a feature is called)?
--|FIXME XR: Not implemented.
		do
			Result := boolean_resource_value ("show_syntactical_suppliers", False)
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

end -- class EB_FORMATTER_DATA
