indexing
	description:
		"Abstract description of an access to the precursor of%
		%an Eiffel feature. "
	date: "$Date$"
	revision: "$Revision$"

class
	STATIC_ACCESS_AS

inherit
	ACCESS_FEAT_AS
		rename
			initialize as feat_initialize
		export
			{NONE} feat_initialize
		redefine
			is_equivalent,
			process
		end
		
	ATOMIC_AS
		
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

	class_type: EIFFEL_TYPE
			-- Type in which `feature_name' is defined.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
--			Result := Precursor {ACCESS_FEAT_AS} (other) and then
--				equivalent (class_type, other.class_type)
		end

		
feature {AST_EIFFEL} -- Output

	string_value: STRING is
			-- Printed value of Current
		do
			check
				not_implemented: False
			end
		end
		
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		local
--			dummy_call: ACCESS_INV_AS
--			dummy_name: ID_AS
--		do
--			ctxt.begin
--
--			ctxt.put_text_item (Ti_feature_keyword)
--			ctxt.put_space
--			
--			ctxt.put_text_item (ti_L_curly)
--			ctxt.format_ast (class_type)
--			create dummy_call
--			create dummy_name.initialize (ti_r_curly.image)
--			dummy_call.set_feature_name (dummy_name)
--			ctxt.format_ast (dummy_call)
--			ctxt.set_type_creation (class_type)
--			ctxt.need_dot
--			ctxt.prepare_for_feature (feature_name, parameters)
--			ctxt.put_current_feature
--			if ctxt.last_was_printed then
--				ctxt.commit
--			else
--				ctxt.rollback
--			end
--		end
--
--	format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			simple_format (ctxt)
--		end

invariant
	class_type_not_void: class_type /= Void
	feature_name_not_void: feature_name /= Void

end -- class STATIC_ACCESS_AS
