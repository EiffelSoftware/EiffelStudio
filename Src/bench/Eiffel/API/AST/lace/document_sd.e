indexing
	description: "AST structure in Lace file for document option."
	date: "$Date$";
	revision: "$Revision$"

class DOCUMENT_SD

inherit

	OPTION_SD

feature -- Properties

	option_name: STRING is "document"

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			document_name: STRING;
			d_name: DIRECTORY_NAME;
			error_raised: BOOLEAN
		do
			if value /= Void then
				document_name := value.value;	
				if list = Void then
					!! d_name.make_from_string (document_name);
				else
					error_raised := True;
					error (value);
				end;
			end;
			if not error_raised then
				if list = Void then
					Context.current_cluster.set_document_path (d_name)
				end
			end;
		end;

end -- class DOCUMENT_SD 
