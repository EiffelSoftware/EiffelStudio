indexing
	description:
		"Abstract description of a delayed access to an Eiffel feature%
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class DELAYED_ACCESS_FEAT_AS

inherit
	ACCESS_FEAT_AS
		redefine
			is_delayed, is_export_valid, is_equivalent
		end

creation
	make

feature -- Initialization

	make (fname : like feature_name; params : like parameters; v: like has_target) is
			-- Set `feature_name' to `fname', `parameters' to `params', `has_target' to `v'
		require
			name_exists : fname /= Void
		do
			feature_name := fname
			parameters := params
			has_target := v
		ensure
			name_set : feature_name = fname
			parameters_set : parameters = params
			has_target_set: has_target = v
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to current object?
		do
			Result := Precursor {ACCESS_FEAT_AS} (other) and has_target = other.has_target
		end
		
feature -- Status report

	is_delayed : BOOLEAN is True
			-- Delayed call.
			
	has_target: BOOLEAN
			-- Does current agent call use a target?
			
	is_export_valid (feat: FEATURE_I): BOOLEAN is
			-- Is the call export-valid ?
		do
			if has_target then
				Result := Precursor {ACCESS_FEAT_AS} (feat)
			else
				Result := True
			end
		end

end -- class DELAYED_ACCCES_FEAT_AS
