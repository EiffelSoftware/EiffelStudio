class FEATURE_LIST_AS_B

inherit

	FEATURE_LIST_AS
		redefine
			features
		end;

	FEATURE_SET_AS_B
		redefine
			format
		end

feature -- Attributes

	features: EIFFEL_LIST_B [FEATURE_NAME_B];
			-- List of feature names

feature -- Export status computing

	update (	export_adapt: EXPORT_ADAPTATION;
				export_status: EXPORT_I;
				parent: PARENT_C)
		is
			-- Update `export_adapt' with `export_status'.
		local
			feature_name: STRING;
			vlel3: VLEL3;
		do
			from
				features.start
			until
				features.after
			loop
				feature_name := features.item.internal_name;
				if not export_adapt.has (feature_name) then
					export_adapt.put (export_status, feature_name);
				else
					!!vlel3;
					vlel3.set_class (System.current_class);
					vlel3.set_parent (parent.parent);
					vlel3.set_feature_name (feature_name);
					Error_handler.insert_error (vlel3);
				end;
				features.forth;
			end;
		end;
	
	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
			--| what if multiple names in ancestors?
		do
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			ctxt.continue_on_failure;
			features.format (ctxt);
		end;
			
end -- class FEATURE_LIST_AS_B
