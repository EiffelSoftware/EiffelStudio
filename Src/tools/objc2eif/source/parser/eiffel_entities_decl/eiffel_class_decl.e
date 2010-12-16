note
	description: "An Eiffel class declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLASS_DECL

inherit
	EIFFEL_ENTITY_DECL

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_framework: STRING)
			-- Initialize Current with `a_name' and `a_framework'.
		require
			a_valid_name: not a_name.is_empty
			a_valid_framework: not a_framework.is_empty
		do
			name := a_name
			framework := a_framework
			create inheritance_declarations.make (0)
			create creation_procedures_groups.make_empty
			create features_groups.make (0)
		ensure
			name_set: name = a_name
			framework_set: framework = a_framework
		end

feature -- Visitor Pattern

	accept (visitor: EIFFEL_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_class_decl (Current)
		end

feature -- Setters

	set_deferred (true_or_false: like is_deferred)
			-- Set `is_deferred' with `true_or_false'
		require
			no_creation_procedures: creation_procedures_groups.is_empty
		do
			is_deferred := true_or_false
		ensure
			is_deferred_set: is_deferred = true_or_false
		end

feature -- Access

	name: STRING
			-- Name of this class declaration.

	framework: STRING
			-- The original Objective-C framework this class belongs to.

	is_deferred: BOOLEAN assign set_deferred
			-- Is this class deferred?

	creation_procedures_groups: ARRAY [TUPLE [export_statuses: ARRAY [STRING]; names: ARRAY [STRING]]]
			-- Creation procedures names for this class declaration.
			-- Key: export status (if empty, ANY is assumed).
			-- Value: a list of creation procedure names.

	inheritance_declarations: HASH_TABLE [ARRAY [TUPLE [option_name: STRING; options: ARRAY[STRING]]], STRING]
			-- Inheritance declarations of this class declaration.
			-- Key: name of the inherited class.
			-- Value: a list of tuples specifying the inheritance options. E.g.:
			-- <<["redefine", <<"make_by_pointer", "debug_output">>], ["rename", <<"make as allocate">>]>>

	features_groups: HASH_TABLE [TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]], STRING]
			-- A list of groups of eiffel routines indexed by the group name.

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		local
			visitor: EIFFEL_DEBUG_VISITOR
		do
			create visitor.make
			accept (visitor)
			Result := visitor.last_result
		end

end
