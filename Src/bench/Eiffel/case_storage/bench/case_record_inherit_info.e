-- Inheritance information relevant for EiffelCase
class CASE_RECORD_INHERIT_INFO

inherit
	
	SHARED_SERVER;
	CASE_CLASS_COMMAND;
	COMPILER_EXPORTER

creation

	make

feature 

	execute is
			-- Record renamings and redefinitions for class `classc' into
			-- `s_class_data'.
		local
			class_info: CLASS_INFO;
			parents: PARENT_LIST
		do
				-- Get class_info directly from disk
			class_info := Class_info_server.disk_item (classc.id);
			parents := class_info.parents;
			record_parents (parents);
			record_renamings (parents);
			record_redefinitions (parents);
		end;

feature {NONE} -- Recording information for eiffelcase

	record_parents (parents: PARENT_LIST) is
			-- Record parents for class `classc' into `s_class_data'.
		require
			valid_parents: parents /= Void
		local
			no_repeated_parents: LINKED_SET [CLASS_ID];
			p_l: ARRAYED_LIST [S_INHERIT_DATA];
			inherit_data: S_INHERIT_DATA;
			parent_id: CLASS_ID
			list_tmp : ARRAY [ TYPE_A ]
			list_gene : LINKED_LIST [ S_GENERIC_DATA ]
			gene : S_GENERIC_DATA
			e_class : E_CLASS
			i : INTEGER
		do
			from
				!! no_repeated_parents.make;
				no_repeated_parents.compare_objects;
				!! p_l.make (20) -- hihi
				parents.start
			until
				parents.after
			loop
				parent_id := parents.item.parent_id;
				if not parent_id.is_equal (System.any_id) then
					no_repeated_parents.extend (parent_id)
				end;

				if
					parents.item.parent_type /= Void 
					and then parents.item.parent_type.generics /= Void and then
					not parents.item.parent_type.generics.empty
				then
						-- the link carries genericity
					!! list_tmp.make (0,15)
					list_tmp := parents.item.parent_type.generics
					!! list_gene.make
					from 
						i := list_tmp.lower
					until
						i > list_tmp.upper
					loop
						e_class := list_tmp.item(i).associated_eclass
						if e_class /= Void then
							!! gene.make ( e_class.name, Void )
						else
							!! gene.make ( "G", Void )
						end
						list_gene.extend (gene)
						i := i + 1
					end 
				end

				!! inherit_data
				inherit_data.set_class_links ( classc.id.id, parent_id.id )
				if list_gene /= Void then
					inherit_data.set_generics ( list_gene )
				end
				p_l.extend ( inherit_data )
				parents.forth
			end

debug ("CASE")
	io.error.putstring ("%T%T%TParent: ");
	io.error.putstring (System.class_of_id (no_repeated_parents.item).name);
	io.error.new_line;
end
			if not p_l.empty then
				s_class_data.set_heir_links (p_l);
			end
		end;

	record_renamings (parents: PARENT_LIST) is
			-- Record renamings for class `classc' into `s_class_data'.
		require	
			valid_parents: parents /= Void
		local
			renaming: EXTEND_TABLE [STRING, STRING];
			features: ARRAYED_LIST [S_FEATURE_DATA];
			feature_data: S_FEATURE_DATA;
			feature_data_r1: S_FEATURE_DATA_R331;
			parent: PARENT_C;
			found: BOOLEAN;
			origin_class: CLASS_C;
			origin_feature: FEATURE_I;
			rename_data: S_RENAME_DATA;
			feature_i: FEATURE_I;
			feature_ast: FEATURE_AS_B;
			parent_c: PARENT_C;
			temp: STRING
		do
			features := s_class_data.features;
				-- Note: There is a test made to see if then compiler information
				-- if valid (i.e whether a feature exists and so on) and
				-- if everything was based solely on the compiler information
				-- then these test are not necessary.
				-- However, the user may modify the class which makes the 
				-- analyzed AST structure not match the compiler structures.
			from
				parents.start
			until
				parents.after
			loop
				parent_c := parents.item;
				renaming := parent_c.renaming;
				if renaming /= Void then
					from
						renaming.start
					until
						renaming.after
					loop
						from
							found := False;
							features.start
						until
							found or else features.after
						loop
							feature_data := features.item;
							found := feature_data.name.is_equal (renaming.item_for_iteration)
							features.forth
						end
						origin_class := parent_c.parent_type.associated_class;
						origin_feature := origin_class.feature_table.item 
												(renaming.key_for_iteration);
						!! rename_data;
						if origin_feature /= Void then
							rename_data.set_origin_feature_key (origin_feature.case_feature_key);
						else
								-- Should not really happen but just in case 
								-- (see above comments) ...
							!! temp.make (0);
							temp.append (renaming.key_for_iteration);
							rename_data.set_free_form_text (renaming.key_for_iteration);
						end;
debug ("CASE")
	io.error.putstring ("%T%TRenamed feature: old - ");
	io.error.putstring (renaming.key_for_iteration);
	io.error.putstring (" new - ");
	io.error.putstring (renaming.item_for_iteration);
	if origin_feature = Void then
		io.error.putstring (".NOT Found.");
	else
		io.error.putstring (".Found.");
	end
	if found then
		io.error.putstring ("Redefined");
		io.error.putstring ("Not Redefined");
	end
	io.error.new_line;
end;
						if not found then
								-- This means that the feature is not redefined.
							!! temp.make (0);
							temp.append (renaming.item_for_iteration);
							!! feature_data_r1.make (temp);
							feature_data_r1.set_reversed_engineered;
							feature_data := feature_data_r1;
							feature_i := classc.feature_table.item 
														(renaming.key_for_iteration);
							if feature_i /= Void then
								-- This is for BON. The renamed feature is
								-- displayed in the specification page.
								feature_ast := Body_server.item (feature_i.body_id);
								feature_ast.store_information (feature_data);
								feature_i.store_case_information (feature_data);
								s_class_data.add_feature (feature_data, 
									parent_c.new_export_for (temp))
							end
						end;
						feature_data.set_rename_clause (rename_data);
						renaming.forth
					end;
				end;
				parents.forth
			end;
		end;

	record_redefinitions (parents: PARENT_LIST) is
			-- Record redefinitions for class `classc' into `s_class_data'.
		require
			valid_parents: parents /= Void
		local
			class_info: CLASS_INFO;
			redefining: SEARCH_TABLE [STRING];
			features: ARRAYED_LIST [S_FEATURE_DATA];
			feature_data: S_FEATURE_DATA
			parent: PARENT_C;
			found: BOOLEAN;
		do
			features := s_class_data.features;
			from
				parents.start
			until
				parents.after
			loop
				redefining := parents.item.redefining;
				if redefining /= Void then
					from
						redefining.start
					until
						redefining.after
					loop
						from
							found := False;
							features.start
						until
							found or else features.after
						loop
							feature_data := features.item;
							found := feature_data.name.is_equal (redefining.item_for_iteration)
							features.forth
						end;
						if found then
							-- It should always be found but on the other hand if
							-- the user modified the class the Current AST structure
							-- may not match the compiler structures
							feature_data.set_is_redefined
debug ("CASE")
	io.error.putstring ("%T%TRedefine feature: ");
	io.error.putstring (feature_data.name);
	io.error.new_line;
end;
						end;
						redefining.forth
					end;
				end;
				parents.forth
			end;
			s_class_data.set_feature_number (features.count);
			if not classc.is_deferred then
					-- Determine if classc is effective.
					-- It is effective if any of features are
					-- redefined or effective.
				if redefining /= Void and then not (redefining.count = 0) then
					s_class_data.set_is_effective 
				else
					from
						features.start
					until
						features.after or features.item.is_effective
					loop
						features.forth
					end;
					if not features.after then
						s_class_data.set_is_effective 
					end
				end	
			end
		end;

end
