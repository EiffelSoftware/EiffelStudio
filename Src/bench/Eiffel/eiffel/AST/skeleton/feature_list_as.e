indexing
	description: "List of feature names.";
	date: "$Date$";
	revision: "$Revision$"

class FEATURE_LIST_AS

inherit
	FEATURE_SET_AS
		redefine
			format
		end

feature {AST_FACTORY} -- Initialization

	initialize (f: like features) is
			-- Create a new FEATURE_LIST AST node.
		require
			f_not_void: f /= Void
		do
			features := f
		ensure
			features_set: features = f
		end

feature -- Attributes

	features: EIFFEL_LIST [FEATURE_NAME]
			-- List of feature names

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (features, other.features)
		end

feature -- Export status computing

	update (export_adapt: EXPORT_ADAPTATION; export_status: EXPORT_I; parent: PARENT_C) is
			-- Update `export_adapt' with `export_status'.
		local
			feature_name: STRING
			vlel3: VLEL3
		do
			from
				features.start
			until
				features.after
			loop
				feature_name := features.item.internal_name
				if not export_adapt.has (feature_name) then
					export_adapt.put (export_status, feature_name)
				else
					!! vlel3
					vlel3.set_class (System.current_class)
					vlel3.set_parent (parent.parent)
					vlel3.set_feature_name (feature_name)
					Error_handler.insert_error (vlel3)
				end
				features.forth
			end
		end
	
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
			--| what if multiple names in ancestors?
		do
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens
			ctxt.continue_on_failure
			features.format (ctxt)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens
			features.simple_format (ctxt)
		end
			
end -- class FEATURE_LIST_AS
