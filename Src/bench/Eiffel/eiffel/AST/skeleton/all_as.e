indexing
	description: "AST representation of an `all' structure."
	date: "$Date$"
	revision: "$Revision$"

class ALL_AS

inherit
	FEATURE_SET_AS

feature {AST_FACTORY} -- Initialization

	 initialize is
			-- Create a new ALL AST node.
		do
			-- Do nothing.
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Initialization

	update (export_adapt: EXPORT_ADAPTATION; export_status: EXPORT_I; parent: PARENT_C) is
			-- Update `export_adapt' with `export_status'.
		local
			vlel1: VLEL1
		do
			if export_adapt.all_export = Void then
				export_adapt.set_all_export (export_status)
			else
				!!vlel1
				vlel1.set_class (System.current_class)
				vlel1.set_parent (parent.parent)
				Error_handler.insert_error (vlel1)
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_All_keyword)
		end

end -- class ALL_AS
