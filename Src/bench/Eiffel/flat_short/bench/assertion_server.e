indexing

	description: 
		"Server for pre and post conditions.";
	date: "$Date$";
	revision: "$Revision $"

class ASSERTION_SERVER

inherit

	SHARED_SERVER

creation

	make, make_for_class_only, make_for_feature

feature -- Initialization

	make (f: FEATURE_TABLE; client: CLASS_C) is
			-- Initialize Current assertion server with
			-- features from feature_table `f' that is exported to 
			-- `client'.
		local
			feature_i: FEATURE_I;
			assert_id_set: ASSERT_ID_SET;
			chained_assert: CHAINED_ASSERTIONS;
			precursor: LINKED_LIST [CHAINED_ASSERTIONS];
			body_id, f_body_id: INTEGER;
			body_index: INTEGER;
			i: INTEGER;
			inh_ass: INH_ASSERT_INFO;
			written_in: INTEGER
		do
			!! precursors.make (f.count * 2);
			!! assertions.make (f.count);
			from
				f.start
			until
				f.after
			loop
				feature_i := f.item_for_iteration;
				f_body_id := feature_i.body_id;
				assert_id_set := feature_i.assert_id_set;
				written_in := feature_i.written_in; 
				if 
					(client = void
						or else feature_i.is_exported_for (client))
					and assert_id_set /= void 
					and then not assert_id_set.empty
				then
					!! chained_assert.make;
					assertions.put (chained_assert, feature_i.feature_id);
					from
						i := 1
					until
						i > assert_id_set.count
					loop
						inh_ass := assert_id_set.item (i);
						if inh_ass.has_assertion then
							body_index := inh_ass.body_index;
							precursor := precursors.item (body_index);
							if precursor = Void then
									-- Precursor body_id has not
									-- been recorded. Update precursor
									-- table.
								!! precursor.make;
								precursors.put (precursor, body_index);
									-- if a Precursor body_index have been
									-- found then it means more than one
									-- routine is referencing the body
									-- assertion.
							end;
							precursor.extend (chained_assert);
						end;
						i := i + 1;
					end;
				end;
				f.forth;
			end;
		end;			

	make_for_class_only is 
			-- Initialize structures for processing one class.
		do
			!! assertions.make (0);
			!! precursors.make (0);
		end;

	make_for_feature (f: FEATURE_I; ast: FEATURE_AS_B) is
			-- Initialize structures for processing feature `f'
			-- with ast structure `ast'.
		require
			valid_feat: f /= Void;
			valid_ast: ast /= Void
		local
			assert_id_set: ASSERT_ID_SET;
			i: INTEGER;
			inh_f: INH_ASSERT_INFO;
			body_id: INTEGER;
			chained_assert: CHAINED_ASSERTIONS;
			other_feat_as: FEATURE_AS_B;
			f_table: FEATURE_TABLE;
			feat: FEATURE_I;
			assertion: ROUTINE_ASSERTIONS;
			written_in: INTEGER
		do
			assert_id_set := f.assert_id_set;
			if assert_id_set /= Void then
				written_in := f.written_in;
				from
					!! chained_assert.make;
					i := 1
				until
					i > assert_id_set.count
				loop
					inh_f := assert_id_set.item (i);
					if inh_f.has_assertion then
						if written_in = inh_f.written_in then
							!! assertion.make_for_feature (f, ast);
							chained_assert.extend (assertion);
						else
							body_id := System.body_index_table.item 
								(inh_f.body_index);
							if Tmp_body_server.has (body_id) then
								other_feat_as := Tmp_body_server.item (body_id)
							elseif Body_server.has (body_id) then
								other_feat_as := Body_server.item (body_id)
							elseif Rep_feat_server.has (body_id) then
								other_feat_as := Rep_feat_server.item (body_id)
							end;
							if other_feat_as /= Void then
								f_table := Feat_tbl_server.item (inh_f.written_in);
								if f_table /= Void then
									feat := f_table.feature_of_body_id (body_id);
									if feat /= Void then
										!! assertion.make_for_feature 
												(feat, other_feat_as);
										chained_assert.extend (assertion);
									end
								end;
							end;
						end;
					end;
					i := i + 1;
				end;
				!! assertions.make (1);
				assertions.put (chained_assert, f.feature_id)	
			end
		end;

feature -- Properties
						
	assertions: EXTEND_TABLE [CHAINED_ASSERTIONS, INTEGER];
			-- Chained assertion for a feature hashed 
			-- on feature_id

	precursors: EXTEND_TABLE [LINKED_LIST [CHAINED_ASSERTIONS], INTEGER];
			-- List of precursor assertion hashed on feature body_index.
			-- An assertion of a body can be chained
			-- with a number of other routines, hence the need
			-- for the list for a given body_id. An object of 
			-- chained_assert will be referenced in the
			-- assertions table. 

feature -- Access

	chained_assertion_of_fid (fid: INTEGER): CHAINED_ASSERTIONS is
			-- Chained assertion for feature id `fid'
		do
			Result := assertions.item (fid)
		end;

feature -- Element change

	register (feat_adapter: FEATURE_ADAPTER) is
			-- Register precondition and postcondition of `feat_adapter'.
		require
			valid_adapter: feat_adapter /= Void
		local
			precursor: LINKED_LIST [CHAINED_ASSERTIONS];
			assertion: ROUTINE_ASSERTIONS;
		do
			if feat_adapter.body_index > 0 then
				precursor := precursors.item (feat_adapter.body_index);
				if precursor /= Void then
						-- Add a routine assertion for all precursor
						-- chained_assertion for `body_id'.
					!! assertion.make (feat_adapter);
					from
						precursor.start
					until
						precursor.after
					loop
						precursor.item.extend (assertion);
							-- As a result of referencing object, corresponding
							-- chained_assert objects will be updated in
							-- the assertions table.
						precursor.forth;
					end;
				end;
			end;
		end;

feature -- Removal

	wipe_out is
		do
			assertions.clear_all;
			precursors.clear_all;
		end;

feature -- Debug

	trace is
		do	
			io.error.putstring ("*** assertions ***%N");
			from
				assertions.start
			until
				assertions.after
			loop
				io.error.putstring ("feature id: ");
				io.error.putint (assertions.key_for_iteration);
				io.error.new_line;
				assertions.item_for_iteration.trace;
				io.error.new_line;
				assertions.forth
			end
			io.error.putstring ("%N*** Precursors ***%N");
			from
				precursors.start
			until
				precursors.after
			loop
				io.error.putstring ("body id: ");
				io.error.putint (precursors.key_for_iteration);
				io.error.new_line;
				from
					precursors.item_for_iteration.start
				until
					precursors.item_for_iteration.after
				loop
					precursors.item_for_iteration.forth
					precursors.item_for_iteration.item.trace;
					io.error.new_line;
				end
				precursors.forth
			end
		end
			
end	
