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
			initialize as feat_initialize
		export
			{NONE} feat_initialize
		redefine
			type_check, is_equivalent, simple_format,
			valid_feature, report_error_for_feature,
			associated_class
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

	associated_class (a_constraint: TYPE_A): CLASS_C is
			-- Associated CLASS_C object to `class_type'.
		require else
			a_constraint_can_be_void: True
		local
			class_type_as: CLASS_TYPE_AS
		do
			class_type_as ?= class_type
			check
				class_type_as_not_void: class_type_as /= Void
			end
			Result := class_type_as.actual_type.associated_class
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
			if class_type_as = void then
				formal_as ?= class_type
				check
					formal_as_not_void: formal_as /= void
				end
				create vsta1.make (formal_as.dump, feature_name)
				vsta1.set_class (system.current_class)
				error_handler.insert_error (vsta1)
				error_handler.raise_error
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
		local
			ext: EXTERNAL_I
			att: ATTRIBUTE_I
			extension: IL_EXTENSION_I
		do
			Result := a_feature /= Void and then a_feature.is_external
			if Result and then System.il_generation then
				ext ?= a_feature
				if ext /= Void then
					extension ?= ext.extension
				else
					att ?= a_feature
					extension ?= att.extension
				end
				Result := extension /= Void and then not extension.need_current (extension.type)
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_L_curly)
			ctxt.put_class_name (associated_class (Void).name)
			ctxt.put_text_item (ti_R_curly)
			ctxt.put_text_item (ti_space)

			Precursor {ACCESS_FEAT_AS} (ctxt)
		end

invariant
	class_type_not_void: class_type /= Void
	feature_name_not_void: feature_name /= Void

end -- class STATIC_ACCESS_AS
