class INCLUDE_SD

inherit

	FILE_NAME_SD
		redefine
			adapt
		end;
	SHARED_ENV;

feature

	adapt is
			-- Include adaptation
		local
			path, f_name: STRING;
			cluster: CLUSTER_I;
			a_class: CLASS_I;
			file: EXTEND_FILE;
			class_name: STRING;
			vd07: VD07;
			vd08: VD08;
			vd09: VD09;
			vd21: VD21;
			vd22: VD22;
		do
			cluster := context.current_cluster;
			path := Environ.interpret (file__name);
			!!f_name.make (file__name.count + cluster.path.count);
			f_name.append (cluster.path);
			f_name.append ("/");
			f_name.append (path);

			!!file.make (f_name);
			if not file.exists then
				!!vd07;
				vd07.set_cluster (cluster);
				vd07.set_file_name (file__name);
				Error_handler.insert_error (vd07);
			elseif not file.readable then
				!!vd21;
				vd21.set_cluster (cluster);
				vd21.set_file_name (file__name);
				Error_handler.insert_error (vd21);
			else
				if file.open_read_error then
						-- Error when opening
					!!vd22;
					vd22.set_cluster (cluster);
					vd22.set_file_name (f_name);
					Error_handler.insert_error (vd22);
				else
					class_name := c_clname (file.file_pointer);
					file.close;
					if class_name = Void then
							-- No class in include
						!!vd08;
						vd08.set_cluster (cluster);
						vd08.set_file_name (file__name);
						Error_handler.insert_error (vd08);
					else
						class_name.to_lower;
						a_class := cluster.classes.item (class_name);
						if a_class /= Void then
								-- Aready a class named `class_name' in
								-- `cluster'.
							!!vd09;
							vd09.set_cluster (cluster);
							vd09.set_file_name (file__name);
							vd09.set_a_class (a_class);
							Error_handler.insert_error (vd09);
						else
							!!a_class.make;
							a_class.set_class_name (class_name);
							a_class.set_base_name (path);
							a_class.set_cluster (cluster);
							a_class.set_date;
							cluster.classes.put (a_class, class_name);
						end;
					end;
				end;
			end;
		end;

feature {NONE} -- Externals

	c_clname (file_ptr: POINTER): STRING is
		external
			"C"
		end;

end
