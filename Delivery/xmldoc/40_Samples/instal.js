var eiffel_studio = false;
var Eiffel_version = "Eiffel52";

function write_eiffel_studio_compiling_instruction (path_to_ace_file, ace_file_name) {
	document.write ("<p>To compile the example: </p> " +
					"<ul>" +
					"  <li>Launch EiffelStudio. </li>" +
					"  <li>Select <b>Use existing Ace (control file)</b> and click <b>OK</b>. </li>" +
					"  <li>Browse to <i>" + path_to_ace_file + "</i>. </li>" +
					"  <li>Choose <i>" + ace_file_name + ".ace</i> </li>" +
					"  <li>Choose the directory where the project will be compiled, by default the same directory containing the Ace file. </li>" +
					"  <li>Click <b>OK</b>. </li>" +
					"</ul>");
}

function write_envision_compiling_instruction (path_eifp_file, eifp_name) {
	document.write ("<p>Browse to the ENViSioN! installation directory. Open the samples directory, and browse for the corresponding .EIFP file. Double click this file to open the sample in Visual Studio .NET</p><p>Alernatively, you may select Start, Programs, Eiffel Envision, Samples from the start menu. A page containing information about the samples will be loaded. This page contains links that automatically open the sample in Visual Studio .NET</p>");
	document.write ("<p>&nbsp;</p>")
}

