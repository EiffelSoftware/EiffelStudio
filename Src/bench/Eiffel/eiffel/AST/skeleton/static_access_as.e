indexing
	description:
		"Abstract description of an access to the precursor of%
		%an Eiffel feature. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class STATIC_ACCESS_AS

inherit
	ACCESS_FEAT_AS
		rename
			initialize as feat_initialize,
			associated_class as assoc_class
		export
			{NONE} feat_initialize
		redefine
			process,
			type_check, is_equivalent, simple_format, format,
			valid_feature, report_error_for_feature,
			assoc_class, context_last_type,
			new_call_access
		end
		
	ATOMIC_AS
		undefine
			format, byte_node
		redefine
			type_check, good_integer, good_character,
			make_integer, make_character
		end
		
	SHARED_INSTANTIATOR
		export
			{NONE} all
		end

create
	initialize

feature {AST_FACTORY} -- Initialization

	initialize (c: like class_type; f: like feature_name; p: like parameters) is
			-- Create a new STATIC_ACCESS_AS AST node.
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
		do
			class_type := c
			feature_name := f
			parameters := p
			if p /= Void then
				p.start
			end
		ensure
			class_type_set: class_type = c
			feature_name_set: feature_name = f
			parameters_set: parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_static_access_as (Current)
		end

feature -- Attributes

	class_type: TYPE
			-- Type in which `feature_name' is defined.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := Precursor {ACCESS_FEAT_AS} (other) and then
				equivalent (class_type, other.class_type)
		end

feature -- Query

	associated_class: CLASS_C is
			-- Associated CLASS_C object to `class_type'.
		do
			Result := assoc_class (Void)
		end

	context_last_type: TYPE_A is
			-- Type of static access.
		do
			Result := class_type.actual_type
		end

	associated_constant: CONSTANT_I is
			-- Associated constant if static access is performed on
			-- constant, otherwise Void.
		do
			Result ?= associated_feature
		end

	associated_feature: FEATURE_I is
			-- Associated feature.
		do
			Result := context_last_type.associated_class.feature_table.item (feature_name)
		end
		
feature -- Type check, byte code and dead code removal

	type_check is
			-- Type checking of a static access.
		local
			l_type: TYPE_A
			vsta1: VSTA1
			vtug: VTUG
		do
				-- Check validity of class specification
			l_type := class_type.actual_type
			if l_type.is_formal or l_type.has_like or l_type.is_none then
				create vsta1.make (l_type.dump, feature_name)
				vsta1.set_class (context.current_class)
				error_handler.insert_error (vsta1)
				error_handler.raise_error
			else
				if not l_type.good_generics then
					vtug := l_type.error_generics
					vtug.set_class (context.current_class)
					vtug.set_feature (context.current_feature)
					Error_handler.insert_error (vtug)
					Error_handler.raise_error
				end
			end

			Instantiator.dispatch (l_type, context.current_class)

				-- Check validity of call.
			Precursor {ACCESS_FEAT_AS}
		end

	report_error_for_feature (a_feature: FEATURE_I; a_feature_name: like feature_name) is
			-- Report error during `type_check' because `a_feature'
			-- was not valid for a static access.
		local
			veen: VEEN
			vsta2: VSTA2
		do
			if a_feature = Void then
					-- Not a valid feature name.
				create veen
				context.init_error (veen)
				veen.set_identifier (a_feature_name)
				error_handler.insert_error (veen)
				error_handler.raise_error
			else
					-- Not a valid feature for static access.	
				create vsta2
				context.init_error (vsta2)
				vsta2.set_non_static_feature (a_feature)
				Error_handler.insert_error (vsta2)
				Error_handler.raise_error
			end
		end

	valid_feature (a_feature: FEATURE_I): BOOLEAN is
			-- Is `a_feature' suitable for static access?
		do
			Result := a_feature /= Void and then a_feature.has_static_access
		end

	new_call_access (a_feature: FEATURE_I; a_type_i: TYPE_I): ACCESS_B is
			-- Create new node for associated AST node.
		local
			ext: EXTERNAL_B
			cl_type_i: CL_TYPE_I
		do
			cl_type_i ?= class_type.actual_type.type_i
			Result := a_feature.access_for_feature (a_type_i, cl_type_i)
			ext ?= Result
			if ext /= Void then
				ext.enable_static_call
			end
		end
		
feature -- Conveniences

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		local
			constant_i: CONSTANT_I
		do
			constant_i := associated_constant
			Result := constant_i /= Void and then constant_i.value.is_integer
		end

	good_character: BOOLEAN is
			-- Is the atomic a good character bound for multi-branch ?
		local
			constant_i: CONSTANT_I
		do
			constant_i := associated_constant
			Result := constant_i /= Void and then constant_i.value.is_character
		end

	make_integer: INT_CONST_VAL_B is
			-- Integer value
		local
			constant_i: CONSTANT_I
			integer_value: INTEGER_CONSTANT
		do
			constant_i := associated_constant
			integer_value ?= constant_i.value
			create Result.make (associated_class, integer_value.value, constant_i)
		end

	make_character: CHAR_CONST_VAL_B is
			-- Character value
		local
			constant_i: CONSTANT_I
			char_value: CHAR_VALUE_I
		do
			constant_i := associated_constant
			char_value ?= constant_i.value
			create Result.make (associated_class, char_value.character_value, constant_i)
		end
		
feature {AST_EIFFEL} -- Output

	string_value: STRING is
			-- Printed value of Current
		do
			check
				not_implemented: False
			end
		end
		
	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			dummy_call: ACCESS_INV_AS
			dummy_name: ID_AS
		do
			ctxt.begin

			ctxt.put_text_item (Ti_feature_keyword)
			ctxt.put_space
			
			ctxt.put_text_item (ti_L_curly)
			ctxt.format_ast (class_type)
			create dummy_call
			create dummy_name.initialize (ti_r_curly.image)
			dummy_call.set_feature_name (dummy_name)
			ctxt.format_ast (dummy_call)
			ctxt.set_type_creation (class_type)
			ctxt.need_dot
			ctxt.prepare_for_feature (feature_name, parameters)
			ctxt.put_current_feature
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			simple_format (ctxt)
		end

feature {NONE} -- Implementation

	assoc_class (a_constraint: TYPE_A): CLASS_C is
			-- Associated CLASS_C object to `class_type'.
		require else
			a_constraint_can_be_void: True
		do
			Result := context_last_type.associated_class
		end

invariant
	class_type_not_void: class_type /= Void
	feature_name_not_void: feature_name /= Void

end -- class STATIC_ACCESS_AS
