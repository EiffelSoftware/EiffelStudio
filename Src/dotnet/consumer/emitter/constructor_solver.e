indexing
	description: "Intermediate representation of constructors used to solve overloading"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRUCTOR_SOLVER

inherit
	COMPARABLE
	
	ARGUMENT_SOLVER
		rename
			arguments as solved_arguments
		undefine
			is_equal
		end
		
	NAME_FORMATTER
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (cons: CONSTRUCTOR_INFO) is
			-- Initialize from `cons'.
		require
			non_void_constructor: cons /= Void
		do
			internal_constructor := cons
			arguments := solved_arguments (cons)
			is_public := cons.get_is_public
		ensure
			internal_constructor_set: internal_constructor = cons
			is_public_set: is_public = cons.get_is_public
		end

feature -- Access

	name: STRING
			-- Eiffel name of constructor

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Creation routine arguments

	is_public: BOOLEAN
			-- Is constructor public?

	consumed_constructor: CONSUMED_CONSTRUCTOR is
			-- Generate consumed constructor from `name' and `internal_constructor'.
		require
			name_set: name /= Void
		do
			create Result.make (name, arguments, is_public,
				referenced_type_from_type (internal_constructor.get_declaring_type))
		ensure
			non_void_constructor: Result /= Void
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Compare argument count.
		do
			Result := arguments.count < other.arguments.count
		end
		
feature {TYPE_CONSUMER} -- Element settings

	set_name (n: like name) is
			-- set `name' with `n'.
		require
			non_void_name: n /= Void
			valid_name: not n.is_empty
		do
			name := n
		ensure
			name_set: name = n
		end
		
feature {CONSTRUCTOR_SOLVER} -- Implementation

	internal_constructor: CONSTRUCTOR_INFO
			-- Constructor info

end -- class CONSTRUCTOR_SOLVER
