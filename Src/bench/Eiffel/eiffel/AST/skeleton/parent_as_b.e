-- Abstract description of a parent

class PARENT_AS

inherit

	AST_EIFFEL

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

feature -- Compiled parent computation

	parent_c: PARENT_C is
			-- Compiled version of a parent. The second pass needs:
			-- 1. Internal name for features, that means infix/prefix
			--    features must have a string name
			-- 2. Search table for renaming, redefining, defining and
			--    selecting clauses (which are more efficient than
			--    simple fixed lists for queries).
		local
			renaming_c: EXTEND_TABLE [STRING, STRING];
			rename_pair: RENAME_AS;
			vhrc2: VHRC2;
			export_adapt: EXPORT_ADAPTATION;
			s: STRING;
		do
			!!Result;
			Result.set_parent_type (type.actual_type);
			if exports /= Void then
				from
					!!export_adapt.make (5);
					Result.set_exports (export_adapt);
					exports.start;
				until
					exports.after
				loop
					exports.item.update (export_adapt, Result);
					exports.forth;
				end;
			end;
			if renaming /= Void then
				from
					!!renaming_c.make (renaming.count);
					Result.set_renaming (renaming_c);
					renaming.start;
				until
					renaming.after
				loop
					rename_pair := renaming.item;
					s := rename_pair.old_name.internal_name;
					if renaming_c.has (s) then
						!!vhrc2;
						vhrc2.set_class (System.current_class);
						vhrc2.set_parent (Current);
						vhrc2.set_conflict_name (rename_pair.old_name);
						Error_handler.insert_error (vhrc2);
					else
						renaming_c.put
							(rename_pair.new_name.internal_name, s);
					end;

					renaming.forth
				end;
			end;
			if redefining /= Void then
				Result.set_redefining (search_table (redefining, Redef));
			end;
			if undefining /= Void then
				Result.set_undefining (search_table (undefining, Undef));
			end;
			if selecting /= Void then
				Result.set_selecting (search_table (selecting, Selec));
			end;
		end;

	search_table(clause: like redefining; flag: INTEGER): SEARCH_TABLE [STRING]
	is
			-- Conversion of `clause' into a search table
		require
			clause_exists: clause /= Void;
		local
			vdrs3: VDRS3;
			vmss3: VMSS3;
			vdus4: VDUS4;
			s: STRING;
		do
			from
				!!Result.make (clause.count);
				clause.start
			until
				clause.after
			loop
				s := clause.item.internal_name;	
				if Result.has (s) then
						-- Twice the same name in a parent clause
					inspect
						flag
					when Redef then
						!!vdrs3;
					when Undef then
						!!vdus4;
						vdrs3 := vdus4;
					when Selec then
						!!vmss3;
						vdrs3 := vmss3;
					else
					end;
					vdrs3.set_class (System.current_class);
					vdrs3.set_parent (Current);
					vdrs3.set_feature_name (clause.item);
					Error_handler.insert_error (vdrs3);
				else
					Result.put (s)
				end;
	
				clause.forth;
			end;
		end;

	Redef: INTEGER is 1;
	Undef: INTEGER is 2;
	Selec: INTEGER is 3;

end
