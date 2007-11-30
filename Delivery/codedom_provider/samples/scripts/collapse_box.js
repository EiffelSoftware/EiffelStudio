///////////////////////////////////////////////////////////////////////////////
// collapsebox.js : Collapsing content box script
//

var strCBPlus = "Plus";
var strCBMinus = "Minus";
var strCBDisplayNone = "None";
var strCBDisplayNormal = "";

var iCBToogleOpen = 1;
var iCBToogleClosed = -1;
var iCBToogleNotDefined = 0;

//
// Toggles contents of a block window created with `startBlock'
//
function toggleWindow (strBoxId, strLinkId)
{
	var objLink = document.getElementById (strLinkId);
	var objElm = document.getElementById (strBoxId);

	if (null != objLink && null != objElm)
	{
		var strLinkPlus = strBoxId.concat (strCBPlus);
		var strLinkMinus = strBoxId.concat (strCBMinus);
		var strTable;
		var objLinkOn;
		var objLinkOff;

		objLinkOff = objLink;
		if (strLinkId == strLinkMinus){
			objLinkOn = document.getElementById (strLinkPlus);
			strTable = strCBDisplayNone;
			storeToogleState (strBoxId, false);
		}else{
			objLinkOn = document.getElementById (strLinkMinus);
			strTable = strCBDisplayNormal;
			storeToogleState (strBoxId, true);
		}

		objLinkOn.style.display = strCBDisplayNormal;
		objLinkOff.style.display = strCBDisplayNone;
		objElm.style.display = strTable;

	}
}

//
// Returns a toggle cookie name
//
function toggleCookieName (strName)
{
	return escape ("__" + strName + "__ToggleState");
}

//
// Stores toogleState on users machines
//
function storeToogleState (strName, fDisplayed)
{
	try
	{
		var strCookieName = toggleCookieName (strName);
		var dateNow = new Date();
		var iState = iCBToogleNotDefined;

		if (fDisplayed){
			iState = iCBToogleOpen;
		}else{
			iState = iCBToogleClosed;
		}

		dateNow.setYear ((dateNow.getUTCFullYear() + 2));
		document.cookie = strCookieName + "=" + iState.toString() + "; expires=" + dateNow.toGMTString();
	}
	catch (e)
	{
	}
}

//
// Stores toogleState on users machines
//
function retrieveToogleState (strName)
{
	try
	{
		var strCookieName = toggleCookieName (strName);
		var arrItems = document.cookie. split (';');
		for (var i = 0; i < arrItems.length; i++)
		{
			var arrPair = arrItems[i].split ('=')
			if (' ' == arrPair[0].charAt (0)){
				// Remove leading whitespace
				arrPair[0] = arrPair[0].substring (1, arrPair[0].length)
			}
			if (strCookieName == arrPair[0])
			{
				if (arrPair.length > 1)
				{
					var iRes = parseInt (arrPair[1]);
					if (!isNaN (iRes)){
						return iRes;
					}
				}
			}
		}
		return iCBToogleNotDefined;
	}
	catch (e)
	{
		return iCBToogleNotDefined;
	}
}

//
// Starts content block
//
function startBlock (strTitle, strName, strLink, strImageFolder, fOpened, strWidth)
{
	var strCBPlusDisplay;
	var strCBMinusDisplay;
	var strTableDisplay;
	var iState = retrieveToogleState (strName)
	var fOpen = fOpened;

	switch (iState)
	{
		case iCBToogleOpen:
			fOpen = true;
			break;
		case iCBToogleClosed:
			fOpen = false;
			break;
		case iCBToogleNotDefined:
			// Do nothing
			break
	}

	if (fOpen)
	{
		strCBMinusDisplay = strCBDisplayNormal;
		strCBPlusDisplay = strCBDisplayNone;
		strTableDisplay = strCBDisplayNormal;
	}
	else
	{
		strCBMinusDisplay = strCBDisplayNone;
		strCBPlusDisplay = strCBDisplayNormal;
		strTableDisplay = strCBDisplayNone
	}

	document.write ("<TABLE CellSpacing=\"0\" Class=\"frame\" Width=\"" + strWidth + "\">\n");

	document.write ("<TR>\n");
	document.write ("<TD width=\"16\"><IMG Src=\"" + strImageFolder + "top_lef.gif\" width=\"16\" height=\"16\"></TD>");
	document.write ("<TD height=\"16\" background=\"" + strImageFolder + "top_mid.gif\"><IMG Src=\"" + strImageFolder + "top_mid.gif\" width=\"16\" height=\"16\"></TD>");
	document.write ("<TD width=\"24\"><IMG Src=\"" + strImageFolder + "top_rig.gif\" width=\"24\" height=\"16\"></TD>");
	document.write ("</TR>\n");

	document.write ("<TR>\n");
	document.write ("<TD width=\"16\" background=\"" + strImageFolder + "cen_lef.gif\"><IMG Src=\"" + strImageFolder + "cen_lef.gif\" width=\"16\" height=\"11\"></TD>");
	document.write ("<TD>\n");
	document.write ("<TABLE Class=\"modulehead\"><TR><TD>");
	document.write ("<A ID=\"" + strName + strCBPlus + "\" HREF=\"javascript:toggleWindow ('" + strName + "', '" + strName + strCBPlus + "');\" ONMOUSEOVER=\"window.status='Expand';return true;\" ONMOUSEOUT=\"window.status = ''; return true;\" CLASS=\"treecontrol\" ");
	document.write ("STYLE=\"Display:" + strCBPlusDisplay + "\"");
	document.write ("><IMG Class=\"toggle\" Src=\"" + strImageFolder  + "plus.png\"></A><A ID=\"" + strName + strCBMinus + "\" HREF=\"javascript:toggleWindow ('" + strName + "', '" + strName + strCBMinus + "')\" ONMOUSEOVER=\"window.status='Collapse';return true;\" ONMOUSEOUT=\"window.status = ''; return true;\" CLASS=\"treecontrol\" ");
	document.write ("STYLE=\"Display:" + strCBMinusDisplay + "\"");
	document.write ("><IMG Class=\"toggle\" Src=\"" + strImageFolder  + "minus.png\"></A>\n&nbsp;");
	document.write ("<SPAN Class=\"boxtitle\">" + strTitle + "</SPAN>");
	if (strLink != "")
		document.write ("</TD><TD Align=\"right\" NOWRAP>" + strLink)
	document.write ("</TD></TR></TABLE>");
	document.write ("</TD>\n");
	document.write ("<TD width=\"24\" background=\"" + strImageFolder + "cen_rig.gif\"><IMG Src=\"" + strImageFolder + "cen_rig.gif\" width=\"24\" height=\"11\"></TD>");
	document.write ("</TR>\n");

	document.write ("<TR>\n");
	document.write ("<TD width=\"16\" background=\"" + strImageFolder + "cen_lef.gif\"><IMG Src=\"" + strImageFolder + "cen_lef.gif\" width=\"16\" height=\"11\"></TD>");
	document.write ("<TD>\n");
	document.write ("<DIV CLASS=\"modulebody\" STYLE=\"Display:" + strTableDisplay + "\" ID=\"" + strName + "\">\n")
}

//
// End content block
//
function endBlock(strImageFolder)
{
	document.write ("</DIV>\n");
	document.write ("</TD>\n");
	document.write ("<TD width=\"24\" background=\"" + strImageFolder + "cen_rig.gif\"><IMG Src=\"" + strImageFolder + "cen_rig.gif\" width=\"24\" height=\"11\"></TD>");
	document.write ("</TR>\n");

	document.write ("<TR>\n");
	document.write ("<TD width=\"16\"><IMG Src=\"" + strImageFolder + "bot_lef.gif\" width=\"16\" height=\"16\"></TD>");
	document.write ("<TD height=\"16\" background=\"" + strImageFolder + "bot_mid.gif\"><IMG Src=\"" + strImageFolder + "bot_mid.gif\" width=\"16\" height=\"16\"></TD>");
	document.write ("<TD width=\"24\"><IMG Src=\"" + strImageFolder + "bot_rig.gif\" width=\"24\" height=\"16\"></TD>");
	document.write ("</TR>\n");

	document.write ("</TABLE>\n");
}