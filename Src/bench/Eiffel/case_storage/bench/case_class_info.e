-- Class information relevant for EiffelCase
class CASE_CLASS_INFO

inherit
	
	SHARED_WORKBENCH;
	SHARED_INST_CONTEXT;
	SHARED_CASE_INFO;
	COMPILER_EXPORTER

creation

	make

feature {NONE}

	make (c: like classc) is
		do
			classc := c
		end;

feature {CASE_CLUSTER_INFO}

	s_class_data: S_CLASS_DATA;
			-- Class data for EiffelCase

	classc: CLASS_C;
			-- Class to be used for case information

	formulate_class_data (format_reg: FORMAT_REGISTRATION) is
			-- Record renamings, suppliers, parents, is_def ...
			-- in `s_class_data'. 
		require
			valid_classc: classc /= Void;
		local
			class_ast: CLASS_AS_B;
			record_relation_com: CASE_RECORD_SUPPLIERS;
			record_inherit_info_com: CASE_RECORD_INHERIT_INFO;
			record_chart_info_com: CASE_RECORD_CHART_INFO
		do
			format_reg.set_class (classc);
			format_reg.fill (True);
			class_ast := format_reg.target_ast;
			Inst_context.set_cluster (classc.cluster);
				-- Record index, and name
			s_class_data := class_ast.header_storage_info (classc);
				-- Record id
			s_class_data.set_id (classc.id.id);
				-- Record features, invariant
			format_reg.store_case_information (s_class_data);
				-- Record base file name
			s_class_data.set_file_name (classc.lace_class.base_name);
				-- Must have processed the features
				-- before we do the final process of the
				-- class for renamings and redefinitions.
				-- Record renamings, suppliers, parents, is_def ...
			Inst_context.set_cluster (Void);
			s_class_data.set_booleans (classc.is_deferred,
					False, 
					classc.feature_table.has_introduced_new_externals,
					False,
					False,
					classc.name.is_equal (System.root_class_name));
						-- The above is possible since there is
						-- no renaming of classes in the compiler yet.

				-- Record other case information
			!! record_relation_com.make (classc, s_class_data);
			record_relation_com.execute;
			!! record_inherit_info_com.make (classc, s_class_data);
			record_inherit_info_com.execute;
			info_reverse 
		end

	info_reverse  is
		 local                                                                                   
            fi : PLAIN_TEXT_FILE                                                                
            file_n : FILE_NAME                                                                  
            st : STRING 
	    error : BOOLEAN  
	    error2 : BOOLEAN                                                                                                                                   
        do                       
		if not error then
			!! file_n.make
			file_n.extend(classc.cluster.path)
			file_n.extend(classc.lace_class.name)
			file_n.add_extension ("cas")
			!! fi.make (file_n)
			if fi.exists then
				fi.open_read
				fi.read_line
				st := clone ( fi.last_string)
				if st.is_integer then
					s_class_data.set_x ( st.to_integer )
				else
					error2 := TRUE
				end
				fi.read_line
				st := clone (fi.last_string)
				if st.is_integer then
					s_class_data.set_y ( st.to_integer)
				else
					error2 := TRUE
				end
				fi.read_line
				s_class_data.set_color (fi.last_string)
				fi.read_line
				s_class_data.set_hidden ( fi.last_string)
				fi.close
			end
			if error2 then
				io.put_string("%Nerror1%N")
				s_class_data.set_x (0)
				s_class_data.set_y (0)
			end
		end
	rescue
		error := TRUE
		io.put_string ("%N repechage %N")
		if not fi.is_closed then
			fi.close
		end
		retry
	end

end
