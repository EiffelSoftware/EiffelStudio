indexing

	description:
		"AST structure in Lace file for document option."
	date: "$Date$";
	revision: "$Revision $"

class DOCUMENT_SD

inherit

	OPTION_SD

feature -- Properties

	option_name: STRING is
		once
			Result := "document"
		end;

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			error_raised: BOOLEAN;
			class_name: STRING;
			document_name: STRING;
			path: PATH_NAME;
			f_name: FILE_NAME
		do
			if value /= Void then
				document_name := value.value;	
				if list = Void then
					!DIRECTORY_NAME! path.make_from_string (document_name);
				else
					!! f_name.make;
					f_name.set_file_name (document_name)
					path := f_name
				end;
				if not path.is_valid then
					error_raised := True;
					error (value);
				end;
			end;
			if not error_raised then
				if list = Void then
					--Context.current_cluster.set_document_path (document_name)
				else
					from
						list.start;
					until
						list.after
					loop
						class_name := clone (list.item);
						class_name.to_lower;
						--classes.item (class_name).set_document_path (document_name);
						list.forth;
					end;
				end
			end;
		end;

end -- class DOCUMENT_SD 
