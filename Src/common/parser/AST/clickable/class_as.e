-- Abstract description of an Eiffel class

class CLASS_AS

inherit

	AST_EIFFEL;
	IDABLE;
	SHARED_INST_CONTEXT;
	STONABLE;
	CLICKER;

feature -- Attributes

	id: INTEGER;
			-- Class id

	class_name: ID_AS;
			-- Class name

	is_deferred: BOOLEAN;
			-- Is the class deferred ?

	is_expanded: BOOLEAN;
			-- Is the class expanded ?

	indexes: EIFFEL_LIST [INDEX_AS];
			-- Index clause

	generics: EIFFEL_LIST [FORMAL_DEC_AS];
			-- Formal generic parameter list

	parents: EIFFEL_LIST [PARENT_AS];
			-- Inheritance clause

	creators: EIFFEL_LIST [CREATE_AS];
			-- Creators

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			-- Feature list

	invariant_part: INVARIANT_AS;
			-- Class invariant

	suppliers: SUPPLIERS_AS;
			-- Supplier types

feature -- Initialization

	set is
			-- Initialization routine
		local
			click_class_name: CLICK_AST
		do
			class_name ?= yacc_arg (0);
			is_deferred := yacc_bool_arg (0);
			is_expanded := yacc_bool_arg (1);
			indexes ?= yacc_arg (1);
			generics ?= yacc_arg (2);
			parents ?= yacc_arg (3);
			creators ?= yacc_arg (4);
			features ?= yacc_arg (5);
			invariant_part ?= yacc_arg (6);
			if (invariant_part /= Void)
				and then
				invariant_part.assertion_list = Void
			then
					-- The keyword `invariant' followed by no assertion
					-- at all is not significant.
				invariant_part := Void;
			end;
			suppliers ?= yacc_arg (7);
			click_list ?= yacc_arg (8);
			click_class_name ?= click_list.first;
			click_class_name.set_node (Current);
		ensure then
			class_name_exists: class_name /= Void;
			suppliers_exists: suppliers /= Void;
		end;

feature -- Conveniences

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

feature {CLASS_C} -- Class information

	info: CLASS_INFO is
			-- Compiled information about the class produced after
			-- parsing (useful for second pass).
		local
			parent_list: PARENT_LIST;
		do
			!!Result;
			if parents /= Void then
				!!parent_list.make (parents.count);
			elseif not ("general").is_equal (class_name) then
				!!parent_list.make (1);
			else
				!!parent_list.make (0);
			end;
			Result.set_parents (parent_list);
				-- List `parent_list' will be filled by feature `init'
				-- of CLASS_C
			Result.set_creators (creators);
		end;

feature -- stoning
 
	stone (reference_class: CLASS_C): CLASSC_STONE is
		local
			aclass: CLASS_C;
		do
			aclass := Universe.class_named (class_name, reference_class.cluster).compiled_class;
			!!Result.make (aclass)
		end;

	click_list: CLICK_LIST
 
end
