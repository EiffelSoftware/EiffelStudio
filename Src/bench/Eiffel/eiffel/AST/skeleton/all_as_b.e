class ALL_AS

inherit

	FEATURE_SET_AS
		redefine
			format
		end

feature -- Initialization

	set is
			-- Yacc initialization
		do
		end;

	update
		(   export_adapt: EXPORT_ADAPTATION;
			export_status: EXPORT_I;
			parent: PARENT_C)
		is
			-- Update `export_adapt' with `export_status'.
		local
			vlel1: VLEL1;
		do
			if export_adapt.all_export = Void then
				export_adapt.set_all_export (export_status);
			else
				!!vlel1;
				vlel1.set_class_id (System.current_class.id);
				vlel1.set_parent_id (parent.parent_id);
				Error_handler.insert_error (vlel1);
			end;
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_keyword("all");
			ctxt.always_succeed;
		end;

end
