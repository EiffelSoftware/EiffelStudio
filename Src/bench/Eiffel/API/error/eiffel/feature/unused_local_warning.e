indexing
	description: "Warning for unreferenced local variable within a feature."
	date: "$Date$";
	revision: "$Revision$"

class UNUSED_LOCAL_WARNING

inherit
	EIFFEL_WARNING
		redefine
			build_explain
		end
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_class: like associated_class; a_feat: FEATURE_I) is
			-- New instance of unused local warnings in `a_feat' from `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feat_not_voiid: a_feat /= Void
		do
			associated_class := a_class
			associated_feature := a_feat.api_feature (a_feat.written_in)
			create unused_locals.make
		ensure
			associated_class_set: associated_class = a_class
		end
		
feature -- Properties

	associated_feature: E_FEATURE
			-- Feature containing the unused local variable

	unused_locals: LINKED_LIST [TUPLE [STRING, TYPE_A]]
			-- List of unused local names and type.

	code: STRING is
			-- Error code
		do
			Result := "Unused_local_warning"
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			l_name: STRING
			l_type: TYPE_A
		do
			st.add_string ("Class: ")
			associated_class.append_name (st)
			st.add_new_line
			st.add_string ("Feature: ")
			associated_feature.append_name (st)
			st.add_new_line
			if unused_locals.count = 1 then
				st.add_string ("Unused local is: ")
			else
				st.add_string ("Unused locals are: ")
			end
			st.add_new_line
			
			from
				unused_locals.start
			until
				unused_locals.after
			loop
				l_name ?= unused_locals.item.item (1)
				l_type ?= unused_locals.item.item (2)
				check
					l_name_not_void: l_name /= Void
					l_type_not_void: l_type /= Void
				end
				st.add_indent
				st.add_string (l_name)
				st.add_string (": ")
				l_type.append_to (st)
				st.add_new_line
				unused_locals.forth
			end
		end

feature {COMPILER_EXPORTER}

	add_unused_local (s: STRING; t: TYPE_A) is
			-- Extend `unused_locals' with unused local `s' of type `t'.
		require
			s_not_void: s /= Void
			t_not_void: t /= Void
		do
			unused_locals.extend ([s, t])
		ensure
			unused_locals_updated: unused_locals.count = (old unused_locals.count) + 1
		end

invariant
	associated_class_not_void: associated_class /= Void
	associated_feature_not_void: associated_feature /= Void
	unused_locals_not_void: unused_locals /= Void
	
end -- class UNUSED_LOCAL_WARNING
