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
			-- Return name of `a_feature' (i.e. "feature_name, other_name")
		require
			a_feature_not_Void: a_feature /= Void
		local
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
			str: STRING
		do
			l_feature_names := a_feature.feature_names
			if l_feature_names.count = 1 then
				Result := a_feature.feature_name.twin
			else
				str := l_feature_names.first.visual_name.twin
				from
					l_feature_names.start
					l_feature_names.forth
				until
					l_feature_names.after
				loop
					str.append (", " + l_feature_names.item.visual_name)
					l_feature_names.forth
				end
				Result := str
			end
		ensure
			Result_not_Void: Result /= Void
		end

	full_signature_compiled (a_feature: E_FEATURE): STRING is
			-- Parameter of `a_feature'. (i.e. (foo: LIST [BAR], bar: BAR): INTEGER
		require
			a_feature_not_Void: a_feature /= Void
		local
			l_st: STRUCTURED_TEXT
		do
			create l_st.make
			a_feature.append_just_signature (l_st)
			Result := l_st.image
		ensure
			Result_not_Void: Result /= Void
		end
		
	full_name_compiled (a_feature: E_FEATURE): STRING is
			-- Full name of `a_feature' (i.e. "feature_name, another_name (foo: FOO): LIST [FOO, BAR [FOO2]]")
		require
			a_feature_not_Void: a_feature /= Void
		do
			Result := feature_name (a_feature.ast) + full_signature_compiled (a_feature)
		ensure
			Result_not_Void: Result /= Void
		end

	full_name (a_feature: FEATURE_AS): STRING is
			-- Full name of `a_feature' (i.e. "feature_name, another_name: LIST [FOO, BAR [FOO2]]")
			-- without parameters.
		require
			a_feature_not_Void: a_feature /= Void
		local
			l_body: BODY_AS
		do
			Result := feature_name (a_feature)
			
			if a_feature.body.content /= Void and then a_feature.is_deferred then
				Result.append ("*")
			end
			Result.append (": ")
			l_body := a_feature.body
			if l_body /= Void then
				Result.append (suppliers_name (l_body.type))
				Result.replace_substring_all ("[ ", "[")
			end
		ensure
			Result_not_Void: Result /= Void
		end

feature {NONE} -- Implementation

	suppliers_name_compiled (a_type: TYPE_A): STRING is
			-- Try to extract as good as possible all supplier names
			-- from `a_type'
		require
			a_type_not_Void: a_type /= Void
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
			a_type_not_Void: a_type /= Void
		local
			ct: CLASS_TYPE_AS
			bt: BASIC_TYPE
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
			else
				bt ?= a_type
				if bt /= Void then
					Result.append (supplier_name (bt.actual_type.associated_class.lace_class))
				end
			end
		ensure
			Result_not_void: Result /= Void
		end
			
	
--	suppliers_name (a_type: TYPE_AS): STRING is
--			-- Try to extract as good as possible all supplier names
--			-- from `a_type'
--		local
--			ct: CLASS_TYPE_AS
--			bt: BASIC_TYPE
--			g: EIFFEL_LIST [TYPE_AS]
--		do
--			Result := ""
--			ct ?= a_type
--			if ct /= Void then
--				Result.append (supplier_name (class_i_by_name (ct.class_name)))
--				g := ct.generics
--				if g /= Void then
--					Result.append (" [ ")
--					from
--						g.start
--					until
--						g.after
--					loop
--						if not g.isfirst then
--							Result.append (", ")
--						end
--						Result.append (suppliers_name (g.item))
--						g.forth
--					end
--					Result.append ("]")
--				end
--			else
--				bt ?= a_type
--				if bt /= Void then
--					Result.append (supplier_name (bt.actual_type.associated_class.lace_class))
--				end
--			end
--		ensure
--			Result_not_void: Result /= Void
--		end
--			
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
