class S_CLUSTER_DATA_R332

inherit

	S_CLUSTER_DATA
		redefine
			reversed_engineered_file_name 
		end

creation

	make

feature

	reversed_engineered_file_name: STRING;
			-- Directory path of reversed engineered cluster
			-- (with environment variables not interpreted)

	set_reversed_engineered_file_name (fname: STRING) is
			-- Assign `fname' to `reversed_engineered_file_name'.
		do
			reversed_engineered_file_name := fname
		end

end
