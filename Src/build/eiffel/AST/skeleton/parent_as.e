-- Abstract description of a parent

class PARENT_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end

feature -- Attributes

	type: CLASS_TYPE_AS;
			-- Parent type

	renaming: EIFFEL_LIST [RENAME_AS];
			-- Rename clause

	exports: EIFFEL_LIST [EXPORT_ITEM_AS];
			-- Exports for parent

	redefining: EIFFEL_LIST [FEATURE_NAME];
			-- Redefining clause

	undefining: EIFFEL_LIST [FEATURE_NAME];
			-- Define clause

	selecting: EIFFEL_LIST [FEATURE_NAME];
			-- Select clause

feature -- Initilization
	
	set is
			-- Yacc initilization
		do
			type ?= yacc_arg (0);
			renaming ?= yacc_arg (1);
			exports ?= yacc_arg (2);
			undefining ?= yacc_arg (3);
			redefining ?= yacc_arg (4);
			selecting ?= yacc_arg (5);
		ensure then
			type_exists: type /= Void
		end;

	Redef: INTEGER is 1;
	Undef: INTEGER is 2;
	Selec: INTEGER is 3;

feature -- Formatting

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			end_to_print: BOOLEAN
		do
			ctxt.begin;
			type.simple_format (ctxt);
			if renaming /= Void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.put_text_item (ti_Rename_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Comma);
				ctxt.new_line_between_tokens;
				renaming.simple_format (ctxt)
				ctxt.indent_one_less;
				ctxt.indent_one_less;
				end_to_print := true
			end;
			if exports /= Void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.put_text_item (ti_Export_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.new_line_between_tokens;
				exports.simple_format (ctxt)
				ctxt.indent_one_less
				ctxt.indent_one_less
				end_to_print := true
			end;
			if undefining /= Void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.put_text_item (ti_Undefine_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Comma);
				ctxt.space_between_tokens;
				undefining.simple_format (ctxt)
				ctxt.indent_one_less;
				ctxt.indent_one_less;
				end_to_print := true
			end;
			if redefining /= Void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.put_text_item (ti_Redefine_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Comma);
				ctxt.space_between_tokens;
				redefining.simple_format (ctxt)
				ctxt.indent_one_less;
				ctxt.indent_one_less;
				end_to_print := true
			end;
			if selecting /= Void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.put_text_item (ti_Select_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Comma);
				ctxt.space_between_tokens;
				selecting.simple_format (ctxt)
				ctxt.indent_one_less;
				ctxt.indent_one_less;
				end_to_print := true
			end;
			if end_to_print then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.put_text_item (ti_End_keyword);
				ctxt.indent_one_less
			end
			ctxt.indent_one_less;
			ctxt.commit
		end;

	set_exports (e: like exports) is
		do
			exports := e
		end;

	set_type (t: like type) is
		do
			type := t
		end;

	set_renaming (r: like renaming) is
		do
			renaming := r
		end;

	set_redefining (r: like redefining) is
		do
			redefining := r
		end;

	set_selecting (s: like selecting) is
		do
			selecting := s
		end;

	set_undefining (u: like undefining) is
		do
			undefining := u
		end;

feature -- Merging

	is_subset_of (other: like Current): BOOLEAN is
			-- Is Current a subset of `other'?
			--| Does Current content appear in `other'?
		require
			valid_other: other /= Void;
			same_type: deep_equal (type, other.type);
		do
			Result := is_list_subset_of (exports, other.exports);
			if Result then
				Result := is_list_subset_of (redefining, other.redefining);
			end;
			if Result then
				Result := is_list_subset_of (renaming, other.renaming);
			end;
			if Result then
				Result := is_list_subset_of (selecting, other.selecting);
			end;
			if Result then
				Result := is_list_subset_of (undefining, other.undefining);
			end;
		end;

feature {NONE} -- Merging

	is_list_subset_of (list, other_list: EIFFEL_LIST [AST_EIFFEL]): BOOLEAN is
			-- Is list `list' a subset of `other_list'?
		local
			item: AST_EIFFEL;
			found: BOOLEAN
		do
			Result := True;
			if list /= Void then
				if other_list = Void then
					Result := False
				else
					from
						list.start;
					until
						list.after or else not Result
					loop
						item := list.item
						from
							found := False;
							other_list.start
						until
							other_list.after or else found
						loop
							found := deep_equal (item, other_list.item);
							other_list.forth
						end
						Result := found;
						list.forth
					end
				end
			end
		end;

	merge_list (list, other_list: EIFFEL_LIST [AST_EIFFEL]): EIFFEL_LIST [AST_EIFFEL] is
			-- Merge `other_list' with `list'?
		local
			item: AST_EIFFEL;
			temp_list: LINKED_LIST [AST_EIFFEL];
			new_list: EIFFEL_LIST [AST_EIFFEL];
			found: BOOLEAN
		do
			if list = Void then
				Result := other_list
			elseif other_list = Void then
				Result := Void
			else
				!! temp_list.make;
				Result := list;
				from
					other_list.start
				until
					other_list.after or else found
				loop
					item := other_list.item
					from
						found := False;
						list.start
					until
						list.after or else found
					loop
						found := deep_equal (item, list.item);
						list.forth
					end;
					if found then
						temp_list.put_left (item);
					end;
					other_list.forth
				end;
				if not temp_list.empty then
					!! Result.make (list.count + temp_list.count)
					Result.merge_after_position (0, list);
					Result.merge_after_position (list.count, temp_list);
				else
					Result := list
				end;
			end
		end;

end
