indexing

	description: ""
	date: "$Date$";
	revision: "$Revision $"

class E_DYNAMIC_LIB

inherit

	SHARED_WORKBENCH
	SHARED_EIFFEL_PROJECT
	COMPILER_EXPORTER

feature -- Properties

	file_name: STRING 

feature -- Data

	dynamic_lib_exports: HASH_TABLE [LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE],INTEGER] is
		once
			!! Result.make(0)
		end

	modified: BOOLEAN

	set_modified(val:BOOLEAN) is
		do
			modified:=val
		end

feature -- DYNAMIC_LIB Exports processing.

	add_export_feature (d_class:CLASS_C; d_creation:E_FEATURE; d_routine:E_FEATURE; d_index:INTEGER) is
		require
			class_exists: d_class /=Void
			--creation_exists: d_creation /= Void
			routine_exists: d_routine /= Void
		local
			dl_exp: DYNAMIC_LIB_EXPORT_FEATURE
			dl_exp_list: LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE]
			dl_creation:like d_creation
			list_valid_creation: LINKED_LIST[E_FEATURE]
			has_feature: BOOLEAN
			i:INTEGER
			list_dl: LIST_CREATION_DYNAMIC_LIB
			tmp:STRING
		do
			if d_creation = Void then
				!! list_dl.make(d_class, d_routine,d_index)
				list_dl.choose_creation
			else
				dl_creation := d_creation
				if dl_creation.arguments /= Void and then d_creation /= d_routine then
					io.put_string ("%NThe creation procedure must have no argument.%N")
				elseif d_routine.is_attribute then
					io.put_string ("%NAn attribute can not be exported.%N")
				elseif d_routine.is_deferred then
					io.put_string ("%NA deferred feature can not be exported.%N")
				else
					set_modified (True)
					if dynamic_lib_exports.has (d_class.id.id) then
						dl_exp_list := dynamic_lib_exports.found_item
					else
						!! dl_exp_list.make
					end

						-- Check if the feature is or is not in the list.
					from
						dl_exp_list.start
					until
						has_feature = True or else dl_exp_list.after
					loop
						has_feature := (d_routine.id = dl_exp_list.item.dl_routine_id)
										and then ( d_creation.id = dl_exp_list.item.dl_creation.id )
						i := dl_exp_list.index
						dl_exp_list.forth
					end

					if not has_feature then
						!! dl_exp.make (d_class, dl_creation, d_routine)

						if (dl_creation /=Void) then
							dl_exp.set_dl_creation (dl_creation)
						end

						if (d_index /=0) then
							dl_exp.set_dl_index (d_index)
						end

						dl_exp_list.extend (dl_exp)
						dynamic_lib_exports.put (dl_exp_list, d_class.id.id)
					else
						dl_exp_list.go_i_th(i)
						dl_exp_list.remove
						if dl_exp_list.empty then
							dynamic_lib_exports.remove (d_class.id.id)
						end
					end

				end
			end
		end

   add_export_feature_from_file (t_class,t_creation,t_routine,t_index:STRING) is
		local
			class_list: LINKED_LIST [CLASS_I]
			class_i:CLASS_I
			dl_class:CLASS_C
			dl_creation:E_FEATURE
			dl_routine:E_FEATURE
			dl_index:INTEGER

			api_feature_table:E_FEATURE_TABLE
		do
			if t_class /= Void and then t_routine /= Void then

				class_list := Eiffel_universe.compiled_classes_with_name (t_class)
			
				if class_list.empty then
					class_list := Void;
					io.put_string("Can not process the line%N")
				elseif class_list.count = 1 then
					class_i := class_list.first --FIXME: if there are many cluster with the 
					class_list := Void
				else
					io.put_string("Can not process the line%N")
				end

				if class_i /= Void then 
					dl_class := class_i.compiled_class
					api_feature_table:= dl_class.api_feature_table
					if api_feature_table.has (t_routine) then
						dl_routine:= api_feature_table.found_item
					end

					if api_feature_table.has (t_creation) then
						dl_creation:= api_feature_table.found_item
-- 					elseif api_feature_table.has (t_creation) then
-- 						dl_creation:= api_feature_table.found_item
					end

					if t_index/=Void then
						dl_index:=t_index.to_integer
					else
						dl_index := 0
					end

					if dl_class /= Void and then
						dl_creation /= Void and then
						dl_routine /= Void then
						add_export_feature (dl_class,dl_creation,dl_routine,dl_index)
					end
				end
			end

		end

	parse_exports_from_file(f:PLAIN_TEXT_FILE):BOOLEAN is
		local
			lastline:STRING
			pos, mark:INTEGER
			done:INTEGER
			t_class:STRING
			t_creation:STRING
			t_routine:STRING
			t_index:STRING
		do
			dynamic_lib_exports.clear_all
			Result:=True
			from
				f.start
			until
				f.end_of_file
			loop
				f.readline
				lastline :=clone(f.last_string)

				lastline.left_adjust
				lastline.right_adjust

				if not lastline.substring(1,2).is_equal("--") and then not lastline.empty then
					from
						pos := 0
						done:= 0
					until
						pos >= lastline.count or done>0
					loop
						pos:=pos + 1
						if lastline.item(pos).is_equal('(') then
							done:=1
						elseif lastline.item(pos).is_equal(':') then
							done:=2
						end
					end

					if done > 0 then 
						mark:=pos+1

						--Class
						t_class:=lastline.substring(1,pos-1)

						if done=1 then
							--creation
							from
							until
								pos >= lastline.count or done>1
							loop
								pos:=pos + 1
								if lastline.item(pos).is_equal(')') then
									done:=3
								end
							end
						end

						if done>1 then
							if done=3 then
								t_creation:=lastline.substring(mark,pos-1)
							elseif done=2 then
								t_creation:=Void
							end
							--routine
							from 
								if done=2 then -- we already found ':'
									done:=1
									pos:=pos-1
								else
									done:=0
								end
							until
								pos >= lastline.count or done>1
							loop
								pos:=pos + 1
								if lastline.item(pos).is_equal(':') then
									done:=1
									mark:=pos+1
								elseif lastline.item(pos).is_equal('@') then
									done:=done+2
								end
							end
	
							if done=0 or else done=2 then
								Result:=False
							elseif done=1  then
								t_routine:=lastline.substring(mark,lastline.count)
							elseif done=3 then
								t_routine:=lastline.substring(mark,pos-1)
								t_index:=lastline.substring(pos+1,lastline.count)
							end
						else
							Result := False
						end -- if on "done>2"

					else
						Result := False
					end -- if on "done>1"					
				end -- if not "--"

				if t_class /= Void then
					t_class.left_adjust
					t_class.right_adjust
				end

				if t_creation /= Void then
					t_creation.left_adjust
					t_creation.right_adjust
				end

				if t_routine /= Void then
					t_routine.left_adjust
					t_routine.right_adjust
				end

				if t_index /= Void and then not t_index.empty then
					t_index.left_adjust
					t_index.right_adjust
				end

				if t_creation =Void and then t_routine /=Void then
					t_creation	:= clone(t_routine)
				end

				add_export_feature_from_file(t_class,t_creation,t_routine,t_index)

				t_class		:=Void
				t_creation	:=Void
				t_routine	:=Void
				t_index		:=Void

			end -- loop on file
			set_modified(False)
		end

feature -- Access

	text: STRING is
			-- Text of the Def file.
			-- Void if unreadable file
		require
			non_void_file_name: file_name /= Void
		local
			a_file: RAW_FILE
		do
			!! a_file.make (file_name)
			if a_file.exists and then a_file.is_readable then
				a_file.open_read
				a_file.readstream (a_file.count)
				a_file.close
				Result := clone (a_file.laststring)
			end
		end

	valid_file_name (f_name: STRING): BOOLEAN is
			-- Is `f_name' a valid file name (i.e
			-- does it exist and is it readable)?
		require
			valid_f_name: f_name /= Void
		local
			f: PLAIN_TEXT_FILE
		do
			!! f.make (f_name);
			Result := f.exists and then f.is_readable
		end


feature -- Setting

	set_file_name (f_name: STRING) is
			-- Set lace_file_name to `f_name'.
		require
			valid_f_name_if_not_void: f_name /= Void implies valid_file_name (f_name)
		do
			file_name := clone(f_name)
		ensure
			file_name_set: equal (f_name, file_name)
		end

end -- class E_DYNAMIC_LIB
 

