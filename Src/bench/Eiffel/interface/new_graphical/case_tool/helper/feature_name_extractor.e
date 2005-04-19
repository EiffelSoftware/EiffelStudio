indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_NAME_EXTRACTOR
	
inherit
	SHARED_API_ROUTINES
	
feature -- Access

	feature_name (a_feature: FEATURE_AS): STRING is
			-- Return name of `a_feature' (i.e. "feature_name")
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := a_feature.feature_name.twin
		ensure
			Result_not_void: Result /= Void
		end
		
	feature_names (a_feature: FEATURE_AS): LIST [STRING] is
			-- Return all names of `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
			str: STRING
		do
			l_feature_names := a_feature.feature_names
			create {ARRAYED_LIST [STRING]} Result.make (l_feature_names.count)
			if l_feature_names.count = 1 then
				Result.extend (a_feature.feature_name.twin)
			else
				str := l_feature_names.first.visual_name.twin
				from
					l_feature_names.start
					l_feature_names.forth
				until
					l_feature_names.after
				loop
					Result.extend (l_feature_names.item.visual_name)
					l_feature_names.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	full_signature_compiled (a_feature: E_FEATURE): STRING is
			-- Parameter of `a_feature'. (i.e. (foo: LIST [BAR], bar: BAR): INTEGER
		require
			a_feature_not_void: a_feature /= Void
		local
			l_st: STRUCTURED_TEXT
		do
			create l_st.make
			a_feature.append_just_signature (l_st)
			Result := l_st.image
		ensure
			Result_not_void: Result /= Void
		end
		
	full_name_compiled (a_feature: E_FEATURE): STRING is
			-- Full name of `a_feature' (i.e. "feature_name (foo: FOO): LIST [FOO, BAR [FOO2]]")
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := feature_name (a_feature.ast) + full_signature_compiled (a_feature)
		ensure
			Result_not_void: Result /= Void
		end

	full_name (a_feature: FEATURE_AS): STRING is
			-- Full name of `a_feature' (i.e. "feature_name: LIST [FOO, BAR [FOO2]]")
			-- without parameters.
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := feature_name (a_feature) + full_signature (a_feature)
			if a_feature.body.content /= Void and then a_feature.is_deferred then
				Result.append ("*")
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	full_signature (a_feature: FEATURE_AS): STRING is
			-- Full signature of `a_feature' (i.e. : INTEGER [FOO [BAR], INTEGER])
		local
			l_body: BODY_AS
		do
			Result := ": "
			l_body := a_feature.body
			if l_body /= Void then
				Result.append (suppliers_name (l_body.type))
				Result.replace_substring_all ("[ ", "[")
			end
		ensure
			Result_not_void: Result /= Void
		end
		

feature {NONE} -- Implementation

	suppliers_name_compiled (a_type: TYPE_A): STRING is
			-- Try to extract as good as possible all supplier names
			-- from `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			l_generics: ARRAY [TYPE_A]
			i, nb: INTEGER
			formal: FORMAL_A
		do
			formal ?= a_type
			if formal = Void then
				Result := a_type.associated_class.name_in_upper.twin
			else
				Result := formal.dump
			end
			
			l_generics := a_type.generics
			
			if l_generics /= Void then
				Result.append (" [")
				from
					i := 1	
					nb := l_generics.count
				until
					i > nb
				loop
					Result.append (suppliers_name_compiled (l_generics.item (i)))
					i := i + 1
				end
				Result.append ("]")
			end
		ensure
			Result_not_void: Result /= Void
		end

	suppliers_name (a_type: TYPE_AS): STRING is
			-- Try to extract as good as possible all supplier names
			-- from `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			ct: CLASS_TYPE_AS
			g: EIFFEL_LIST [TYPE_AS]
		do
			Result := ""
			ct ?= a_type
			if ct /= Void then
				Result.append (supplier_name (class_i_by_name (ct.class_name)))
				g := ct.generics
				if g /= Void then
					Result.append (" [ ")
					from
						g.start
					until
						g.after
					loop
						if not g.isfirst then
							Result.append (", ")
						end
						Result.append (suppliers_name (g.item))
						g.forth
					end
					Result.append ("]")
				end
			end
		ensure
			Result_not_void: Result /= Void
		end
			
	supplier_name (sup: CLASS_I): STRING is
			-- Name of `sup'.
		do
			if sup /= Void then
				Result := sup.name.twin
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

end -- class FEATURE_NAME_EXTRACTOR
