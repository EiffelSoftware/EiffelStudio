indexing

	description: 
		"AST representation of a parent.";
	date: "Date: $";
	revision: "Revision: $"

class PARENT_AS

inherit

	AST_EIFFEL
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like type; rn: like renaming; e: like exports;
		u: like undefining; rd: like redefining; s: like selecting) is
			-- Create a new PARENT AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			renaming := rn
			exports := e
			undefining := u
			redefining := rd
			selecting := s
		ensure
			type_set: type = t
			renaming_set: renaming = rn
			exports_set: exports = e
			undefining_set: undefining = u
			redefininig_set: redefining = rd
			selecting_set: selecting = s
		end

feature {NONE} -- Initiliazation

	set is
			-- Yacc initialization
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

feature -- Properties

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

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (exports, other.exports) and
				equivalent (redefining, other.redefining) and
				equivalent (renaming, other.renaming) and
				equivalent (selecting, other.selecting) and
				equivalent (type, other.type) and
				equivalent (undefining, other.undefining)
		end

feature -- Access

	is_subset_of (other: like Current): BOOLEAN is
			-- Is Current a subset of `other'?
			--| Does Current content appear in `other'?
		require
			valid_other: other /= Void;
			same_type: equivalent (type, other.type);
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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			end_to_print: BOOLEAN
		do
			ctxt.format_ast (type);
			if renaming /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.put_text_item (ti_Rename_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Comma);
				ctxt.set_new_line_between_tokens;
				ctxt.format_ast (renaming)
				ctxt.exdent;
				ctxt.exdent;
				end_to_print := true
			end;
			if exports /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.put_text_item (ti_Export_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_new_line_between_tokens;
				ctxt.format_ast (exports)
				ctxt.exdent
				ctxt.exdent
				end_to_print := true
			end;
			if undefining /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.put_text_item (ti_Undefine_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Comma);
				ctxt.set_space_between_tokens;
				ctxt.format_ast (undefining)
				ctxt.exdent;
				ctxt.exdent;
				end_to_print := true
			end;
			if redefining /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.put_text_item (ti_Redefine_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Comma);
				ctxt.set_space_between_tokens;
				ctxt.format_ast (redefining)
				ctxt.exdent;
				ctxt.exdent;
				end_to_print := true
			end;
			if selecting /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.put_text_item (ti_Select_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Comma);
				ctxt.set_space_between_tokens;
				ctxt.format_ast (selecting)
				ctxt.exdent;
				ctxt.exdent;
				end_to_print := true
			end;
			if end_to_print then
				ctxt.indent;
				ctxt.new_line;
				ctxt.put_text_item (ti_End_keyword);
				ctxt.exdent
			end
		end;

feature {NONE} -- Merging

	is_list_subset_of (list, other_list: EIFFEL_LIST [AST_EIFFEL]): BOOLEAN
is
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
							found := equivalent (item, other_list.item);
							other_list.forth
						end
						Result := found;
						list.forth
					end
				end
			end
		end;

	merge_list (list, other_list: EIFFEL_LIST [AST_EIFFEL]): EIFFEL_LIST 
																[AST_EIFFEL] is
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
						found := equivalent (item, list.item);
						list.forth
					end;
					if found then
						temp_list.put_left (item);
					end;
					other_list.forth
				end;
				if not temp_list.empty then
					!! Result.make_filled (list.count + temp_list.count)
					Result.merge_after_position (0, list);
					Result.merge_after_position (list.count, temp_list);
				else
					Result := list
				end;
			end
		end;

feature {COMPILER_EXPORTER} -- Replication

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

feature {NONE}

	Redef: INTEGER is 1;
	Undef: INTEGER is 2;
	Selec: INTEGER is 3;

end -- class PARENT_AS
