indexing

	description: 
		"Saves source class where invariant ast was defined%
		%which is to be used in then format context."
	date: "$Date$";
	revision: "$Revision $"

class INVARIANT_ADAPTER

feature -- Update

	register (invariant_ast: like ast; format_reg: FORMAT_REGISTRATION) is
			-- Initialize and register Current with invariant ast
			-- `ast'.
		require
			valid_ast: invariant_ast /= Void;
			valid_reg: format_reg /= Void
		do
			ast := invariant_ast;
			source_class := format_reg.current_class;
			format_reg.record_invariant (Current)
		ensure
			ast = invariant_ast;
			source_class = format_reg.current_class
		end;

feature -- Properties

	ast: INVARIANT_AS
			-- Associated invariant AST
	
	source_class: CLASS_C;
			-- Where invariant was defined

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
			-- Format invariant.
		do
			ctxt.begin;
			ctxt.set_source_class (source_class);
			ast.format (ctxt);
		end;

end -- class class INVARIANT_ADAPTER
