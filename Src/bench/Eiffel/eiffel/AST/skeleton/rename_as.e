indexing

	description: "Abstract description of a renaming pair. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class RENAME_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			old_name ?= yacc_arg (0)
			new_name ?= yacc_arg (1)
		ensure then
			old_name_exists: old_name /= Void
			new_name_exists: new_name /= Void
		end

feature -- Attributes

	old_name: FEATURE_NAME
			-- Name of the renamed feature

	new_name: FEATURE_NAME
			-- New name

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (old_name, other.old_name) and
				equivalent (new_name, other.new_name)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.format_ast (old_name)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_As_keyword)
			ctxt.put_space
			ctxt.format_ast (new_name)
		end

feature {COMPILER_EXPORTER} -- Replication

	set_old_name (o: like old_name) is
		do
			old_name := o
		end

	set_new_name (n: like new_name) is
		do
			new_name := n
		end
	
end -- class RENAME_AS
