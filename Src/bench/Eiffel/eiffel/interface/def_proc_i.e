class DEF_PROC_I 

inherit

	PROCEDURE_I			
		redefine
			is_deferred, has_entry, to_generate_in,
			to_melt_in, update_api, transfer_to
		end
	
feature -- Status Report

	has_entry: BOOLEAN is False;
			-- No polymorphic unit for deferred features

	is_deferred: BOOLEAN is
		do
			Result := True
		end;

feature -- Conversion

	to_melt_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature to be melted in class `a_class' ?
			-- (Deferred routines with pre or post conditions are
			-- melted)
		do
			Result := a_class.class_id = written_in and then 
					(has_precondition or else has_postcondition);
		end;

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature to be generated in class `a_class' ?
			-- (Deferred routines with pre or post conditions are
			-- not generated)
		do
			-- Do nothing
		end;

feature -- Basic Operation

	transfer_to (other: DEF_PROC_I) is
			-- Transfer datas form `other' into Current.
		do
			Precursor {PROCEDURE_I} (other)
			extension := other.extension
		end

feature -- Access

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_DEF_PROC_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DEF_PROC_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	extension: EXTERNAL_EXT_I
			-- Deferred external information

feature -- Element Change

	set_extension (an_extension: like extension) is
			-- Set `extension' with `an_extension'.
		require
			an_extension_not_void: an_extension /= Void
		do
			extension := an_extension
		ensure
			extension_set: extension = an_extension
		end

feature {NONE} -- Implementation

	update_api (f: E_ROUTINE) is
		do
			{PROCEDURE_I} Precursor (f);
			f.set_deferred (True);
		end;

end
