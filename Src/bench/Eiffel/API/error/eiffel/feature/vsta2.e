indexing
	description: "Error when feature is not valid for static access."
	date: "$Date$"
	revision: "$Revision$"

class VSTA2 

inherit
	FEATURE_ERROR
		redefine
			build_explain, is_defined, subcode
		end

feature -- Access

	code: STRING is "VSTA"
			-- Error code
			
	subcode: INTEGER is 2

	non_static_feature: E_FEATURE
			-- Name of routine on which non-valid static access is performed.

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then	
				non_static_feature /= Void
		ensure then
			valid_non_static_feature: Result implies non_static_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			ec: CLASS_C
		do
			ec := non_static_feature.written_class
			st.add_string ("Not valid for static call: ")
			non_static_feature.append_name (st)
			st.add_string (" from ")
			ec.append_name (st)
			st.add_new_line
		end

feature {ACCESS_FEAT_AS, CREATION_EXPR_AS, INTERVAL_AS} -- Setting

	set_non_static_feature (f: FEATURE_I) is
		require
			valid_f: f /= Void
		do
			non_static_feature := f.api_feature (f.written_in)
		end

end -- class VSTA2
