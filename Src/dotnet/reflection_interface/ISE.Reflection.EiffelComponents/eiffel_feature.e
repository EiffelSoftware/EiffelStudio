indexing
	description: "Include all the information needed to produce feature Eiffel code and XML file."
	external_name: "ISE.Reflection.EiffelFeature"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class	
	EIFFEL_FEATURE

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize attributes."
			external_name: "Make"
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
			external_name: "EiffelName"
		end
		
	external_name: STRING
		indexing
			description: "External name"
			external_name: "ExternalName"
		end
		
	arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [NAMED_SIGNATURE_TYPE]
		indexing
			description: "Feature Arguments"
			external_name: "Arguments"
		end
		
	return_type: SIGNATURE_TYPE	
		indexing
			description: "Eiffel name of feature return type"
			external_name: "ReturnType"
		end
				
	preconditions: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ARRAY [STRING]]
			-- | Array with precondition tag and precondition text
		indexing
			description: "Feature preconditions"
			external_name: "Preconditions"
		end
		
	postconditions: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ARRAY [STRING]]
			-- | Array with postcondition tag and postcondition text
		indexing
			description: "Feature postconditions"
			external_name: "Postconditions"
		end
		
	comments: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "Feature comments"
			external_name: "Comments"
		end

feature -- Eiffel names from .NET information

	argument_from_info (info: SYSTEM_REFLECTION_PARAMETERINFO): ARRAY [STRING] is 
		indexing
			description: "Eiffel name and type of argument corresponding to `info'"
			external_name: "ArgumentFromInfo"
		require
			non_void_info: info /= Void
		local
			i: INTEGER
			an_argument: NAMED_SIGNATURE_TYPE
			retried: BOOLEAN
		do
			if not retried then
				from
				until
					i = arguments.Count 
				loop
					an_argument ?= arguments.Item (i)
					if an_argument /= Void then
						if info.Name.Equals_String (an_argument.external_name) and then info.ParameterType.FullName.Equals_String (an_argument.type_full_external_name) then
							create Result.make (2)
							Result.put (0, an_argument.eiffel_name)
							Result.put (1, an_argument.type_eiffel_name)							
						end
					end
					i := i + 1
				end
				if Result = Void then
					create Result.make (2)
				end
			else
				create Result.make (2)
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
			external_name: "IsFrozen"
		end
		
	is_static: BOOLEAN
		indexing
			description: "Is feature static?"
			external_name: "IsStatic"
		end
		
	is_abstract: BOOLEAN
		indexing
			description: "Is feature abstract?"
			external_name: "IsAbstract"
		end
		
	is_method: BOOLEAN
		indexing
			description: "Is feature a method?"
			external_name: "IsMethod"
		end
		
	is_field: BOOLEAN
		indexing
			description: "Is feature a field?"
			external_name: "IsField"
		end
		
	is_creation_routine: BOOLEAN
		indexing
			description: "Is feature a creation routine?"
			external_name: "IsCreationRoutine"
		end
		
	is_prefix: BOOLEAN
		indexing
			description: "Is feature a prefix?"
			external_name: "IsPrefix"
		end
		
	is_infix: BOOLEAN
		indexing
			description: "Is feature an infix?"
			external_name: "IsInfix"
		end

	modified: BOOLEAN
		indexing
			description: "Has current feature been modified (i.e. has name changed or have arguments been renamed)?"
			external_name: "Modified"
		end
		
--##FIXME
	postcondition: BOOLEAN
--
feature -- Status Setting

	set_frozen (a_value: like is_frozen) is
		indexing
			description: "Set `is_frozen' with `a_value'."
			external_name: "SetFrozen"
		do
			is_frozen := a_value
		ensure
			frozen_set: is_frozen = a_value
		end
	
	set_static (a_value: like is_static) is
		indexing
			description: "Set `is_static' with `a_value'."
			external_name: "SetStatic"
		do
			is_static := a_value
		ensure
			static_set: is_static = a_value
		end

	set_abstract (a_value: like is_abstract) is
		indexing
			description: "Set `is_abstract' with `a_value'."
			external_name: "SetAbstract"
		do
			is_abstract := a_value
		ensure
			abstract_set: is_abstract = a_value
		end
		
	set_method (a_value: like is_method) is
		indexing
			description: "Set `is_method' with `a_value'."
			external_name: "SetMethod"
		do
			is_method := a_value
		ensure
			method_set: is_method = a_value
		end
		
	set_field (a_value: like is_field) is
		indexing
			description: "Set `is_field' with `a_value'."
			external_name: "SetField"
		do
			is_field := a_value
		ensure
			field_set: is_field = a_value
		end
		
	set_creation_routine (a_value: like is_creation_routine) is
		indexing
			description: "Set `is_creation_routine' with `a_value'."
			external_name: "SetCreationRoutine"
		do
			is_creation_routine := a_value
		ensure
			creation_routine_set: is_creation_routine = a_value
		end

	set_prefix (a_value: like is_prefix) is
		indexing
			description: "Set `is_prefix' with `a_value'."
			external_name: "SetPrefix"
		do
			is_prefix := a_value
		ensure
			prefix_set: is_prefix = a_value
		end

	set_infix (a_value: like is_infix) is
		indexing
			description: "Set `is_infix' with `a_value'."
			external_name: "SetInfix"
		do
			is_infix := a_value
		ensure
			infix_set: is_infix = a_value
		end

	set_modified is
		indexing
			description: "Set `modified' with `True'."
			external_name: "SetModified"
		do
			modified := True
		ensure
			modified: modified
		end
		
	set_eiffel_name (a_name: like eiffel_name) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
			external_name: "SetEiffelName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name.Equals_String (a_name)
		end	

	set_external_name (a_name: like external_name) is
		indexing
			description: "Set `external_name' with `a_name'."
			external_name: "SetExternalName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
		do
			external_name := a_name
		ensure
			external_name_set: external_name.Equals_String (a_name)
		end		
	
	set_return_type (a_type: like return_type) is
		indexing
			description: "Set `return_type' with `a_type'."
			external_name: "SetReturnType"
		require
			non_void_type: a_type /= Void
		do
			return_type := a_type
		ensure
			return_type_set: return_type = a_type
		end
	
--##FIXME
	set_postcondition (a_postcondition: like postcondition) is
		indexing
			description: "Set `postcondition' with `a_postcondition'."
			external_name: "SetPostcondition"
		do
			postcondition := a_postcondition
		ensure
			postcondition_set: postcondition = a_postcondition
		end

feature -- Basic Operations

	add_argument (an_argument: NAMED_SIGNATURE_TYPE) is
		indexing
			description: "Add `an_argument to `arguments'."
			external_name: "AddArgument"
		require
			non_void_argument: an_argument /= Void
		local
			argument_added: INTEGER
		do
			argument_added := arguments.Add (an_argument)
		end
			
	add_precondition (a_tag, a_text: STRING) is
		indexing
			description: "Add new precondition (built from `a_tag' and `a_text'  to `preconditions'."
			external_name: "AddPrecondition"
		require
			non_void_tag: a_tag /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.Length > 0
		local
			precondition_added: INTEGER
			a_precondition: ARRAY [STRING]
		do
			create a_precondition.make (2)
			a_precondition.put (0, a_tag)
			a_precondition.put (1, a_text)
			precondition_added := preconditions.Add (a_precondition)	
		end

	add_postcondition (a_tag, a_text: STRING) is
		indexing
			description: "Add new postcondition (built from `a_tag' and `a_text'  to `postconditions'."
			external_name: "AddPostcondition"
		require
			non_void_tag: a_tag /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.Length > 0
		local
			postcondition_added: INTEGER
			a_postcondition: ARRAY [STRING]
		do
			create a_postcondition.make (2)
			a_postcondition.put (0, a_tag)
			a_postcondition.put (1, a_text)
			postcondition_added := postconditions.Add (a_postcondition)	
		end

	add_comment (a_comment: STRING) is
		indexing
			description: "Add `a_comment' to `comments'."
			external_name: "AddComment"
		require
			non_void_comment: a_comment /= Void
			not_empty_comment: a_comment.Length > 0
		local
			comment_added: INTEGER
		do
			comment_added := comments.Add (a_comment)
		ensure
			comment_added: comments.Contains (a_comment)
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
