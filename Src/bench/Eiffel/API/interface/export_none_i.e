class EXPORT_NONE_I 

inherit

	EXPORT_I
		redefine
			is_none
		end;
	SHARED_TEXT_ITEMS
	
feature 

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export valid for class `client' ?
		do
			-- Do nothing
		end;

	is_subset (other: EXPORT_I): BOOLEAN is
			-- Is Current clients a subset or equal with
			-- `other' clients?
		do
			Result := True;
		end;

	is_none: BOOLEAN is
			-- Is the current object an instance of EXPORT_NONE_I ?
		do
			Result := True;
		end;

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		do
			Result := other;
		end;

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status)]
		do
			Result := True;
		end;

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			Result := other.is_none
		end;


	trace is
			-- Debug purpose
		do
			io.error.putstring ("NONE");
		end;

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		do
			-- never true
		end;

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_text_item (ti_L_curly);
			ctxt.put_string ("NONE");
			ctxt.put_text_item (ti_R_curly)
		end;

feature -- Case storage

	storage_info: S_EXPORT_NONE_I is
		do
			!! Result
		end

end
