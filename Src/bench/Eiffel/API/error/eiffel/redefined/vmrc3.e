indexing

	description: 
		"Error when a selection is needed.";
	date: "$Date$";
	revision: "$Revision $"

class VMRC3 obsolete "NOT DEFINED IN THE BOOK"

inherit

	VMRC
		redefine
			build_explain, subcode, is_defined
		end
	
feature -- Property

	selection_list: LINKED_LIST [CELL2 [E_FEATURE, CLASS_C]];
			-- Info about the features to select

	subcode: INTEGER is 2;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				selection_list /= Void
		ensure then
			valid_selection_list: Result implies selection_list /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		local
			info: CELL2 [E_FEATURE, CLASS_C];
		do
			from
				selection_list.start
			until
				selection_list.after
			loop
				info := selection_list.item;
				if (info.item2 = Void) then
					st.add_string ("In current class: ");
				else
					st.add_string ("In parent ");
					info.item2.append_name (st);
					st.add_string (": ");
				end;
				info.item1.append_signature (st);
				st.add_new_line;

				selection_list.forth;
			end;
		end;

feature {COMPILER_EXPORTER}

	set_selection_list (l: SELECTION_LIST) is
			-- Assign `l' to `selection_list'.
		require
			valid_l: l /= Void
		local
			info: INHERIT_INFO;
			cell2: cell2 [E_FEATURE, CLASS_C];
			api_feature: E_FEATURE
		do
			from
				!! selection_list.make;
				l.start
			until
				l.after
			loop
				info := l.item;
				api_feature := info.a_feature.api_feature (info.a_feature.written_in);
				if info.parent = Void then
					!! cell2.make (api_feature, Void);
				else
					!! cell2.make (api_feature, info.parent.parent);
				end;
				selection_list.extend (cell2)
				l.forth
			end
		end; 

end -- class VMRC3
