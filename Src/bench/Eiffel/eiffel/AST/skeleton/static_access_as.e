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
			type_check, is_equivalent, simple_format, format,
			valid_feature, report_error_for_feature,
			assoc_class, byte_node, context_last_type
		end
		
	ATOMIC_AS
		undefine
			fill_calls_list, replicate, format
		redefine
			type_check, byte_node,
			good_integer, good_character, make_integer, make_character
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
		local
			class_type_as: CLASS_TYPE_AS
		do
			class_type_as ?= class_type
			check
				class_type_as_not_void: class_type_as /= Void
			end
			Result := class_type_as.actual_type
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
			class_type_as: CLASS_TYPE_AS
			formal_as: FORMAL_AS
			vsta1: VSTA1
		do
				-- Check validity of class specification
			class_type_as ?= class_type
			if class_type_as = Void then
				formal_as ?= class_type
				check
					formal_as_not_void: formal_as /= Void
				end
				create vsta1.make (formal_as.dump, feature_name)
				vsta1.set_class (system.current_class)
				error_handler.insert_error (vsta1)
				error_handler.raise_error
			else
-- FIXME: Manu 10/29/2001: Do we really need to prevent static access on generic class?
-- 				if class_type_as.actual_type.has_generics then
-- 					create vsta1.make (class_type_as.class_name, feature_name)
-- 					vsta1.set_class (system.current_class)
-- 					error_handler.insert_error (vsta1)
-- 					error_handler.raise_error
-- 				end
			end

				-- Check validity of call.
			Precursor {ACCESS_FEAT_AS}
		end

	report_error_for_feature (a_feature: FEATURE_I) is
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
				veen.set_identifier (feature_name)
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

	byte_node: ACCESS_B is
			-- Associated byte code.
		local
			ext: EXTERNAL_B
			const_b: CONSTANT_B
			feat_b: FEATURE_B
			cl_type_i: CL_TYPE_I
		do
			Result := Precursor {ACCESS_FEAT_AS}
			ext ?= Result
			cl_type_i ?= class_type.actual_type.type_i
			if ext /= Void then
				ext.enable_static_call
				ext.set_written_in (associated_class.class_id)
				ext.set_static_class_type (cl_type_i)
			else
				const_b ?= Result
				check
					is_constant: const_b /= Void
				end
				feat_b ?= const_b.access
				check
					is_feature: feat_b /= Void
				end
				feat_b.set_precursor_type (cl_type_i)
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
			create Result.make (associated_class, char_value.char_val, constant_i)
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
		do
			ctxt.begin

			ctxt.put_text_item (Ti_feature_keyword)
			ctxt.put_space
			
			ctxt.put_text_item (ti_L_curly)
			ctxt.format_ast (class_type)
			ctxt.put_text_item (ti_R_curly)

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
