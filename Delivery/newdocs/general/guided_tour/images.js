<!--------------------------------------------------->
<SCRIPT LANGUAGE="JScript">

	// Default values
	var left = 500;
	var top = 0;
	var height = 500;
	var width = 500;
	var oNewWindow = 0;

	function ImageClick( oImage )
	{
		if( oNewWindow == 0 || oNewWindow.closed )
		{
			oNewWindow = window.open ("","", "left=" + left + ", top=" + top + ", height=" + height + ", width=" + width + ", status=no, toolbar=no, menubar=no, location=no, resizable=yes", true );
			oNewWindow.document.write ("<HTML><BODY BGCOLOR=\"#EEEEEE\"><TABLE WIDTH=\"100%\" HEIGHT=\"100%\"><TR><TD WIDTH=\"100%\" VALIGN=\"MIDDLE\" ALIGN=\"CENTER\"><IMG SRC=" + oImage.src + "></TD></TR></TABLE></HTML></BODY>");
		}
		else
		{
			left = oNewWindow.screenLeft;
			top = oNewWindow.screenTop;
			height = oNewWindow.document.body.clientHeight;
			width = oNewWindow.document.body.clientWidth;
			oNewWindow.close();
			ImageClick( oImage );
		}
	}
</SCRIPT>
<!--------------------------------------------------->
