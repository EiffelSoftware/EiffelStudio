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

	selection_list: LINKED_LIST [CELL2 [E_FEATURE, E_CLASS]];
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

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		local
			info: CELL2 [E_FEATURE, E_CLASS];
		do
			from
				selection_list.start
			until
				selection_list.after
			loop
				info := selection_list.item;
				if (info.item2 = Void) then
					ow.put_string ("In current class: ");
				else
					ow.put_string ("In parent ");
					info.item2.append_name (ow);
					ow.put_string (": ");
				end;
				info.item1.append_signature (ow, info.item1.written_class);
				ow.new_line;

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
			cell2: cell2 [E_FEATURE, E_CLASS]
		do
			from
				!! selection_list.make;
				l.start
			until
				l.after
			loop
				info := l.item;
				if info.parent = Void then
					!! cell2.make (info.a_feature.api_feature, Void);
				else
					!! cell2.make (info.a_feature.api_feature, info.parent.parent.e_class);
				end;
				selection_list.extend (cell2)
				l.forth
			end
		end; 

end -- class VMRC3
