indexing
	description: "Include all the information needed to produce feature Eiffel code and XML file."
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class	
	EIFFEL_FEATURE
	
inherit
	HASHABLE
		
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize attributes."
		do
			create arguments.make
			create preconditions.make
			create postconditions.make
			create comments.make
		ensure
			non_void_arguments: arguments /= Void
			non_void_preconditions: preconditions /= Void
			non_void_postconditions: postconditions /= Void
			non_void_comments: comments /= Void
		end

feature -- Access

	eiffel_name: STRING
		indexing
			description: "Eiffel name"
		end
		
	external_name: STRING
		indexing
			description: "External name"
		end
		
	arguments: LINKED_LIST [NAMED_SIGNATURE_TYPE_INTERFACE]
			-- | ARRAY_LIST [NAMED_SIGNATURE_TYPE]
		indexing
			description: "Feature Arguments"
		end
		
	return_type: SIGNATURE_TYPE	
		indexing
			description: "Eiffel name of feature return type"
		end
				
	preconditions: LINKED_LIST [ARRAY [STRING]]
			-- | ARRAY_LIST [ARRAY [STRING]]
			-- | Array with precondition tag and precondition text
		indexing
			description: "Feature preconditions"
		end
		
	postconditions: LINKED_LIST [ARRAY [STRING]]
			-- | ARRAY_LIST [ARRAY [STRING]]
			-- | Array with postcondition tag and postcondition text
		indexing
			description: "Feature postconditions"
		end
		
	comments: LINKED_LIST [STRING]
			-- | ARRAY_LIST [STRING]
		indexing
			description: "Feature comments"
		end

	literal_value: STRING
		indexing
			description: "Literal value (in case feature is a literal)"
		end
		
	hash_code: INTEGER is
			-- 
		do
			Result := external_name.hash_code
		end
		
		
feature -- Eiffel names from .NET information

	argument_from_info (info: PARAMETER_INFO): ARRAY [STRING] is 
		indexing
			description: "Eiffel name and type of argument corresponding to `info'"
		require
			non_void_info: info /= Void
			non_void_parameter_name: info.get_name /= Void
			non_void_parameter_type: info.get_parameter_type /= Void
			non_void_parameter_type_fullname: info.get_parameter_type.get_full_name /= Void
		local
			i: INTEGER
			an_argument: NAMED_SIGNATURE_TYPE
			retried: BOOLEAN
		do
			if not retried then
				from
				until
					i = arguments.count 
				loop
					an_argument ?= arguments.i_th (i)
					if an_argument /= Void and then an_argument.eiffel_name /= Void and then an_argument.type_eiffel_name /= Void and then an_argument.external_name /= Void and then an_argument.type_full_external_name /= Void then
						if info.get_name.equals (an_argument.external_name.to_cil) and then info.get_parameter_type.get_full_name.equals (an_argument.type_full_external_name.to_cil) then
							create Result.make (0, 1)
							Result.put (an_argument.eiffel_name, 0)
							Result.put (an_argument.type_eiffel_name, 1)
						end
					end
					i := i + 1
				end
				if Result = Void then
					create Result.make (0, 1)
				end
			else
				create Result.make (0, 1)
			end
		ensure
			non_void_argument: Result /= Void	
			valid_argument: Result.count = 2
		rescue
			retried := True
			retry
		end	
			
feature -- Status Report

	is_frozen: BOOLEAN
		indexing
			description: "Is feature frozen?"
		end
		
	is_static: BOOLEAN
		indexing
			description: "Is feature static?"
		end
		
	is_abstract: BOOLEAN
		indexing
			description: "Is feature abstract?"
		end
		
	is_method: BOOLEAN
		indexing
			description: "Is feature a method?"
		end
		
	is_field: BOOLEAN
		indexing
			description: "Is feature a field?"
		end
		
	is_creation_routine: BOOLEAN
		indexing
			description: "Is feature a creation routine?"
		end
		
	is_prefix: BOOLEAN
		indexing
			description: "Is feature a prefix?"
		end
		
	is_infix: BOOLEAN
		indexing
			description: "Is feature an infix?"
		end

	modified: BOOLEAN
		indexing
			description: "Has current feature been modified (i.e. has name changed or have arguments been renamed)?"
		end

	new_slot: BOOLEAN
		indexing
			description: "Is feature a new slot (i.e. not inherited)?"
		end

	is_enum_literal: BOOLEAN
		indexing
			description: "Is feature a literal enum?"
		end
	
	is_literal: BOOLEAN
		indexing
			description: "Is feature a literal?"
		end
		
feature -- Status Setting

	set_frozen (a_value: like is_frozen) is
		indexing
			description: "Set `is_frozen' with `a_value'."
		do
			is_frozen := a_value
		ensure
			frozen_set: is_frozen = a_value
		end
	
	set_static (a_value: like is_static) is
		indexing
			description: "Set `is_static' with `a_value'."
		do
			is_static := a_value
		ensure
			static_set: is_static = a_value
		end

	set_abstract (a_value: like is_abstract) is
		indexing
			description: "Set `is_abstract' with `a_value'."
		do
			is_abstract := a_value
		ensure
			abstract_set: is_abstract = a_value
		end
		
	set_method (a_value: like is_method) is
		indexing
			description: "Set `is_method' with `a_value'."
		do
			is_method := a_value
		ensure
			method_set: is_method = a_value
		end
		
	set_field (a_value: like is_field) is
		indexing
			description: "Set `is_field' with `a_value'."
		do
			is_field := a_value
		ensure
			field_set: is_field = a_value
		end
		
	set_creation_routine (a_value: like is_creation_routine) is
		indexing
			description: "Set `is_creation_routine' with `a_value'."
		do
			is_creation_routine := a_value
		ensure
			creation_routine_set: is_creation_routine = a_value
		end

	set_prefix (a_value: like is_prefix) is
		indexing
			description: "Set `is_prefix' with `a_value'."
		do
			is_prefix := a_value
		ensure
			prefix_set: is_prefix = a_value
		end

	set_infix (a_value: like is_infix) is
		indexing
			description: "Set `is_infix' with `a_value'."
		do
			is_infix := a_value
		ensure
			infix_set: is_infix = a_value
		end

	set_new_slot (a_value: like new_slot) is
		indexing
			description: "Set `new_slot' with `a_value'."
		do
			new_slot := a_value
		ensure
			new_slot_set: new_slot = a_value
		end
		
	set_modified (a_value: like modified) is
		indexing
			description: "Set `modified' with `a_value'."
		do
			modified := a_value
		ensure
			modified_set: modified = a_value
		end

	set_enum_literal (a_value: like is_enum_literal) is
		indexing
			description: "Set `is_enum_literal' with `a_value'."
		do
			is_enum_literal := a_value
		ensure
			is_enum_literal_set: is_enum_literal = a_value
		end

	set_literal (a_value: like is_literal) is
		indexing
			description: "Set `is_literal' with `a_value'."
		do
			is_literal := a_value
		ensure
			is_literal_set: is_literal = a_value
		end
		
	set_eiffel_name (a_name: like eiffel_name) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.count > 0
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name.is_equal (a_name)
		end	

	set_external_name (a_name: like external_name) is
		indexing
			description: "Set `external_name' with `a_name'."
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.count > 0
		do
			external_name := a_name
		ensure
			external_name_set: external_name.is_equal (a_name)
		end		
	
	set_return_type (a_type: like return_type) is
		indexing
			description: "Set `return_type' with `a_type'."
		require
			non_void_type: a_type /= Void
		do
			return_type := a_type
		ensure
			return_type_set: return_type = a_type
		end

	set_literal_value (a_value: like literal_value) is
		indexing
			description: "Set `literal_value' with `a_value'."
		require
			non_void_value: a_value /= Void
		do
			literal_value := a_value
		ensure
			literal_value_set: literal_value.is_equal (a_value)
		end	

feature -- Basic Operations

	add_argument (an_argument: NAMED_SIGNATURE_TYPE_INTERFACE) is
		indexing
			description: "Add `an_argument to `arguments'."
		require
			non_void_argument: an_argument /= Void
		do
			arguments.extend (an_argument)
		ensure
			argument_added: arguments.has (an_argument)
		end
			
	add_precondition (a_tag, a_text: STRING) is
		indexing
			description: "Add new precondition (built from `a_tag' and `a_text'  to `preconditions'."
		require
			non_void_tag: a_tag /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
		local
			a_precondition: ARRAY [STRING]
		do
			create a_precondition.make (0, 1)
			a_precondition.put (a_tag, 0)
			a_precondition.put (a_text, 1)
			preconditions.extend (a_precondition)	
		ensure
			precondition_added: preconditions.count = old (preconditions.count + 1)
		end

	add_postcondition (a_tag, a_text: STRING) is
		indexing
			description: "Add new postcondition (built from `a_tag' and `a_text'  to `postconditions'."
		require
			non_void_tag: a_tag /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
		local
			a_postcondition: ARRAY [STRING]
		do
			create a_postcondition.make (0, 1)
			a_postcondition.put (a_tag, 0)
			a_postcondition.put (a_text, 1)
			postconditions.extend (a_postcondition)	
		ensure
			postcondition_added: postconditions.count = old (postconditions.count + 1)
		end

	add_comment (a_comment: STRING) is
		indexing
			description: "Add `a_comment' to `comments'."
		require
			non_void_comment: a_comment /= Void
			not_empty_comment: a_comment.count > 0
		do
			comments.extend (a_comment)
		ensure
			comment_added: comments.has (a_comment)
		end
		
invariant
	non_void_arguments: arguments /= Void
	non_void_preconditions: preconditions /= Void
	non_void_postconditions: postconditions /= Void
	non_void_comments: comments /= Void
	prefix_xor_infix: is_prefix xor is_infix
	method_xor_field_xor_creation_routine: is_method xor is_field xor is_creation_routine
	frozen_xor_abstract: is_frozen xor is_abstract
	
end -- class EIFFEL_FEATURE
