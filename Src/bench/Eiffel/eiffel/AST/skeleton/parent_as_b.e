indexing

	description: "Abstract description of a parent. Version for Bench.";
	date: "Date: $";
	revision: "Revision: $"

class PARENT_AS_B

inherit

	PARENT_AS
		redefine
			type, renaming, exports,
			redefining, undefining,
			selecting
		end;

	AST_EIFFEL_B

feature -- Attributes

	type: CLASS_TYPE_AS_B;
			-- Parent type

	renaming: EIFFEL_LIST_B [RENAME_AS_B];
			-- Rename clause

	exports: EIFFEL_LIST_B [EXPORT_ITEM_AS_B];
			-- Exports for parent

	redefining: EIFFEL_LIST_B [FEATURE_NAME_B];
			-- Redefining clause

	undefining: EIFFEL_LIST_B [FEATURE_NAME_B];
			-- Define clause

	selecting: EIFFEL_LIST_B [FEATURE_NAME_B];
			-- Select clause

feature -- Compiled parent computation

	parent_c: PARENT_C is
			-- Compiled version of a parent. The second pass needs:
			-- 1. Internal name for features, that means infix/prefix
			--	features must have a string name
			-- 2. Search table for renaming, redefining, defining and
			--	selecting clauses (which are more efficient than
			--	simple fixed lists for queries).
		local
			renaming_c: EXTEND_TABLE [STRING, STRING];
			rename_pair: RENAME_AS_B;
			old_name, new_name: FEATURE_NAME_B;
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
					old_name := rename_pair.old_name;
					new_name := rename_pair.new_name;
					s := old_name.internal_name;
					if renaming_c.has (s) then
						!!vhrc2;
						vhrc2.set_class (System.current_class);
						vhrc2.set_parent (Result.parent);
						vhrc2.set_feature_name (old_name.internal_name);
						Error_handler.insert_error (vhrc2);
					else
						renaming_c.put (new_name.internal_name, s);
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
					vdrs3.set_parent_name (type.class_name);
					vdrs3.set_feature_name (clause.item.internal_name);
					Error_handler.insert_error (vdrs3);
				else
					Result.put (s)
				end;
	
				clause.forth;
			end;
		end;

end -- class PARENT_AS_B
