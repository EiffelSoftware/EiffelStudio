class EXPORT_NONE_I 

inherit

	EXPORT_I
		redefine
			is_none
		end;
	SHARED_TEXT_ITEMS
	
feature -- Properties

	is_none: BOOLEAN is
			-- Is the current object an instance of EXPORT_NONE_I ?
		do
			Result := True;
		end;

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			Result := other.is_none
		end;

feature -- Comparison

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		do
			-- never true
		end;

feature {COMPILER_EXPORTER}

	is_subset (other: EXPORT_I): BOOLEAN is
			-- Is Current clients a subset or equal with
			-- `other' clients?
		do
			Result := True;
		end;

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status)]
		do
			Result := True;
		end;

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export valid for class `client' ?
		do
			-- Do nothing
		end;

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		do
			Result := other;
		end;

	trace is
			-- Debug purpose
		do
			io.error.putstring ("NONE");
		end;

feature {COMPILER_EXPORTER}

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_text_item (ti_L_curly);
			ctxt.put_string ("NONE");
			ctxt.put_text_item_without_tabs (ti_R_curly);
		end;

end
