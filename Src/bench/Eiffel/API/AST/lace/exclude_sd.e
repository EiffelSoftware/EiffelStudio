class EXCLUDE_SD

inherit

	FILE_NAME_SD
		redefine
			adapt
		end;
	SHARED_ENV;

feature

	adapt is
			-- Exclude adaptation
		local
			path, f_name: STRING;
			cluster: CLUSTER_I;
			a_class: CLASS_I;
			file: EXTEND_FILE;
			class_name: STRING;
			vd12: VD12;
			vd13: VD13;
			vd14: VD14;
			vd21: VD21;
			vd22: VD22;
			ptr: ANY;
		do
			cluster := context.current_cluster;
			path := Environ.interpret (file__name);
			!!f_name.make (file__name.count + cluster.path.count);
			f_name.append (cluster.path);
			f_name.append ("/");
			f_name.append (path);

			!!file.make (f_name);
			if not file.exists then
				!!vd12;
				vd12.set_cluster (cluster);
				vd12.set_file_name (file__name);
				Error_handler.insert_error (vd12);
			elseif not file.readable then
				!!vd21;
				vd21.set_cluster (cluster);
				vd21.set_file_name (file__name);
				Error_handler.insert_error (vd21);
			else
				if file.open_read_error then
						-- Error when opening file
					!!vd22;
					vd22.set_file_name (file.name);
					Error_handler.insert_error (vd22);
				else
					file.close;
					ptr := file.file_pointer;
					class_name := c_clname ($ptr);
					if class_name = Void then
							-- No class in exclude file
						!!vd13;
						vd13.set_cluster (cluster);
						vd13.set_file_name (file__name);
						Error_handler.insert_error (vd13);
					else
						class_name.to_lower;
						a_class := cluster.classes.item (class_name);
						if a_class = Void then
							-- Aready a class named `class_name' in `cluster'.
							!!vd14;
							vd14.set_cluster (cluster);
							vd14.set_file_name (file__name);
							Error_handler.insert_error (vd14);
						else
							cluster.classes.remove (class_name);
						end;
					end;
				end;
			end;
		end;

feature {NONE} -- Externals

	c_clname (file_ptr: ANY): STRING is
			-- Class name read in file pointer `file_ptr'.
		external
			"C"
		end;

end
